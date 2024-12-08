package api

import clients "github.com/RA341/gouda/download_clients"

type TorrentClient struct {
	User     string `json:"user"`
	Password string `json:"password"`
	Protocol string `json:"protocol"`
	Host     string `json:"host"`
	Type     string `json:"type"`
}

type TorrentRequest struct {
	FileLink string `json:"file_link"`
	Author   string `json:"author"`
	Book     string `json:"book"`
	Category string `json:"category"`
	MAMUrl   string `json:"mam_url"`
}

type SettingsJson struct {
	// general
	ApiKey               string `json:"api_key"`
	ServerPort           string `json:"server_port"`
	DownloadCheckTimeout int    `json:"download_check_timeout"`
	// folder
	CompleteFolder string `json:"complete_folder"`
	DownloadFolder string `json:"download_folder"`
	TorrentsFolder string `json:"torrents_folder"`
	// user stuff
	Username string `json:"username"`
	Password string `json:"password"`
	UserID   int    `json:"user_uid"`
	GroupID  int    `json:"group_uid"`
	// torrent stuff
	TorrentHost     string `json:"torrent_host"`
	TorrentName     string `json:"torrent_name"`
	TorrentPassword string `json:"torrent_password"`
	TorrentProtocol string `json:"torrent_protocol"`
	TorrentUser     string `json:"torrent_user"`
}

type ProgressRequest struct {
	IDs []string `json:"ids"`
}

type CatRequest struct {
	Category string `json:"category"`
}

type CatList struct {
	Categories []string `json:"categories"`
}

type Env struct {
	DownloadClient  clients.DownloadClient
	ActiveDownloads []int64
}
