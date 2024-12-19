package types

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
