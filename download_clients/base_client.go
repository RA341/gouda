package download_clients

// todo doc strings for all functions

type DownloadClient interface {
	DownloadTorrent(torrent string, downloadPath string) (int64, error)

	CheckTorrentStatus(torrentIds []int64) ([]TorrentStatus, error)

	Health() (string, string, error)
}

type TorrentStatus struct {
	Name            string `json:"name"`
	PercentProgress string `json:"percent_complete"`
	DownloadPath    string `json:"download_path"`
	Status          string `json:"status"`
}
