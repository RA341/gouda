package download_clients

import (
	"fmt"
	models "github.com/RA341/gouda/models"
	"github.com/rs/zerolog/log"
	"os"
	"testing"
)

var qbitclient models.DownloadClient

func TestQbitMain(t *testing.T) {
	var err error

	user := "admin"
	pass := "8fwXxC3bD"
	protocol := "http"
	transmissionUrl := "localhost:8722"

	qbitclient, err = NewQbitClient(transmissionUrl, protocol, user, pass)
	if err != nil {
		// Log error and exit if we can't initialize the client
		os.Exit(1)
	}

	_, _, err = qbitclient.Health()
	if err != nil {
		fmt.Println(err)
		return
	}

	torrent, err := qbitclient.DownloadTorrent(
		"test/big-buck-bunny.torrent",
		"", "")
	if err != nil {
		log.Error().Err(err).Msg("error downloading torrent")
	}

	torrent2, err := qbitclient.DownloadTorrent(
		"test/test.torrent",
		"", "")
	if err != nil {
		log.Error().Err(err).Msg("error downloading torrent")
	}

	torrent3, err := qbitclient.DownloadTorrent(
		"test/cosmos-laundromat.torrent",
		"", "")
	if err != nil {
		log.Error().Err(err).Msg("error downloading torrent")
	}

	torrent4, err := qbitclient.DownloadTorrent(
		"test/sintel.torrent",
		"", "")
	if err != nil {
		log.Error().Err(err).Msg("error downloading torrent")
	}

	status, err := qbitclient.CheckTorrentStatus([]string{torrent, torrent2, torrent3, torrent4})
	if err != nil {
		log.Error().Err(err).Msg("error downloading torrent")
	}

	fmt.Println(status)

	fmt.Println(torrent)

	// Clean up can go here if needed
}
