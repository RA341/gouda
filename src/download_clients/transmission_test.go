package download_clients

import (
	"github.com/rs/zerolog/log"

	"os"
	"testing"
)

var client DownloadClient

func TestMain(m *testing.M) {
	var err error

	user := "r334"
	pass := "Unrated,Oxidize,Overhang,Unstitch1,Dole,Recycler,Aide"
	transmissionUrl := "192.168.50.123:9092"
	protocol := "http"

	client, err = InitTransmission(transmissionUrl, protocol, user, pass)
	if err != nil {
		// Log error and exit if we can't initialize the client
		os.Exit(1)
	}

	// Run all tests
	code := m.Run()

	// Clean up can go here if needed

	os.Exit(code)
}

func TestDownloadTorrent(t *testing.T) {

}

func TestCheckTorrentStatus(t *testing.T) {
}

func TestHealth(t *testing.T) {
	t.Run("Test health", func(t *testing.T) {
		clientName, info, err := client.Health()
		if err != nil {
			t.Errorf("Health check failed=%v", err)
		}

		log.Debug().Msgf(clientName, info)
	})

}
