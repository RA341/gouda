package download_clients

// todo doc strings for all functions

type DownloadClient interface {
	DownloadTorrent(torrent, downloadPath, category string) (string, error)

	CheckTorrentStatus(torrentId []string) ([]TorrentStatus, error)

	Health() (string, string, error)
}

type TorrentStatus struct {
	Name             string `json:"name"`
	DownloadPath     string `json:"download_path"`
	DownloadComplete bool   `json:"download-complete"`
	Status           string `json:"status"`
	ID               string `json:"id"`
}

type TorrentClient struct {
	User     string `json:"user"`
	Password string `json:"password"`
	Protocol string `json:"protocol"`
	Host     string `json:"host"`
	Type     string `json:"type"`
}
