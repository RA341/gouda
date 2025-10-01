package downloads

import (
	"fmt"
	"io"
	"path/filepath"
	"runtime"
	"strings"
	"sync"
	"time"

	dc "github.com/RA341/gouda/internal/downloads/clients"
	"github.com/RA341/gouda/internal/info"
	sc "github.com/RA341/gouda/internal/server_config"
	fu "github.com/RA341/gouda/pkg/file_utils"
	"github.com/RA341/gouda/pkg/magnet"
	"github.com/rs/zerolog/log"
	"resty.dev/v3"
)

type TorrentClientProvider func() *sc.TorrentClient
type DownloaderProvider func() *sc.Downloader
type UserPermissionsProvider func() *sc.UserPermissions
type DirectoryProvider func() *sc.Directories

type Service struct {
	db Store

	torrentClient dc.DownloadClient
	torrentConfig TorrentClientProvider

	perms      UserPermissionsProvider
	dirs       DirectoryProvider
	downloader DownloaderProvider

	checkInterval time.Duration
	workerChan    chan interface{}
}

func NewService(
	db Store,
	torConfig TorrentClientProvider,
	perms UserPermissionsProvider,
	dir DirectoryProvider,
	downloader DownloaderProvider,
) *Service {
	srv := &Service{
		db:            db,
		torrentConfig: torConfig,
		perms:         perms,
		dirs:          dir,
		downloader:    downloader,

		workerChan: make(chan interface{}, 1),
	}

	// initialize client if possible
	err := srv.TestAndUpdateClient()
	if err != nil {
		log.Warn().Err(err).Msg("invalid download client, check your config")
	}

	if srv.torrentClient != nil {
		go srv.startMonitor() // initial download check
	}

	return srv
}

// TestAndUpdateClient tests the torrentClient first then updates the torrent torrentClient if successful
func (d *Service) TestAndUpdateClient() error {
	newClient, err := d.TestClient(d.torrentConfig())
	if err != nil {
		return err
	}

	d.torrentClient = newClient
	return nil
}

func (d *Service) TestClient(client *sc.TorrentClient) (dc.DownloadClient, error) {
	newClient, err := dc.TestTorrentClient(client)
	if err != nil {
		return nil, fmt.Errorf("unable to connect torrent torrentClient: %v", err)
	}
	return newClient, nil
}

func (d *Service) ValidateClient(client *sc.TorrentClient) error {
	_, err := d.TestClient(client)
	return err
}

func (d *Service) DownloadMedia(media *Media) error {
	if err := d.verifyClient(); err != nil {
		log.Warn().Err(err).Msg("download torrentClient is uninitialized")
		return err
	}

	magnetLink, err := getMagnetLink(media)
	if err != nil {
		return fmt.Errorf("unable to get torrent magnet url: %v", err.Error())
	}
	media.TorrentMagentLink = magnetLink
	log.Debug().Str("magnet_link", media.TorrentMagentLink).Msg("using magnet URL")

	downloadsDir, err := filepath.Abs(d.dirs().DownloadDir)
	if err != nil {
		return fmt.Errorf("unable to determine absolute path: %s", d.dirs().DownloadDir)
	}

	if info.IsDev() && runtime.GOOS == "windows" {
		// converts windows to a wsl path to test with the test transmission client running in docker
		pathSplit := strings.Split(filepath.ToSlash(downloadsDir), ":/")
		wslPath := "/mnt/" + strings.ToLower(pathSplit[0]) + "/" + (pathSplit[1])

		downloadsDir = wslPath
	}

	if media.Category == "" {
		media.Category = "gouda"
	}

	torrentId, err := d.torrentClient.DownloadTorrentWithMagnet(
		media.TorrentMagentLink,
		downloadsDir,
		media.Category,
	)
	if err != nil {
		return err
	}
	log.Debug().Str("torrent_id", torrentId).Msg("Sent media to torrentClient")

	media.TorrentId = torrentId
	media.CreatedAt = time.Now() // reset time-running for timeout check
	media.MarkDownloading()

	if err = d.db.Save(media); err != nil {
		return err
	}

	go d.startMonitor()
	return nil
}

func (d *Service) startMonitor() {
	select {
	case d.workerChan <- struct{}{}:
		log.Debug().Msg("Starting download monitor")
		d.monitorDownloads()
		_ = <-d.workerChan // empty channel, monitoring complete
		log.Debug().Msg("Monitoring complete, resetting worker")
	default: // channel is full, means that there is already an active monitor
		log.Debug().Msg("Worker is already online, nothing to do")
		return
	}
}

func (d *Service) monitorDownloads() {
	if err := d.verifyClient(); err != nil {
		log.Warn().Err(err).Msg("download torrentClient is uninitialized")
		return
	}

	timeoutFunc := d.setupTimeoutFunc()

	ticker := time.NewTicker(d.downloader().GetCheckInterval(time.Minute * 2))
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
		statuses, err := d.torrentClient.GetTorrentStatus(torrentIds...)
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

func (d *Service) checkDownload(
	media *Media,
	torrentStatus *dc.TorrentStatus,
	checkTimeout func(req *Media) (time.Duration, bool),
	wg *sync.WaitGroup,
) {
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
		// todo notifications
		log.Error().
			Str("Media", media.Book).
			Msg("Download failed, check your torrent torrentClient")
		media.MarkError(fmt.Errorf("download failed, check your torrentClient: %v", torrentStatus.ClientStatus))
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

func (d *Service) finalizeDownload(torrentRequest *Media, torrentStatus *dc.TorrentStatus) error {
	categoryPath := fmt.Sprintf("%s/%s", d.dirs().CompleteDir, torrentRequest.Category)
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

	sourceUID := d.perms().UID
	sourceGID := d.perms().GID
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

func (d *Service) setupTimeoutFunc() func(media *Media) (time.Duration, bool) {
	ignoreTimeout := d.downloader().IgnoreTimeout

	if ignoreTimeout {
		log.Info().
			Bool("ignore_timeout", ignoreTimeout).
			Msg("downloads will be monitored until completion; no time limit")

		return func(media *Media) (time.Duration, bool) {
			return time.Now().Sub(media.CreatedAt), false
		}
	}

	torrentCheckTimeout := d.downloader().GetDownloadLimit(time.Hour)
	log.Info().Str("timeout", torrentCheckTimeout.String()).Msg("download timeout is set to...")

	return func(media *Media) (time.Duration, bool) {
		torrentRunningDuration := time.Now().Sub(media.CreatedAt)

		if torrentCheckTimeout < torrentRunningDuration {
			log.Error().
				Str("name", media.Book).
				Dur("time_running", torrentRunningDuration).
				Dur("max_timeout", torrentCheckTimeout).
				Msg("Maximum timeout reached abandoning check for media" +
					"\nCheck your torrent Client or increase timeout in settings")
			return torrentRunningDuration, true
		}

		return torrentRunningDuration, false
	}
}

// getDownloadingMedia returns a map [Media.TorrentId] = Media where Media.Status == Downloading
func (d *Service) getDownloadingMedia() (map[string]Media, error) {
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

// verifyClient ensures a valid torrent torrentClient is available
func (d *Service) verifyClient() error {
	if d.torrentClient == nil {
		torrentClient, err := dc.InitializeTorrentClient(d.torrentConfig())
		if err != nil {
			return fmt.Errorf("unable to connect to download torrentClient\n\n%v", err.Error())
		}
		d.torrentClient = torrentClient
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
