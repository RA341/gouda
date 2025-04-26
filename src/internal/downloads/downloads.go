package downloads

import (
	"fmt"
	"github.com/RA341/gouda/internal/config"
	dc "github.com/RA341/gouda/internal/download_clients"
	"github.com/rs/zerolog/log"
	"os"
	"path/filepath"
	"sync"
	"time"
)

type DownloadService struct {
	client     dc.DownloadClient
	db         Store
	workerChan chan interface{}
}

func NewDownloadService(db Store, client dc.DownloadClient) *DownloadService {
	srv := &DownloadService{db: db, client: client, workerChan: make(chan interface{}, 1)}
	if srv.client != nil {
		go srv.StartMonitor() // initial download check
	}
	return srv
}

func (d *DownloadService) SetClient(client dc.DownloadClient) {
	d.client = client
}

func (d *DownloadService) AddTorrent(request *Media, torrentFilePath string) error {
	if d.client == nil {
		client, err := dc.InitializeTorrentClient()
		if err != nil {
			log.Error().Err(err).Msg("torrent client is uninitialized")
			return fmt.Errorf("unable to connect to download client\n\n%v", err.Error())
		}
		d.SetClient(client)
	}

	downloadsDir, err := filepath.Abs(config.DownloadFolder.GetStr())
	if err != nil {
		log.Error().Err(err).Str("Path", config.DownloadFolder.GetStr()).Msgf("Unable to determine absolute path")
		return fmt.Errorf("unable to determine absolute path of downloads folder %s", config.DownloadFolder.GetStr())
	}

	torrentId, err := d.client.DownloadTorrent(torrentFilePath, downloadsDir, request.Category)
	log.Debug().Msgf("Sent to client %s", torrentId)
	if err != nil {
		return err
	}

	request.TorrentId = torrentId
	request.Status = "downloading"
	request.TorrentFileLocation = torrentFilePath
	request.CreatedAt = time.Now() // reset time-running

	if err = d.db.Save(request); err != nil {
		return err
	}

	go d.StartMonitor()
	return nil
}

func (d *DownloadService) StartMonitor() {
	select {
	case d.workerChan <- struct{}{}:
		log.Debug().Msgf("Starting downloads monitoring")
		d.monitorDownloads()
		_ = d.workerChan // empty channel to indicate no active monitoring is going on
		log.Debug().Msgf("Monitoring complete, reseting worker channel")
	default: // incase channel is full it means that there is already an active loop monitor
		log.Debug().Msgf("Worker is already online, nothing to do")
		return
	}
}

func (d *DownloadService) monitorDownloads() {
	if d.client == nil {
		log.Warn().Msg("unable to connect to download client, monitor will not be run")
		return
	}

	runTimeCheck := d.setupTimeCheckFunc()
	ticker := time.NewTicker(1 * time.Minute)
	defer ticker.Stop()

	for {
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

		log.Debug().Any("Media list", statuses).Msg("retrieved torrent status")

		var wg sync.WaitGroup
		for _, torrentStatus := range statuses {
			wg.Add(1)
			go d.checkStatus(torrentStatus, runTimeCheck, &wg)
		}
		wg.Wait()

		<-ticker.C // wait for ticker
	}
}

func (d *DownloadService) setupTimeCheckFunc() func(req *Media) (time.Duration, bool) {
	torrentCheckTimeout := time.Minute * config.DownloadCheckTimeout.GetDuration()
	ignoreTimeout := config.IgnoreTimeout.GetBool()
	if ignoreTimeout {
		log.Info().
			Bool("ignore_timeout", ignoreTimeout).
			Msgf("ignoring timeout, gouda will continue to monitor until it completes or errors")
	} else {
		log.Info().Msgf("Media Check timeout is set at %v", torrentCheckTimeout)
	}

	return func(req *Media) (time.Duration, bool) {
		torrentRunningDuration := time.Now().Sub(req.CreatedAt)
		if ignoreTimeout {
			return torrentRunningDuration, false
		}

		if torrentCheckTimeout < torrentRunningDuration {
			log.Error().Msgf("Maximum timeout reached abandoning check for Id: %d,  Name:%s after %s, max timeout was set to %s.\nCheck your download client or increase timeout in settings",
				req.ID,
				req.Book,
				torrentRunningDuration.String(),
				torrentCheckTimeout,
			)
			return torrentRunningDuration, true
		}

		return torrentRunningDuration, false
	}
}

