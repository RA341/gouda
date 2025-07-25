package cmd

import (
	"connectrpc.com/connect"
	authrpc "github.com/RA341/gouda/generated/auth/v1/v1connect"
	categoryrpc "github.com/RA341/gouda/generated/category/v1/v1connect"
	mamrpc "github.com/RA341/gouda/generated/mam/v1/v1connect"
	mediarpc "github.com/RA341/gouda/generated/media_requests/v1/v1connect"
	settingsrpc "github.com/RA341/gouda/generated/settings/v1/v1connect"
	"github.com/RA341/gouda/internal/auth"
	"github.com/RA341/gouda/internal/category"
	"github.com/RA341/gouda/internal/config"
	settings "github.com/RA341/gouda/internal/config/manager"
	"github.com/RA341/gouda/internal/database"
	"github.com/RA341/gouda/internal/downloads"
	"github.com/RA341/gouda/internal/downloads/clients"
	"github.com/RA341/gouda/internal/info"
	"github.com/RA341/gouda/internal/mam"
	media "github.com/RA341/gouda/internal/media_manager"
	"github.com/RA341/gouda/pkg/logger"
	"github.com/rs/zerolog/log"
	"net/http"
)

func Setup(mode info.BinaryType) {
	logger.ConsoleLogger()
	info.SetMode(mode)
	info.PrintInfo()
}

type App struct {
	categorySrv *category.Service
	mamSrv      *mam.Service
	downloadSrv *downloads.DownloadService
	mediaSrv    *media.MediaManagerService
	authSrv     *auth.Service
	conf        *config.GoudaConfig
}

func NewApp(conf *config.GoudaConfig) *App {
	if conf.MamToken == "" {
		log.Fatal().Msg("mam token is required, ensure it is set")
	}

	db, err := database.NewDBService(conf)
	if err != nil {
		log.Fatal().Err(err).Msgf("Failed to connect to database")
	}

	// todo client loading is wrong
	client := initDownloadClient()

	catSrv := category.NewCategoryService(db)
	mamSrv := mam.NewService(conf.MamToken)
	downloadSrv := downloads.NewDownloadService(conf, db, client)
	mediaSrv := media.NewMediaManagerService(db, downloadSrv, mamSrv)
	authSrv := auth.NewService(conf)

	return &App{
		categorySrv: catSrv,
		downloadSrv: downloadSrv,
		mediaSrv:    mediaSrv,
		mamSrv:      mamSrv,
		authSrv:     authSrv,
		conf:        conf,
	}
}

func (a *App) registerEndpoints(mux *http.ServeMux) {
	authInterceptor := connect.WithInterceptors()
	if !info.IsDev() && a.conf.Auth {
		authInterceptor = connect.WithInterceptors(auth.NewAuthInterceptor(a.authSrv))
	} else {
		log.Info().Msg("Auth middleware is disabled")
	}

	endpoints := []func() (string, http.Handler){
		// auth
		func() (string, http.Handler) {
			return authrpc.NewAuthServiceHandler(auth.NewAuthHandler(a.authSrv))
		},
		// category
		func() (string, http.Handler) {
			return categoryrpc.NewCategoryServiceHandler(category.NewCategoryHandler(a.categorySrv), authInterceptor)
		},
		// mam
		func() (string, http.Handler) {
			return mamrpc.NewMamServiceHandler(mam.NewHandler(a.mamSrv))
		},
		// settings
		func() (string, http.Handler) {
			return settingsrpc.NewSettingsServiceHandler(settings.NewSettingsHandler(a.downloadSrv), authInterceptor)
		},
		// media requests
		func() (string, http.Handler) {
			return mediarpc.NewMediaRequestServiceHandler(media.NewMediaManagerHandler(a.mediaSrv), authInterceptor)
		},
	}

	for _, svc := range endpoints {
		path, handler := svc()
		mux.Handle(path, handler)
	}
}

func initDownloadClient() clients.DownloadClient {
	return nil
	// todo
	// load torrent client if previously exists
	//if config.TorrentType.GetStr() != "" {
	//	client, err := clients.InitializeTorrentClient()
	//	if err != nil {
	//		log.Error().Err(err).Msg("Failed to initialize torrent client")
	//		return nil
	//	} else {
	//		log.Info().Str("client", config.TorrentType.GetStr()).Msg("Loaded torrent client")
	//		return client
	//	}
	//}
}
