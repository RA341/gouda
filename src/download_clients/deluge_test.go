package download_clients

import (
	"fmt"
	models "github.com/RA341/gouda/models"
	"github.com/rs/zerolog/log"
	"os"
	"testing"
)

func login() models.DownloadClient {
	var err error

	user := "admin"
	pass := "deluge"
	transmissionUrl := "localhost:8112"
	protocol := "http"

	client, err := NewDelugeClient(transmissionUrl, protocol, user, pass)
	if err != nil {
		log.Error().Err(err).Msg("can't initialize the client")
		// Log error and exit if we can't initialize the client
		os.Exit(1)
	}

	_, _, err = client.Health()
	if err != nil {
		fmt.Println(err)
		return nil
	}

	return client
}

func TestDownload(t *testing.T) {
	client := login()

	torrentId, err := client.DownloadTorrent("test/big-buck-bunny.torrent", "src/download_clients/test/downloads", "")
	if err != nil {
		log.Error().Err(err).Msg("can't download the torrent")
		t.Fail()
		return
	}
	log.Info().Msgf("torrent id: %s", torrentId)

	status, err := client.CheckTorrentStatus([]string{torrentId})
	if err != nil {
		log.Error().Err(err).Msg("can't check the torrent status")
	}

	log.Info().Msgf("torrent status: %v", status)
}

func TestStatus(t *testing.T) {
	client := login()

	status, err := client.CheckTorrentStatus([]string{""})
	if err != nil {
		log.Error().Err(err).Msg("can't check the torrent status")
	}

	log.Info().Msgf("torrent status: %v", status)
}
