package api

import (
	clients "github.com/RA341/gouda/download_clients"
)

type Env struct {
	DownloadClient  clients.DownloadClient
	ActiveDownloads []int64
}
