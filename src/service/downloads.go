package service

import (
	"errors"
	"fmt"
	models "github.com/RA341/gouda/models"
	"github.com/rs/zerolog/log"
	"github.com/spf13/viper"
	"gorm.io/gorm"
	"io"
	"io/fs"
	"mime"
	"net/http"
	"os"
	"path"
	"path/filepath"
	"runtime"
	"sync"
	"time"
)

// run status check only the first time
// statuscheck will handle checks until all downloads are complete
var once sync.Once

func SaveTorrentReq(db *gorm.DB, request *models.RequestTorrent) error {
	res := db.Save(request)
	if res.Error != nil {
		return res.Error
	}

	log.Debug().Msgf("Saved request to db successfully")
	return nil
}

func AddTorrent(env *models.Env, request *models.RequestTorrent) error {
	torrentDir := viper.GetString("folder.torrents")

	file, err := DownloadTorrentFile(request.FileLink, torrentDir)
	if err != nil {
		return err
	}

	downloadsDir := viper.GetString("folder.downloads")
	torrentId, err := env.DownloadClient.DownloadTorrent(file, downloadsDir)
	if err != nil {
		return err
	}

	request.TorrentId = torrentId
	request.Status = "downloading"
	res := env.Database.Save(&request)
	if res.Error != nil {
		return res.Error
	}

	once.Do(func() {
		log.Debug().Msgf("Starting status check")
		go ProcessDownloads(env, torrentId, request)
	})

	return nil
}

func fetchDownloadingTorrents(db *gorm.DB) ([]models.RequestTorrent, error) {
	var activeDownloads []models.RequestTorrent

	result := db.Where("status = ?", "downloading").Find(&activeDownloads)
	if result.Error != nil {
		return activeDownloads, result.Error
	}

	return activeDownloads, nil
}

func ProcessDownloads(env *models.Env, torrentId string, torrentInfo *models.RequestTorrent) {
	defer func() {
		log.Debug().Msgf("Download process complete, reseting sync.once")
		once = sync.Once{}
	}()

	databaseTimeRunning := 0 * time.Second
	databaseCheck := 1 * time.Minute
	databaseCheckTimeout := 1 * time.Second

	log.Debug().Msgf("Torrent Check timeout is set at %v", viper.GetDuration("download.timeout"))
	torrentCheckTimeout := time.Minute * viper.GetDuration("download.timeout")

	for {
		activeTorrents, err := fetchDownloadingTorrents(env.Database)
		if err != nil {
			if databaseTimeRunning > databaseCheck {
				log.Error().Msgf("Max timeout reached Current running %s: limit: %s,Unable to get active torrents from database, stopping check",
					databaseTimeRunning.String(),
					databaseCheck.String(),
				)
				break
			}
			log.Warn().Msgf("Failed to get active torrents from database... retrying")

			databaseTimeRunning += databaseCheckTimeout
			time.Sleep(databaseCheckTimeout)
			continue
		}
		// reset database check counter
		databaseTimeRunning = time.Second * 0

		if len(activeTorrents) == 0 {
			log.Info().Msgf("No active torrents found")
			break
		}

		var torrentMap = make(map[string]*models.RequestTorrent)
		var torrentIds []string
		for _, torrent := range activeTorrents {
			torrentMap[torrent.TorrentId] = &torrent
			torrentIds = append(torrentIds, torrent.TorrentId)
		}

		status, err := env.DownloadClient.CheckTorrentStatus(torrentIds)
		if err != nil {
			log.Warn().Err(err).Msgf("Failed to check torrent status")
		}

		for _, torrentStatus := range status {
			if torrentStatus.DownloadComplete {
				log.Info().Msgf("Torrent: %s complete", torrentStatus.Name)

				// hardlink
				err := finalizeDownload(torrentInfo, &torrentStatus, torrentId)
				if err != nil {
					log.Error().Err(err).Msgf("Failed to finalize download for %s", torrentStatus.Name)
					torrentMap[torrentStatus.ID].Status = err.Error()
					env.Database.Save(torrentMap[torrentStatus.ID])
					continue
				}

				// update database entry
				torrentMap[torrentStatus.ID].Status = "complete"
				env.Database.Save(torrentMap[torrentStatus.ID])
				continue
			}

			// timeout reached
			torrentDuration := time.Duration(int(torrentMap[torrentStatus.ID].TimeRunning))
			if torrentDuration*time.Minute > torrentCheckTimeout {
				torrentMap[torrentStatus.ID].Status = "Error: timeout for check reached"
				env.Database.Save(torrentMap[torrentStatus.ID])

				log.Error().Msgf("Maximum timeout reached abandoning check for Id: %s,  Name:%s after %s, max timeout was set to %s.\nCheck your download client or increase timeout in settings",
					torrentId,
					torrentStatus.Name,
					torrentDuration.String(),
					torrentCheckTimeout,
				)
				continue
			}

			// incomplete download, add to time and move on
			torrentMap[torrentStatus.ID].TimeRunning += 1
			env.Database.Save(torrentMap[torrentStatus.ID])
			log.Info().Msgf("Torrent check for %s with status:%s\nTime running:%s, checking again in a minute",
				torrentStatus.Name, torrentStatus.Status, torrentDuration.String())
		}
	}

}

