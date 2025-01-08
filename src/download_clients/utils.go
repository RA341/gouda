package download_clients

import (
	"fmt"
	models "github.com/RA341/gouda/models"
	"github.com/rs/zerolog/log"

	"github.com/spf13/viper"
)

func getTorrentClientInfo() models.TorrentClient {
	return models.TorrentClient{
		User:     viper.GetString("torrent_client.user"),
		Password: viper.GetString("torrent_client.password"),
		Protocol: viper.GetString("torrent_client.protocol"),
		Host:     viper.GetString("torrent_client.host"),
		Type:     viper.GetString("torrent_client.name"),
	}
}

func InitializeTorrentClient() (models.DownloadClient, error) {
	details := getTorrentClientInfo()
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
		return nil, fmt.Errorf("unsupported torrent client: %s", details.Type)
	}
}
