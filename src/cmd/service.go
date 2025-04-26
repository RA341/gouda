package cmd

import (
	"github.com/RA341/gouda/internal/category"
	"github.com/RA341/gouda/internal/database"
	"github.com/RA341/gouda/internal/download_clients"
	"github.com/RA341/gouda/internal/downloads"
	manager "github.com/RA341/gouda/internal/media_manager"
	"github.com/RA341/gouda/pkg"
	"github.com/rs/zerolog/log"
)

func initServices() (*category.Service, *downloads.DownloadService, *manager.MediaManagerService) {
	db, err := database.NewDBService()
	if err != nil {
		log.Fatal().Err(err).Msgf("Failed to connect to database")
	}

	client := initDownloadClient()

	catSrv := category.NewCategoryService(db)
	downloadSrv := downloads.NewDownloadService(db, client)
	mediaReqSrv := manager.NewMediaManagerService(db, downloadSrv)

	return catSrv, downloadSrv, mediaReqSrv
}

func initDownloadClient() download_clients.DownloadClient {
	// load torrent client if previously exists
	if pkg.TorrentType.GetStr() != "" {
		client, err := download_clients.InitializeTorrentClient()
		if err != nil {
			log.Error().Err(err).Msgf("Failed to initialize torrent client")
			return nil
		} else {
			log.Info().Msgf("Loaded torrent client %s", pkg.TorrentType.GetStr())
			return client
		}
	}
	return nil
}
