package api

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

type ProgressRequest struct {
	IDs []string `json:"ids"`
}

type CatRequest struct {
	Category string `json:"category"`
}

type CatList struct {
	Categories []string `json:"categories"`
}
