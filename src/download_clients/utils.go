package download_clients

import (
	"errors"
	"fmt"
	models "github.com/RA341/gouda/models"
	"github.com/rs/zerolog/log"

	"github.com/spf13/viper"
)

func InitializeTorrentClient(details models.TorrentClient) (DownloadClient, error) {
	if details.Type == "transmission" {
		transmission, err := InitTransmission(details.Host, details.Protocol, details.User, details.Password)
		if err != nil {
			return nil, err
		}

		_, _, err = transmission.Health()
		if err != nil {
			return nil, err
		}

		log.Debug().Msgf("Successfully connected to transmission")
		return transmission, nil
	} else if details.Type == "qbit" {
		qbit, err := InitQbit(details.Host, details.Protocol, details.User, details.Password)
		if err != nil {
			return nil, err
		}

		log.Debug().Msgf("Successfully connected to qbit")
		return qbit, nil
	} else {
		return nil, errors.New(fmt.Sprintf("Unsupported torrent client: %s", details.Type))
	}
}

func WriteTorrentConfig(details models.TorrentClient) error {
	viper.Set("torrent_client.name", details.Type)
	viper.Set("torrent_client.host", details.Host)
	viper.Set("torrent_client.protocol", details.Protocol)
	viper.Set("torrent_client.user", details.User)
	viper.Set("torrent_client.password", details.Password)
	err := viper.WriteConfig()
	if err != nil {
		return err
	}

	return nil
}
