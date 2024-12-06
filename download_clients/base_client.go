package download_clients

// todo doc strings for all functions

type DownloadClient interface {
	DownloadTorrent(torrent string, downloadPath string) (int64, error)

	CheckTorrentStatus(torrentIds []string) ([]TorrentStatus, error)

	Health() (string, string, error)
}

type TorrentStatus struct {
	Name            string
	PercentProgress string
	DownloadPath    string
}