func finalizeDownload(torrentInfo *models.RequestTorrent, torrentStatus *models.TorrentStatus, torrentId string) error {
	destPath := viper.GetString("folder.defaults")
	catPath := fmt.Sprintf("%s/%s", destPath, torrentInfo.Category)
	destPath = fmt.Sprintf("%s/%s/%s", catPath, torrentInfo.Author, torrentInfo.Book)

	torrentStatus.DownloadPath = fmt.Sprintf("%s/%s", torrentStatus.DownloadPath, torrentStatus.Name)

	log.Info().Msgf("Torrent %s complete, linking to download location: %s ------> destination: %s", torrentStatus.Name, torrentStatus.DownloadPath, destPath)

	err := HardLinkFolder(torrentStatus.DownloadPath, destPath)
	if err != nil {
		log.Error().Err(err).Msgf("Failed to link info with id: %s", torrentId)
		return err
	}

	sourceUID := viper.GetInt("user.uid")
	sourceGID := viper.GetInt("user.gid")
	log.Info().Msgf("Changing file perm to %d:%d", sourceUID, sourceGID)
	err = recursiveChown(catPath, sourceUID, sourceGID)
	if err != nil {
		log.Error().Err(err).Msgf("Failed to chown info with id: %s", torrentId)
		return err
	}

	log.Info().Msgf("Download complete: %s and hardlinked to %s", torrentStatus.Name, destPath)
	return nil
}

func recursiveChown(path string, uid, gid int) error {
	// Walk the directory tree
	return filepath.Walk(path, func(name string, info os.FileInfo, err error) error {
		if err != nil {
			return err
		}

		// Change ownership of the current file/directory
		err = os.Chown(name, uid, gid)
		if err != nil {
			return fmt.Errorf("failed to chown %s: %v", name, err)
		}

		return nil
	})
}

