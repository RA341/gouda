package downloads

import (
	"fmt"
	"github.com/RA341/gouda/internal/config"
	dc "github.com/RA341/gouda/internal/downloads/clients"
	fu "github.com/RA341/gouda/pkg/file_utils"
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
	srv := &DownloadService{
		client: client,
		db:     db,
		workerChan: make(
			chan interface{},
			1,
		),
	}
	if srv.client != nil {
		go srv.startMonitor() // initial download check
	}
	return srv
}

func (d *DownloadService) SetClient(client dc.DownloadClient) {
	d.client = client
}

func (d *DownloadService) DownloadMedia(media *Media, downloadTorrentFile bool) error {
	if err := d.verifyClient(); err != nil {
		return err
	}

	torrentFile, err := d.getTorrentFilePath(media, downloadTorrentFile)
	if err != nil {
		return fmt.Errorf("unable to get torrent file location\n\n%v", err.Error())
	}

	downloadsDir, err := filepath.Abs(config.DownloadFolder.GetStr())
	if err != nil {
		return fmt.Errorf("unable to determine absolute path of downloads folder %s", config.DownloadFolder.GetStr())
	}

	torrentId, err := d.client.DownloadTorrent(torrentFile, downloadsDir, media.Category)
	if err != nil {
		return err
	}
	log.Debug().Msgf("Sent media to client %s", torrentId)

	media.TorrentId = torrentId
	media.Status = Downloading
	media.TorrentFileLocation = torrentFile
	media.CreatedAt = time.Now() // reset time-running

	if err = d.db.Save(media); err != nil {
		return err
	}

	go d.startMonitor()
	return nil
}

func (d *DownloadService) startMonitor() {
	select {
	case d.workerChan <- struct{}{}:
		log.Debug().Msgf("Starting download monitor")
		d.monitorDownloads()
		_ = d.workerChan // empty channel, monitoring complete
		log.Debug().Msgf("Monitoring complete, reseting worker")
	default: // channel is full, means that there is already an active monitor
		log.Debug().Msgf("Worker is already online, nothing to do")
		return
	}
}

func (d *DownloadService) monitorDownloads() {
	if d.client == nil {
		log.Warn().Msg("download client is uninitialized, monitor will not be run, THIS SHOULD NEVER HAPPEN")
		return
	}

	timeoutFunc := d.setupTimeoutFunc()
	ticker := time.NewTicker(1 * time.Minute) // run check every minute
	defer ticker.Stop()

	for {
		activeTorrentIds, err := d.getDownloadingMedia()
		if err != nil {
			log.Error().Err(err).Msgf("unable to get downloading media from db")
			return
		}

		if len(activeTorrentIds) == 0 {
			log.Info().Msgf("No active torrents found")
			return
		}

		statuses, err := d.client.GetTorrentStatus(activeTorrentIds)
		if err != nil {
			log.Warn().Err(err).Msgf("Failed to check torrent status, retrying in minute")
			continue
		}
		log.Debug().Any("Media list", statuses).Msg("retrieved torrent status")

		var wg sync.WaitGroup
		for _, torrentStatus := range statuses {
			wg.Add(1)
			go d.checkDownload(torrentStatus, timeoutFunc, &wg)
		}
		wg.Wait()

		<-ticker.C // wait for ticker
	}
}

func (d *DownloadService) checkDownload(torrentStatus dc.TorrentStatus, exceedsDownloadTimeout func(req *Media) (time.Duration, bool), wg *sync.WaitGroup) {
	defer wg.Done()

	media, err := d.db.GetMediaByTorrentId(torrentStatus.ID)
	if err != nil {
		log.Error().Err(err).Msgf("Unable to find torrent: %s info in database", torrentStatus.Name)
		return
	}

	defer func() {
		_ = d.db.Save(media) // ignore error
	}()

	if torrentStatus.DownloadComplete {
		if err := d.finalizeDownload(media, &torrentStatus); err != nil {
			log.Error().Err(err).Msgf("Failed to finalize download for %s", torrentStatus.Name)
			media.Status = Error
			media.ErrorMessage = err.Error()
			return
		}

		// mark download as complete
		media.Status = Complete
		return
	}

	// timeout reached
	timeRunning, exceeds := exceedsDownloadTimeout(media)
	if exceeds {
		media.Status = Error
		media.ErrorMessage = fmt.Sprintf("torrent exceded timeout: %s", timeRunning.String())
		return
	}

	// incomplete download
	log.Info().Msgf("Media check for %s with status:%s\nTime running:%s, checking again in a minute",
		torrentStatus.Name, torrentStatus.Status, timeRunning.String())
}

func (d *DownloadService) setupTimeoutFunc() func(media *Media) (time.Duration, bool) {
	torrentCheckTimeout := time.Minute * config.DownloadCheckTimeout.GetDuration()
	ignoreTimeout := config.IgnoreTimeout.GetBool()
	if ignoreTimeout {
		log.Info().
			Bool("ignore timeout", ignoreTimeout).
			Msgf("downloads will be monitored until compeletion; no time limit")
	} else {
		log.Info().Msgf("download timeout is set at %v", torrentCheckTimeout)
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

func (d *DownloadService) finalizeDownload(torrentRequest *Media, torrentStatus *dc.TorrentStatus) error {
	categoryPath := fmt.Sprintf("%s/%s", config.CompleteFolder.GetStr(), torrentRequest.Category)
	destPath := fmt.Sprintf("%s/%s/%s", categoryPath, torrentRequest.Author, torrentRequest.Book)

	torrentStatus.DownloadPath = fmt.Sprintf("%s/%s", torrentStatus.DownloadPath, torrentStatus.Name)

	err := fu.HardLinkFolder(torrentStatus.DownloadPath, destPath)
	if err != nil {
		return fmt.Errorf("failed to hardlink download: %v", err)
	}

	sourceUID := config.UserUid.GetInt()
	sourceGID := config.GroupUid.GetInt()
	log.Info().Msgf("Changing file perm to %d:%d", sourceUID, sourceGID)

	err = fu.RecursiveChown(categoryPath, sourceUID, sourceGID)
	if err != nil {
		return fmt.Errorf("failed to chown download: %v", err)
	}

	log.Info().
		Str("name", torrentStatus.Name).
		Str("download path", torrentStatus.DownloadPath).
		Str("destination", destPath).
		Msgf("Download complete and finalized")

	return nil
}

// getDownloadingMedia gets a list of Media.TorrentId where Media.Status == Downloading
func (d *DownloadService) getDownloadingMedia() ([]string, error) {
	activeDownloadIds, err := d.db.GetDownloadingMediaTorrentIdList()
	if err != nil {
		return []string{}, err
	}

	return activeDownloadIds, nil
}

func (d *DownloadService) getTorrentFilePath(media *Media, downloadFile bool) (string, error) {
	file := media.TorrentFileLocation
	if downloadFile {
		log.Info().Msgf("Media file will be downloaded %s", file)
		tmp, err := fu.DownloadTorrentFile(media.FileLink, config.TorrentsFolder.GetStr())
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

// verifyClient ensures a valid torrent client is available
func (d *DownloadService) verifyClient() error {
	if d.client == nil {
		client, err := dc.InitializeTorrentClient()
		if err != nil {
			log.Error().Err(err).Msg("torrent client is uninitialized")
			return fmt.Errorf("unable to connect to download client\n\n%v", err.Error())
		}
		d.SetClient(client)
	}
	return nil
}
