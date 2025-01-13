package download_clients

import (
	models "github.com/RA341/gouda/models"
)

type DelugeClient struct {
}

func (d DelugeClient) DownloadTorrent(torrent, downloadPath, category string) (string, error) {
	//TODO implement me
	panic("implement me")
}

func (d DelugeClient) CheckTorrentStatus(torrentId []string) ([]models.TorrentStatus, error) {
	//TODO implement me
	panic("implement me")
}

func (d DelugeClient) Health() (string, string, error) {
	//TODO implement me
	panic("implement me")
}

func InitializeDelugeClient(transmissionUrl, protocol, user, pass string) {

}
