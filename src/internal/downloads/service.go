package downloads

import (
	"fmt"
	"io"
	"path/filepath"
	"sync"
	"time"

	"github.com/RA341/gouda/internal/config"
	dc "github.com/RA341/gouda/internal/downloads/clients"
	fu "github.com/RA341/gouda/pkg/file_utils"
	"github.com/RA341/gouda/pkg/magnet"
	"github.com/rs/zerolog/log"
	"resty.dev/v3"
)

type DownloadService struct {
	db     Store
	client dc.DownloadClient

	torrentCli    *config.TorrentClient
	perms         *config.UserPermissions
	dirs          *config.Directories
	checkInterval time.Duration
	timout        time.Duration
	ignoreTimeout bool

	workerChan chan interface{}
}

func NewDownloadService(conf *config.GoudaConfig, db Store, tor *config.TorrentClient, client dc.DownloadClient) *DownloadService {
	limit, err := conf.Downloader.GetLimit()
	if err != nil {
		log.Fatal().Err(err).Msg("Invalid time string")
	}

	srv := &DownloadService{
		db:            db,
		client:        client,
		perms:         &conf.Permissions,
		dirs:          &conf.Dir,
		checkInterval: 30 * time.Second,
		ignoreTimeout: conf.Downloader.IgnoreTimeout,
		timout:        limit,
		workerChan:    make(chan interface{}, 1),
	}
	if srv.client != nil {
		go srv.startMonitor() // initial download check
	}
	return srv
}

// TestAndUpdateClient tests the client first then updates the torrent client if successful
func (d *DownloadService) TestAndUpdateClient(client *config.TorrentClient) error {
	newClient, err := d.TestClient(client)
	if err != nil {
		return err
	}

	d.client = newClient
	return nil
}

func (d *DownloadService) TestClient(client *config.TorrentClient) (dc.DownloadClient, error) {
	newClient, err := dc.TestTorrentClient(client)
	if err != nil {
		return nil, fmt.Errorf("unable to connect torrent client: %v", err)
	}
	return newClient, nil
}

func (d *DownloadService) DownloadMedia(media *Media) error {
	if err := d.verifyClient(); err != nil {
		log.Warn().Err(err).Msg("download client is uninitialized")
		return err
	}

	magnetLink, err := getMagnetLink(media)
	if err != nil {
		return fmt.Errorf("unable to get torrent magnet url: %v", err.Error())
	}
	media.TorrentMagentLink = magnetLink
	log.Debug().Str("magnet_link", media.TorrentMagentLink).Msg("using magnet URL")

	downloadsDir, err := filepath.Abs(d.dirs.DownloadDir)
	if err != nil {
		return fmt.Errorf("unable to determine absolute path: %s", d.dirs.DownloadDir)
	}

	torrentId, err := d.client.DownloadTorrentWithMagnet(media.TorrentMagentLink, downloadsDir, media.Category)
	if err != nil {
		return err
	}
	log.Debug().Str("torrent_id", torrentId).Msg("Sent media to client")

	media.TorrentId = torrentId
	media.CreatedAt = time.Now() // reset time-running for timeout check
	media.MarkDownloading()

	if err = d.db.Save(media); err != nil {
		return err
	}

	go d.startMonitor()
	return nil
}

func (d *DownloadService) startMonitor() {
	select {
	case d.workerChan <- struct{}{}:
		log.Debug().Msg("Starting download monitor")
		d.monitorDownloads()
		_ = d.workerChan // empty channel, monitoring complete
		log.Debug().Msg("Monitoring complete, resetting worker")
	default: // channel is full, means that there is already an active monitor
		log.Debug().Msg("Worker is already online, nothing to do")
		return
	}
}

func (d *DownloadService) monitorDownloads() {
	if err := d.verifyClient(); err != nil {
		log.Warn().Err(err).Msg("download client is uninitialized")
		return
	}

	timeoutFunc := d.setupTimeoutFunc()

	ticker := time.NewTicker(d.checkInterval) // run check every minute
	defer ticker.Stop()
	for {
		downloadingMedia, err := d.getDownloadingMedia()
		if err != nil {
			log.Error().Err(err).Msg("unable to get downloading media from db")
			return
		}

		if len(downloadingMedia) == 0 {
			log.Info().Msg("No active downloads found")
			return
		}

		torrentIds := getKeys(downloadingMedia)
		statuses, err := d.client.GetTorrentStatus(torrentIds...)
		if err != nil {
			log.Warn().Err(err).Msg("Failed to check torrent status, retrying in minute")
			continue
		}
		log.Debug().Any("Media list", statuses).Msg("retrieved torrent status")

		var wg sync.WaitGroup
		for _, torrent := range statuses {
			media, ok := downloadingMedia[torrent.ID]
			if !ok {
				log.Warn().Str("torrent_ID", torrent.ID).Msg("Media not found for torrentID, THIS SHOULD NEVER HAPPEN OPEN A BUG REPORT, skipping check...")
				continue
			}

			wg.Add(1)
			go d.checkDownload(&media, &torrent, timeoutFunc, &wg)
		}
		wg.Wait()

		<-ticker.C // wait for ticker
	}
}

