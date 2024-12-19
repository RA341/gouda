package api

import (
	clients "github.com/RA341/gouda/download_clients"
	"gorm.io/gorm"
)

type Env struct {
	DownloadClient  clients.DownloadClient
	ActiveDownloads []int64
	Database        *gorm.DB
}
