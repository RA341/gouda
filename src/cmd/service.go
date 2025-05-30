package cmd

import (
	"github.com/RA341/gouda/internal/category"
	"github.com/RA341/gouda/internal/config"
	"github.com/RA341/gouda/internal/database"
	"github.com/RA341/gouda/internal/downloads"
	"github.com/RA341/gouda/internal/downloads/clients"
	"github.com/RA341/gouda/internal/info"
	manager "github.com/RA341/gouda/internal/media_manager"
	"github.com/RA341/gouda/pkg/logger"
	"github.com/rs/zerolog/log"
)

func Setup(mode info.BinaryType) {
	logger.ConsoleLogger()
	info.SetMode(mode)
	info.PrintInfo()
	config.Load()
}

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

func initDownloadClient() clients.DownloadClient {
	// load torrent client if previously exists
	if config.TorrentType.GetStr() != "" {
		client, err := clients.InitializeTorrentClient()
		if err != nil {
			log.Error().Err(err).Msg("Failed to initialize torrent client")
			return nil
		} else {
			log.Info().Str("client", config.TorrentType.GetStr()).Msg("Loaded torrent client")
			return client
		}
	}
	return nil
}
