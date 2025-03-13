package service

import (
	"fmt"
	"github.com/RA341/gouda/download_clients"
	models "github.com/RA341/gouda/models"
	"github.com/RA341/gouda/utils"
	"github.com/rs/zerolog/log"
	"gorm.io/gorm"
	"os"
	"path/filepath"
	"sync"
	"time"
)

type DownloadService struct {
	db     *gorm.DB
	client models.DownloadClient
	// run status check only the first time
	// statuscheck will handle checks until all downloads are complete
	once sync.Once
}

func NewDownloadService(db *gorm.DB, client models.DownloadClient) *DownloadService {
	srv := &DownloadService{db: db, client: client, once: sync.Once{}}
	if srv.client != nil {
		srv.once.Do(func() {
			log.Info().Msgf("starting intial download monitor")
			go srv.MonitorDownloads()
		})
	}

	return srv
}

func (d *DownloadService) SaveTorrentReq(request *models.RequestTorrent) error {
	res := d.db.Save(request)
	if res.Error != nil {
		return res.Error
	}

	log.Debug().Msgf("Saved request to db successfully")
	return nil
}

func (d *DownloadService) AddTorrent(request *models.RequestTorrent, torrentFilePath string) error {
	if d.client == nil {
		client, err := download_clients.InitializeTorrentClient()
		if err != nil {
			log.Error().Err(err).Msg("torrent client is uninitialized")
			return fmt.Errorf("unable to connect to download client\n\n%v", err.Error())
		}

		d.client = client
	}

	downloadsDir, err := filepath.Abs(utils.DownloadFolder.GetStr())
	if err != nil {
		log.Error().Err(err).Str("Path", utils.DownloadFolder.GetStr()).Msgf("Unable to determine absolute path")
		return fmt.Errorf("unable to determine absolute path of downloads folder %s", utils.DownloadFolder.GetStr())
	}

	torrentId, err := d.client.DownloadTorrent(torrentFilePath, downloadsDir, request.Category)
	log.Debug().Msgf("Sent to client %s", torrentId)
	if err != nil {
		return err
	}

	request.TorrentId = torrentId
	request.Status = "downloading"
	request.TorrentFileLocation = torrentFilePath
	// reset time-running
	request.TimeRunning = 0

	res := d.db.Save(&request)
	if res.Error != nil {
		return res.Error
	}

	d.once.Do(func() {
		log.Debug().Msgf("Starting downloads monitoring")
		go d.MonitorDownloads()
	})

	return nil
}

func (d *DownloadService) GetTorrentFileLocation(request *models.RequestTorrent, downloadFile bool) (string, error) {
	torrentDir := utils.TorrentsFolder.GetStr()

	file := request.TorrentFileLocation
	if downloadFile {
		log.Info().Msgf("Torrent file will be downloaded %s", file)
		tmp, err := utils.DownloadTorrentFile(request.FileLink, torrentDir)
		if err != nil {
			return "", err
		}
		file = tmp
	} else {
		log.Info().Msgf("Not downloading torrent file, checking existing torrent file location %s", file)
		_, err := os.Stat(file)
		if os.IsNotExist(err) {
			return "", fmt.Errorf("file %s does not exist", file)
		}
		if err != nil {
			log.Error().Err(err).Msgf("Unable to stat")
			return "", err
		}

		log.Debug().Msgf("Using torrent file from %s", file)
	}
	return file, nil
}

func (d *DownloadService) MonitorDownloads() {
	if d.client == nil {
		log.Warn().Msg("unable to connect to download client, monitor will not be run")
		return
	}

	defer func() {
		log.Debug().Msgf("Monitoring complete, reseting sync.once")
		d.once = sync.Once{}
	}()

	torrentCheckTimeout := time.Minute * utils.DownloadCheckTimeout.GetDuration()
	ignoreTimeout := utils.IgnoreTimeout.GetBool()
	if ignoreTimeout {
		log.Info().
			Bool("ignore_timeout", ignoreTimeout).
			Msgf("ignoring timeout, gouda will continue to monitor until it completes or errors")
	} else {
		log.Info().Msgf("Torrent Check timeout is set at %v", torrentCheckTimeout)
	}

	ticker := time.NewTicker(2 * time.Second)
	defer ticker.Stop()

	for {
		<-ticker.C // wait for ticker

		activeTorrentIds, err := d.getActiveTorrentsLoop()
		if err != nil {
			return
		}

		if len(activeTorrentIds) == 0 {
			log.Info().Msgf("No active torrents found")
			return
		}

		statuses, err := d.client.CheckTorrentStatus(activeTorrentIds)
		if err != nil {
			log.Warn().Err(err).Msgf("Failed to check torrent status, retrying")
			continue
		}

		log.Debug().Any("Torrent list", statuses).Msg("retrieved torrent status")

		d.CheckStatus(statuses, ignoreTimeout, torrentCheckTimeout)
	}
}

