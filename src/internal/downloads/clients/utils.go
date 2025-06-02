package clients

import (
	"fmt"
	"github.com/RA341/gouda/internal/config"
)

type ClientInit func(info *TorrentClient) (DownloadClient, error)

var supportedClients = map[string]ClientInit{
	"transmission": NewTransmissionClient,
	"qbit":         NewQbitClient,
	//"deluge":       NewDelugeClient, // todo deluge is broken
}

func GetSupportedClients() []string {
	var clientList []string
	for key := range supportedClients {
		clientList = append(clientList, key)
	}
	return clientList
}

func InitializeTorrentClient() (DownloadClient, error) {
	details := getTorrentClientFromConfig()
	return TestTorrentClient(details)
}

func TestTorrentClient(details *TorrentClient) (DownloadClient, error) {
	initFn, exists := supportedClients[details.Type]
	if !exists {
		return nil, fmt.Errorf("unsupported torrent client: %s", details.Type)
	}

	client, err := initFn(details)
	if err != nil {
		return nil, err
	}

	return client, nil
}

func getTorrentClientFromConfig() *TorrentClient {
	return &TorrentClient{
		User:     config.TorrentUser.GetStr(),
		Password: config.TorrentPassword.GetStr(),
		Protocol: config.TorrentProtocol.GetStr(),
		Host:     config.TorrentHost.GetStr(),
		Type:     config.TorrentType.GetStr(),
	}
}
