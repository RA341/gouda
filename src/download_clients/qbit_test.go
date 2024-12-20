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
	pass := "admin12"
	transmissionUrl := "localhost:8990"
	protocol := "http"

	qbitclient, err = InitQbit(transmissionUrl, protocol, user, pass)
	if err != nil {
		// Log error and exit if we can't initialize the client
		os.Exit(1)
	}

	_, _, err = qbitclient.Health()
	if err != nil {
		fmt.Println(err)
		return
	}

	torrent, err := qbitclient.DownloadTorrent("appdata/torrents/[1099384]_The_Definitive_Guide_to_Modern_Java_Clients_with_JavaFX_Cross_Platform_Mobile_and_Cloud_Development_.torrent",
		"appdata/downloads")
	if err != nil {
		return
	}

	status, err := qbitclient.CheckTorrentStatus([]string{torrent})
	if err != nil {
		return
	}

	fmt.Println(status)

	fmt.Println(torrent)

	// Clean up can go here if needed
}

func TestQbitDownloadTorrent(t *testing.T) {

}

func TestQbitCheckTorrentStatus(t *testing.T) {
}

func TestQbitHealth(t *testing.T) {
	t.Run("Test health", func(t *testing.T) {
		clientName, info, err := client.Health()
		if err != nil {
			t.Errorf("Health check failed=%v", err)
		}

		log.Debug().Msgf(clientName, info)
	})

}
