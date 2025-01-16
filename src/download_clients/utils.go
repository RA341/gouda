package download_clients

import (
	"fmt"
	models "github.com/RA341/gouda/models"
	"github.com/rs/zerolog/log"
	"github.com/spf13/viper"
)

var supportedClients = map[string]func(host, protocol, user, password string) (models.DownloadClient, error){
	"transmission": NewTransmissionClient,
	"qbit":         NewQbitClient,
	"deluge":       NewDelugeClient,
}

func GetSupportedClients() []string {
	var clientList []string
	for key := range supportedClients {
		clientList = append(clientList, key)
	}
	return clientList
}

func getTorrentClientInfo() *models.TorrentClient {
	return &models.TorrentClient{
		User:     viper.GetString("torrent_client.user"),
		Password: viper.GetString("torrent_client.password"),
		Protocol: viper.GetString("torrent_client.protocol"),
		Host:     viper.GetString("torrent_client.host"),
		Type:     viper.GetString("torrent_client.name"),
	}
}

func InitializeTorrentClient() (models.DownloadClient, error) {
	details := getTorrentClientInfo()
	return CheckTorrentClient(details)
}

func CheckTorrentClient(details *models.TorrentClient) (models.DownloadClient, error) {

	initFn, exists := supportedClients[details.Type]
	if !exists {
		return nil, fmt.Errorf("unsupported torrent client: %s", details.Type)
	}

	client, err := initFn(details.Host, details.Protocol, details.User, details.Password)
	if err != nil {
		return nil, err
	}

	log.Debug().Msgf("Successfully connected to %s", details.Type)
	return client, nil
}
