package download_clients

import (
	"fmt"
	"github.com/RA341/gouda/internal/config"
	"github.com/rs/zerolog/log"
)

var supportedClients = map[string]func(host, protocol, user, password string) (DownloadClient, error){
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

func getTorrentClientInfo() *TorrentClient {
	return &TorrentClient{
		User:     config.TorrentUser.GetStr(),
		Password: config.TorrentPassword.GetStr(),
		Protocol: config.TorrentProtocol.GetStr(),
		Host:     config.TorrentHost.GetStr(),
		Type:     config.TorrentType.GetStr(),
	}
}

func InitializeTorrentClient() (DownloadClient, error) {
	details := getTorrentClientInfo()
	return CheckTorrentClient(details)
}

func CheckTorrentClient(details *TorrentClient) (DownloadClient, error) {
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
