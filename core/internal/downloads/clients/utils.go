package clients

import (
	"fmt"

	sc "github.com/RA341/gouda/internal/server_config"
)

type ClientInit func(info *sc.TorrentClient) (DownloadClient, error)

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

func InitializeTorrentClient(conf *sc.TorrentClient) (DownloadClient, error) {
	return TestTorrentClient(conf)
}

func TestTorrentClient(details *sc.TorrentClient) (DownloadClient, error) {
	initFn, exists := supportedClients[details.ClientType]
	if !exists {
		return nil, fmt.Errorf("unsupported torrent client: %s", details.ClientType)
	}

	client, err := initFn(details)
	if err != nil {
		return nil, err
	}

	return client, nil
}
