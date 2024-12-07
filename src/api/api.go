package api

import (
	clients "gouda/download_clients"
)

type Env struct {
	DownloadClient  clients.DownloadClient
	activeDownloads []int64
}
