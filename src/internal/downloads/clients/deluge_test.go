package clients

import (
	"fmt"
	"github.com/rs/zerolog/log"
	"os"
	"testing"
)

func login() DownloadClient {
	var err error

	user := "admin"
	pass := "deluge"
	transmissionUrl := "localhost:8112"
	protocol := "http"

	client, err := NewDelugeClient(&TorrentClient{
		Host: transmissionUrl, Protocol: protocol, User: user, Password: pass,
	})
	if err != nil {
		log.Error().Err(err).Msg("can't initialize the client")
		// Log error and exit if we can't initialize the client
		os.Exit(1)
	}

	_, _, err = client.Test()
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

	status, err := client.GetTorrentStatus([]string{torrentId})
	if err != nil {
		log.Error().Err(err).Msg("can't check the torrent status")
	}

	log.Info().Msgf("torrent status: %v", status)
}

func TestStatus(t *testing.T) {
	client := login()

	status, err := client.GetTorrentStatus([]string{""})
	if err != nil {
		log.Error().Err(err).Msg("can't check the torrent status")
	}

	log.Info().Msgf("torrent status: %v", status)
}
