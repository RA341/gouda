package download_clients

// todo doc strings for all functions

type DownloadClient interface {
	DownloadTorrent(torrent string, downloadPath string) (int64, error)

	CheckTorrentStatus(torrentId int64) (TorrentStatus, error)

	Health() (string, string, error)
}

type TorrentStatus struct {
	Name         string `json:"name"`
	DownloadPath string `json:"download_path"`
	Status       string `json:"status"`
}