// HardLinkFolder creates hard links of all files from source folder to target folder
// and maintains the original UID/GID
func HardLinkFolder(sourceDir, targetDir string) error {
	// Check if source directory exists
	sourceStat, err := os.Stat(sourceDir)
	if err != nil {
		return fmt.Errorf("source directory error: %w", err)
	}

	// Create target directory if it doesn't exist
	err = os.MkdirAll(targetDir, 0o775)
	if err != nil {
		return fmt.Errorf("failed to create target directory: %w", err)
	}

	// Handle based on whether source is file or directory
	if !sourceStat.IsDir() {
		// For single file, create the parent directory if needed
		sourceFile := filepath.Base(sourceDir)
		log.Debug().Msgf("Target path is: %s", sourceFile)

		targetDir = fmt.Sprintf("%s/%s", targetDir, sourceFile)
		log.Info().Err(err).Msgf("Source is a file, final dest path will be %s", targetDir)

		// Create hard link for the file
		if err := createHardLink(sourceDir, targetDir, sourceStat.Mode()); err != nil {
			return fmt.Errorf("failed to create hard link from %s to %s: %w", sourceDir, targetDir, err)
		}

		return nil
	}

	// Walk through the source directory
	return filepath.WalkDir(sourceDir, func(path string, d fs.DirEntry, err error) error {
		if err != nil {
			return err
		}

		// Get file info including system info (UID/GID)
		info, err := d.Info()
		if err != nil {
			return fmt.Errorf("failed to get file info: %w", err)
		}

		// Get relative path
		relPath, err := filepath.Rel(sourceDir, path)
		if err != nil {
			return fmt.Errorf("failed to get relative path: %w", err)
		}

		// Get target path
		targetPath := filepath.Join(targetDir, relPath)

		// If it's a directory, create it in target with proper ownership
		if d.IsDir() {
			if err := os.MkdirAll(targetPath, 0o775); err != nil {
				return fmt.Errorf("failed to create directory %s: %w", targetPath, err)
			}

			return nil
		}

		// Create hard link for files
		err = createHardLink(path, targetPath, info.Mode())
		if err != nil {
			return fmt.Errorf("failed to create hard link from %s to %s: %w", path, targetPath, err)
		}

		return nil
	})
}

// createHardLink creates a hard link with proper ownership and permissions
func createHardLink(oldPath, newPath string, mode fs.FileMode) error {
	if runtime.GOOS == "windows" {
		return errors.New("hardlinking on windows is not supported")
	}

	// Ensure the target directory exists
	targetDir := filepath.Dir(newPath)
	if err := os.MkdirAll(targetDir, 0755); err != nil {
		return err
	}

	// Remove existing file if it exists
	if err := os.Remove(newPath); err != nil && !os.IsNotExist(err) {
		return err
	}

	// Create the hard link
	if err := os.Link(oldPath, newPath); err != nil {
		return err
	}

	if err := os.Chmod(newPath, mode); err != nil {
		return fmt.Errorf("failed to set permissions: %w", err)
	}

	return nil
}

func DownloadTorrentFile(downloadLink string, downloadPath string) (string, error) {
	resp, err := http.Get(downloadLink)
	if err != nil {
		return "", fmt.Errorf("failed to make request: %v", err)
	}
	if resp.StatusCode != 200 {
		return "", fmt.Errorf("invalid http code: %d, reason: %s", resp.StatusCode, resp.Status)
	}

	defer func(Body io.ReadCloser) {
		err := Body.Close()
		if err != nil {
			log.Fatal().Err(err).Msgf("failed to close response body")
		}
	}(resp.Body)

	// Get filename from Content-Disposition header
	_, params, err := mime.ParseMediaType(resp.Header.Get("Content-Disposition"))
	filename := ""
	if err == nil && params["filename"] != "" {
		filename = params["filename"]
	} else {
		// Fallback to URL path if header not available
		filename = path.Base(downloadLink)
	}

	if err := os.MkdirAll(downloadPath, 0775); err != nil {
		return "", fmt.Errorf("failed to create directories: %v", err)
	}

	destPath := fmt.Sprintf("%s/%s", downloadPath, filename)
	file, err := os.Create(destPath)
	if err != nil {
		return "", fmt.Errorf("failed to create file: %v", err)
	}
	defer func(file *os.File) {
		err := file.Close()
		if err != nil {
			log.Fatal().Err(err).Msgf("failed to close response body")
		}
	}(file)

	_, err = io.Copy(file, resp.Body)
	if err != nil {
		return "", fmt.Errorf("failed to copy response body: %v", err)
	}

	// logs !!
	fmt.Println(filename)

	return destPath, nil
}