func (d *DownloadService) CheckStatus(statuses []models.TorrentStatus, ignoreTimeout bool, torrentCheckTimeout time.Duration) {
	for _, torrentStatus := range statuses {
		var requestInfo models.RequestTorrent

		resp := d.db.
			Where("torrent_id = ?", torrentStatus.ID).
			Where("status = ?", "downloading").
			First(&requestInfo)

		if resp.Error != nil {
			log.Error().Err(resp.Error).Msgf("Unable to find torrent: %s info in request history", torrentStatus.Name)
			continue
		}

		if torrentStatus.DownloadComplete {
			err := d.finalizeDownload(&requestInfo, &torrentStatus)
			if err != nil {
				log.Error().Err(err).Msgf("Failed to finalize download for %s", torrentStatus.Name)
				requestInfo.Status = err.Error()
				d.db.Save(requestInfo)
				continue
			}

			// mark download as complete
			requestInfo.Status = "complete"
			d.db.Save(requestInfo)
			continue
		}

		// timeout reached
		torrentDuration := time.Duration(int(requestInfo.TimeRunning)) * time.Minute
		if !ignoreTimeout && torrentDuration > torrentCheckTimeout {
			requestInfo.Status = "Error: timeout for check reached"
			d.db.Save(requestInfo)

			log.Error().Msgf("Maximum timeout reached abandoning check for Id: %s,  Name:%s after %s, max timeout was set to %s.\nCheck your download client or increase timeout in settings",
				torrentStatus.ID,
				torrentStatus.Name,
				torrentDuration.String(),
				torrentCheckTimeout,
			)
			continue
		}

		// incomplete download, add to time and move on
		requestInfo.TimeRunning += 1
		d.db.Save(requestInfo)
		log.Info().Msgf("Torrent check for %s with status:%s\nTime running:%s, checking again in a minute",
			torrentStatus.Name, torrentStatus.Status, torrentDuration.String())
	}
}

func (d *DownloadService) finalizeDownload(torrentRequest *models.RequestTorrent, torrentStatus *models.TorrentStatus) error {
	destPath := utils.CompleteFolder.GetStr()
	catPath := fmt.Sprintf("%s/%s", destPath, torrentRequest.Category)
	destPath = fmt.Sprintf("%s/%s/%s", catPath, torrentRequest.Author, torrentRequest.Book)

	torrentStatus.DownloadPath = fmt.Sprintf("%s/%s", torrentStatus.DownloadPath, torrentStatus.Name)

	log.Info().Msgf("Torrent %s complete, linking download location: %s ------> destination: %s", torrentStatus.Name, torrentStatus.DownloadPath, destPath)

	err := utils.HardLinkFolder(torrentStatus.DownloadPath, destPath)
	if err != nil {
		log.Error().Err(err).Msgf("Failed to link info with id: %s", torrentRequest.TorrentId)
		return err
	}

	sourceUID := utils.UserUid.GetInt()
	sourceGID := utils.GroupUid.GetInt()
	log.Info().Msgf("Changing file perm to %d:%d", sourceUID, sourceGID)
	err = utils.RecursiveChown(catPath, sourceUID, sourceGID)
	if err != nil {
		log.Error().Err(err).Msgf("Failed to chown info with id: %s", torrentRequest.TorrentId)
		return err
	}

	log.Info().Msgf("Download complete: %s and hardlinked to %s", torrentStatus.Name, destPath)
	return nil
}

// getActiveTorrentsLoop loops until we get the list of ids to check for or until max timeout is reached
func (d *DownloadService) getActiveTorrentsLoop() ([]string, error) {
	// counter for current loop
	databaseTimeRunning := 0 * time.Second
	// max limit to check
	databaseCheckLimit := 1 * time.Minute
	// amount of time to pause the check for
	databaseCheckTimeout := 1 * time.Second

	for {
		activeTorrentIds, err := d.fetchDownloadingTorrentsIds()
		if err != nil {
			if databaseTimeRunning > databaseCheckLimit {
				log.Error().Msgf("Max timeout reached Current running %s: limit: %s,Unable to get active torrents from database, stopping check, verify your database connection",
					databaseTimeRunning.String(),
					databaseCheckLimit.String(),
				)

				return []string{}, fmt.Errorf("unable to get active torrents even after %s", databaseCheckLimit.String())
			}
			log.Warn().Msgf("Failed to get active torrents from database... retrying")

			databaseTimeRunning += databaseCheckTimeout
			time.Sleep(databaseCheckTimeout)
			continue
		}
		return activeTorrentIds, nil
	}
}

func (d *DownloadService) fetchDownloadingTorrentsIds() ([]string, error) {
	var activeDownloadIds []string

	result := d.db.Model(&models.RequestTorrent{}).
		Where("status = ?", "downloading").
		Pluck("torrent_id", &activeDownloadIds)

	if result.Error != nil {
		return activeDownloadIds, result.Error
	}

	return activeDownloadIds, nil
}

func (d *DownloadService) SetClient(client models.DownloadClient) {
	d.client = client
}
