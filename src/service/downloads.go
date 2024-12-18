package service

import (
	"errors"
	"fmt"
	"github.com/RA341/gouda/download_clients"
	"github.com/rs/zerolog/log"
	"github.com/spf13/viper"
	"io"
	"io/fs"
	"mime"
	"net/http"
	"os"
	"path"
	"path/filepath"
	"runtime"
	"time"
)

func ProcessDownloads(clientPointer *download_clients.DownloadClient, torrentId string, author, book, category string) {
	downloadClient := *clientPointer

	timeRunning := time.Second * 0
	timeout := time.Minute * viper.GetDuration(fmt.Sprintf("download.timeout"))

	for {
		log.Info().Msgf("getting torrent info with id:%s", torrentId)
		info, err := downloadClient.CheckTorrentStatus(torrentId)
		if err != nil {
			log.Warn().Msgf("Failed to get info with id: %s", torrentId)
			break
		} else {
			if info.Status == "seeding" {
				destPath := viper.GetString("folder.defaults")
				catPath := fmt.Sprintf("%s/%s", destPath, category)
				destPath = fmt.Sprintf("%s/%s/%s", catPath, author, book)

				info.DownloadPath = fmt.Sprintf("%s/%s", info.DownloadPath, info.Name)

				log.Info().Msgf("Torrent %s complete, linking to download location: %s ------> destination: %s", info.Name, info.DownloadPath, destPath)

				err := HardLinkFolder(info.DownloadPath, destPath)
				if err != nil {
					log.Error().Err(err).Msgf("Failed to link info with id: %d", torrentId)
					break
				}

				sourceUID := viper.GetInt("user.uid")
				sourceGID := viper.GetInt("user.gid")
				log.Info().Msgf("Changing file perm to %d:%d", sourceUID, sourceGID)
				err = recursiveChown(catPath, sourceUID, sourceGID)
				if err != nil {
					log.Error().Err(err).Msgf("Failed to chown info with id: %d", torrentId)
					break
				}

				log.Info().Msgf("Download complete: %s and hardlinked to %s", info.Name, destPath)
				break
			}

			if timeout < timeRunning {
				log.Error().Msgf("Maximum timeout reached abandoning check for %d:%s after %s, max timeout was set to %s, check your torrent downloadClient or increase timeout in settings", torrentId, info.Name, timeRunning.String(), timeout)
				break
			}

			timeRunning = timeRunning + 1*time.Minute
			log.Info().Msgf("Torrent check for %s with status:%s checking again in a minute", info.Name, info.Status)
			time.Sleep(1 * time.Minute)
		}
	}
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

	sourceUID := viper.GetInt("user.uid")
	sourceGID := viper.GetInt("user.gid")

	// Create target directory if it doesn't exist
	err = os.MkdirAll(targetDir, 0o770)
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
		if err := createHardLink(sourceDir, targetDir, sourceUID, sourceGID, sourceStat.Mode()); err != nil {
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
			if err := os.MkdirAll(targetPath, 0o770); err != nil {
				return fmt.Errorf("failed to create directory %s: %w", targetPath, err)
			}

			return nil
		}

		// Create hard link for files
		err = createHardLink(path, targetPath, viper.GetInt("user.uid"), viper.GetInt("user.gid"), info.Mode())
		if err != nil {
			return fmt.Errorf("failed to create hard link from %s to %s: %w", path, targetPath, err)
		}

		return nil
	})
}

// createHardLink creates a hard link with proper ownership and permissions
func createHardLink(oldPath, newPath string, uid, gid int, mode fs.FileMode) error {
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

	fmt.Println("Created dit")

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