func (d *DownloadService) checkStatus(torrentStatus dc.TorrentStatus, exceedsMaxRuntime func(req *Media) (time.Duration, bool), wg *sync.WaitGroup) {
	defer wg.Done()

	var requestInfo Media
	if err := d.db.GetDownloadingMediaById(torrentStatus.ID, &requestInfo); err != nil {
		log.Error().Err(err).Msgf("Unable to find torrent: %s info in request history", torrentStatus.Name)
		return
	}

	defer func() {
		_ = d.db.Save(&requestInfo) // ignore error
	}()

	if torrentStatus.DownloadComplete {
		err := d.finalizeDownload(&requestInfo, &torrentStatus)
		if err != nil {
			log.Error().Err(err).Msgf("Failed to finalize download for %s", torrentStatus.Name)
			requestInfo.Status = err.Error()
			return
		}

		// mark download as complete
		requestInfo.Status = "complete"
		return
	}

	// timeout reached
	timeRunning, exceeds := exceedsMaxRuntime(&requestInfo)
	if exceeds {
		requestInfo.Status = "Error: timeout for check reached"
		return
	}

	// incomplete download
	log.Info().Msgf("Media check for %s with status:%s\nTime running:%s, checking again in a minute",
		torrentStatus.Name, torrentStatus.Status, timeRunning.String())
}

func (d *DownloadService) GetTorrentFileLocation(request *Media, downloadFile bool) (string, error) {
	torrentDir := config.TorrentsFolder.GetStr()

	file := request.TorrentFileLocation
	if downloadFile {
		log.Info().Msgf("Media file will be downloaded %s", file)
		tmp, err := DownloadTorrentFile(request.FileLink, torrentDir)
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

func (d *DownloadService) finalizeDownload(torrentRequest *Media, torrentStatus *dc.TorrentStatus) error {
	destPath := config.CompleteFolder.GetStr()
	catPath := fmt.Sprintf("%s/%s", destPath, torrentRequest.Category)
	destPath = fmt.Sprintf("%s/%s/%s", catPath, torrentRequest.Author, torrentRequest.Book)

	torrentStatus.DownloadPath = fmt.Sprintf("%s/%s", torrentStatus.DownloadPath, torrentStatus.Name)

	log.Info().Msgf("Media %s complete, linking download location: %s <======> destination: %s", torrentStatus.Name, torrentStatus.DownloadPath, destPath)

	err := HardLinkFolder(torrentStatus.DownloadPath, destPath)
	if err != nil {
		log.Error().Err(err).Msgf("Failed to link info with id: %s", torrentRequest.TorrentId)
		return err
	}

	sourceUID := config.UserUid.GetInt()
	sourceGID := config.GroupUid.GetInt()
	log.Info().Msgf("Changing file perm to %d:%d", sourceUID, sourceGID)
	err = RecursiveChown(catPath, sourceUID, sourceGID)
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

	everySecondTicker := time.NewTicker(1 * time.Second)
	defer everySecondTicker.Stop()

	for {
		<-everySecondTicker.C

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
			continue
		}
		return activeTorrentIds, nil
	}
}

func (d *DownloadService) fetchDownloadingTorrentsIds() ([]string, error) {
	var activeDownloadIds []string
	err := d.db.GetAllDownloadingMediaIds(activeDownloadIds)
	if err != nil {
		return nil, err
	}

	return activeDownloadIds, nil
}
