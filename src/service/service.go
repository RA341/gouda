package service

import (
	"github.com/RA341/gouda/download_clients"
	types "github.com/RA341/gouda/models"
	"github.com/RA341/gouda/utils"
	"github.com/rs/zerolog/log"
)

func InitServices() (*CategoryService, *DownloadService, *MediaRequestService) {
	db, err := utils.InitDB()
	if err != nil {
		log.Fatal().Err(err).Msgf("Failed to start database")
	}
	client := initDownloadClient()

	catSrv := NewCategoryService(db)
	downloadSrv := NewDownloadService(db, client)
	mediaReqSrv := NewMediaRequestService(db, downloadSrv)

	return catSrv, downloadSrv, mediaReqSrv
}

func initDownloadClient() types.DownloadClient {
	// load torrent client if previously exists
	if utils.TorrentType.GetStr() != "" {
		client, err := download_clients.InitializeTorrentClient()
		if err != nil {
			log.Error().Err(err).Msgf("Failed to initialize torrent client")
			return nil
		} else {
			log.Info().Msgf("Loaded torrent client %s", utils.TorrentType.GetStr())
			return client
		}
	}
	return nil
}
