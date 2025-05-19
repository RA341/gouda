package downloads

import (
	"fmt"
	"github.com/RA341/gouda/internal/config"
	dc "github.com/RA341/gouda/internal/downloads/clients"
	fu "github.com/RA341/gouda/pkg/file_utils"
	"github.com/RA341/gouda/pkg/magnet"
	"github.com/rs/zerolog/log"
	"path/filepath"
	"resty.dev/v3"
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
		log.Warn().Err(err).Msg("download client is uninitialized")
		return err
	}

	magnetLink, err := d.getMagnetLink(media)
	if err != nil {
		return fmt.Errorf("unable to get torrent file location\n\n%v", err.Error())
	}
	media.TorrentMagentLink = magnetLink
	log.Debug().Str("magnet_link", media.TorrentMagentLink).Msgf("using torrent file")

	downloadsDir, err := filepath.Abs(config.DownloadFolder.GetStr())
	if err != nil {
		return fmt.Errorf("unable to determine absolute path: %s", config.DownloadFolder.GetStr())
	}

	torrentId, err := d.client.DownloadTorrentWithFile(media.TorrentMagentLink, downloadsDir, media.Category)
	if err != nil {
		return err
	}
	log.Debug().Msgf("Sent media to client %s", torrentId)

	media.TorrentId = torrentId
	media.Status = Downloading
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
	if err := d.verifyClient(); err != nil {
		log.Warn().Err(err).Msgf("download client is uninitlized")
		return
	}

	torrentCheckTimeout := time.Minute * config.DownloadCheckTimeout.GetDuration()
	ignoreTimeout := config.IgnoreTimeout.GetBool()
	timeoutFunc := d.setupTimeoutFunc(ignoreTimeout, torrentCheckTimeout)

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

		statuses, err := d.client.GetTorrentStatus(activeTorrentIds...)
		if err != nil {
			log.Warn().Err(err).Msgf("Failed to check torrent status, retrying in minute")
			continue
		}
		log.Debug().Any("Media list", statuses).Msg("retrieved torrent status")

		var wg sync.WaitGroup
		for _, torrentStatus := range statuses {
			wg.Add(1)
			go d.checkDownload(&torrentStatus, timeoutFunc, &wg)
		}
		wg.Wait()

		<-ticker.C // wait for ticker
	}
}

func (d *DownloadService) checkDownload(torrentStatus *dc.TorrentStatus, exceedsDownloadTimeout func(req *Media) (time.Duration, bool), wg *sync.WaitGroup) {
	defer wg.Done()

	media, err := d.db.GetMediaByTorrentId(torrentStatus.ID)
	if err != nil {
		log.Error().Err(err).Msgf("Unable to find torrent: %s info in database", torrentStatus.Name)
		return
	}

	defer func() {
		_ = d.db.Save(media) // ignore error
	}()

	if torrentStatus.ParsedStatus == dc.Complete {
		if err := d.finalizeDownload(media, torrentStatus); err != nil {
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
	log.Info().Msgf("check for %s with status:%s\nTime running:%s, checking again in a minute",
		torrentStatus.Name, torrentStatus.ClientStatus, timeRunning.String())
}

func (d *DownloadService) setupTimeoutFunc(ignoreTimeout bool, torrentCheckTimeout time.Duration) func(media *Media) (time.Duration, bool) {
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
		log.Warn().Err(err).
			Str("src", torrentStatus.DownloadPath).Str("dest", destPath).
			Msg("Unable to hardlink")

		log.Info().Msg("trying copy instead")
		err := fu.CopyFolder(torrentStatus.DownloadPath, destPath)
		if err != nil {
			return fmt.Errorf("failed to hardlink and copy folder: %v", err)
		}
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
		Msgf("download complete")

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

func (d *DownloadService) getMagnetLink(media *Media) (string, error) {
	if media.TorrentMagentLink != "" {
		return media.TorrentMagentLink, nil
	}

	magnetLink, err := downloadAndConvertToMagnetLink(media.FileLink)
	if err != nil {
		return "", err
	}

	return magnetLink, nil
}

// verifyClient ensures a valid torrent client is available
func (d *DownloadService) verifyClient() error {
	if d.client == nil {
		client, err := dc.InitializeTorrentClient()
		if err != nil {
			return fmt.Errorf("unable to connect to download client\n\n%v", err.Error())
		}
		d.SetClient(client)
	}
	return nil
}

// downloadLink must be a download url to a torrent file,
// or it will fail to convert even if file downloads fine
func downloadAndConvertToMagnetLink(downloadLink string) (string, error) {
	log.Info().Msg("downloading torrent file")
	resp, err := resty.New().R().Get(downloadLink)
	if err != nil {
		return "", err
	}

	if resp.IsError() {
		return "", fmt.Errorf("error downloading file, code: %d, message: %s, body: %s", resp.StatusCode(), resp.Status(), resp.String())
	}

	toMagnet, err := magnet.TorrentFileToMagnet(resp.Body)
	if err != nil {
		return "", fmt.Errorf("unable to convert to magnet: %v", err)
	}

	return toMagnet, nil
}
