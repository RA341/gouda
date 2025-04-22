package cmd

import (
	"github.com/RA341/gouda/internal/category"
	"github.com/RA341/gouda/internal/download_clients"
	"github.com/RA341/gouda/internal/media_requests"
	"github.com/RA341/gouda/pkg"
	"github.com/rs/zerolog/log"
	"gorm.io/gorm"
)

func initServices() (*category.Service, *media_requests.DownloadService, *media_requests.MediaRequestService) {
	db, err := pkg.InitDB()
	if err != nil {
		log.Fatal().Err(err).Msgf("Failed to start database")
	}

	err = migrate(db)
	if err != nil {
		log.Fatal().Err(err).Msgf("Failed migrate tables")
	}
	log.Info().Msgf("Migration complete")

	client := initDownloadClient()

	catSrv := category.NewCategoryService(db)
	downloadSrv := media_requests.NewDownloadService(db, client)
	mediaReqSrv := media_requests.NewMediaRequestService(db, downloadSrv)

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

func migrate(db *gorm.DB) error {
	err := db.AutoMigrate(&category.Categories{}, &media_requests.RequestTorrent{})
	if err != nil {
		return err
	}
	return nil
}