func (d *DownloadService) checkDownload(media *Media, torrentStatus *dc.TorrentStatus, checkTimeout func(req *Media) (time.Duration, bool), wg *sync.WaitGroup) {
	defer func() {
		_ = d.db.Save(media)
		wg.Done()
	}()

	if torrentStatus.ParsedStatus == dc.Complete {
		log.Info().Str("Media", media.Book).Msg("Download complete, finalizing media...")
		err := d.finalizeDownload(media, torrentStatus)
		if err != nil {
			log.Error().Err(err).
				Any("torrent", torrentStatus).
				Any("media", media).
				Msg("Failed to finalize download for media")

			media.MarkError(err)
			return
		}
		media.MarkComplete()
		return
	}

	if torrentStatus.ParsedStatus == dc.Error {
		log.Error().
			Str("Media", media.Book).
			Msg("Download failed, check your torrent client")
		media.MarkError(fmt.Errorf("download failed, check your client: %v", torrentStatus.ClientStatus))
		return
	}

	// timeout reached
	timeRunning, exceeds := checkTimeout(media)
	if exceeds {
		media.MarkError(fmt.Errorf("download taking too long, (active for %s)", timeRunning.String()))
		return
	}

	// incomplete download
	log.Info().
		Str("torrent_name", torrentStatus.Name).
		Str("download_status", torrentStatus.ClientStatus).
		Dur("time_running", timeRunning).
		Msg("torrent incomplete, checking again in a minute")
}

func (d *DownloadService) finalizeDownload(torrentRequest *Media, torrentStatus *dc.TorrentStatus) error {
	categoryPath := fmt.Sprintf("%s/%s", d.dirs.CompleteDir, torrentRequest.Category)
	destPath := fmt.Sprintf("%s/%s/%s", categoryPath, torrentRequest.Author, torrentRequest.Book)
	torrentStatus.DownloadPath = fmt.Sprintf("%s/%s", torrentStatus.DownloadPath, torrentStatus.Name)

	err := fu.HardLinkFolder(torrentStatus.DownloadPath, destPath)
	if err != nil {
		log.Warn().Err(err).
			Str("src", torrentStatus.DownloadPath).
			Str("dest", destPath).
			Msg("unable to hardlink")

		log.Info().Msg("trying to copy instead")
		if err = fu.CopyFolder(torrentStatus.DownloadPath, destPath); err != nil {
			return fmt.Errorf("failed to copy folder: %v", err)
		}
	}

	sourceUID := d.perms.UID
	sourceGID := d.perms.GID
	log.Info().Int("UID", sourceUID).Int("GID", sourceGID).Msg("Changing file perm")
	if err = fu.RecursiveChown(categoryPath, sourceUID, sourceGID); err != nil {
		return fmt.Errorf("failed to chown download: %v", err)
	}

	log.Info().
		Str("name", torrentStatus.Name).
		Str("download_path", torrentStatus.DownloadPath).
		Str("final_destination", destPath).
		Msg("download complete and processed")

	return nil
}

func (d *DownloadService) setupTimeoutFunc() func(media *Media) (time.Duration, bool) {
	ignoreTimeout := d.ignoreTimeout
	torrentCheckTimeout := d.timout

	if ignoreTimeout {
		log.Info().
			Bool("ignore_timeout", ignoreTimeout).
			Msg("downloads will be monitored until completion; no time limit")

		return func(media *Media) (time.Duration, bool) {
			return time.Now().Sub(media.CreatedAt), false
		}
	}

	log.Info().Str("timeout", torrentCheckTimeout.String()).Msg("download timeout is set to...")
	return func(media *Media) (time.Duration, bool) {
		torrentRunningDuration := time.Now().Sub(media.CreatedAt)

		if torrentCheckTimeout < torrentRunningDuration {
			log.Error().
				Str("name", media.Book).
				Dur("time_running", torrentRunningDuration).
				Dur("max_timeout", torrentCheckTimeout).
				Msg("Maximum timeout reached abandoning check for media" +
					"\nCheck your download client or increase timeout in settings")
			return torrentRunningDuration, true
		}

		return torrentRunningDuration, false
	}
}

// getDownloadingMedia returns a map [Media.TorrentId] = Media where Media.Status == Downloading
func (d *DownloadService) getDownloadingMedia() (map[string]Media, error) {
	downloadingMedia, err := d.db.GetDownloadingMedia()
	if err != nil {
		return nil, err
	}

	var mediaMap = make(map[string]Media, len(downloadingMedia))
	for _, med := range downloadingMedia {
		mediaMap[med.TorrentId] = med
	}

	return mediaMap, nil
}

// verifyClient ensures a valid torrent client is available
func (d *DownloadService) verifyClient() error {
	if d.client == nil {
		client, err := dc.InitializeTorrentClient(d.torrentCli)
		if err != nil {
			return fmt.Errorf("unable to connect to download client\n\n%v", err.Error())
		}
		d.client = client
	}
	return nil
}

func getMagnetLink(media *Media) (string, error) {
	if media.TorrentMagentLink != "" {
		return media.TorrentMagentLink, nil
	}

	magnetLink, err := downloadAndConvertToMagnetLink(media.FileLink)
	if err != nil {
		return "", err
	}

	return magnetLink, nil
}

func getMagnetLinkDirect(media *Media, torrentFileBytes io.ReadCloser) (string, error) {
	if media.TorrentMagentLink != "" {
		return media.TorrentMagentLink, nil
	}

	toMagnet, err := magnet.TorrentFileToMagnet(torrentFileBytes)
	if err != nil {
		return "", fmt.Errorf("unable to convert to magnet: %v", err)
	}

	return toMagnet, nil
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

func getKeys(downloadingMedia map[string]Media) []string {
	var torrentIds = make([]string, 0, len(downloadingMedia))
	for key := range downloadingMedia {
		torrentIds = append(torrentIds, key)
	}
	return torrentIds
}
