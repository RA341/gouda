package cmd

import (
	"net/http"
	"strings"

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
	"github.com/rs/zerolog/log"
)

type App struct {
	categorySrv *category.Service
	mamSrv      *mam.Service
	downloadSrv *downloads.DownloadService
	mediaSrv    *media.MediaManagerService
	authSrv     *auth.Service
	conf        *config.GoudaConfig
}

func NewApp(conf *config.GoudaConfig) *App {
	if conf.MamToken == "" && !info.IsDev() {
		log.Fatal().Msg("mam token is required, ensure it is set")
	}

	db, err := database.NewDBService(conf)
	if err != nil {
		log.Fatal().Err(err).Msgf("Failed to connect to database")
	}

	// todo client loading is wrong
	client := initDownloadClient(&conf.TorrentClient)
	catSrv := category.NewCategoryService(db)
	mamSrv := mam.NewService(conf.MamToken)
	downloadSrv := downloads.NewDownloadService(conf, db, &conf.TorrentClient, client)
	mediaSrv := media.NewMediaManagerService(db, downloadSrv, mamSrv)
	authSrv := auth.NewService(conf)

	a := &App{
		categorySrv: catSrv,
		downloadSrv: downloadSrv,
		mediaSrv:    mediaSrv,
		mamSrv:      mamSrv,
		authSrv:     authSrv,
		conf:        conf,
	}

	if a.useAuth() {
		a.authSrv = authSrv
	}
	return a
}

func (a *App) registerEndpoints(mux *http.ServeMux) {
	interceptors := connect.WithInterceptors()
	if a.useAuth() {
		interceptors = connect.WithInterceptors(auth.NewAuthInterceptor(a.authSrv))
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
			return categoryrpc.NewCategoryServiceHandler(category.NewCategoryHandler(a.categorySrv), interceptors)
		},
		// mam
		func() (string, http.Handler) {
			return mamrpc.NewMamServiceHandler(mam.NewHandler(a.mamSrv))
		},
		func() (string, http.Handler) {
			return a.registerHttpHandler("/api/mam", mam.NewHttpHandler(a.mamSrv))
		},
		// settings
		func() (string, http.Handler) {
			return settingsrpc.NewSettingsServiceHandler(settings.NewSettingsHandler(a.downloadSrv), interceptors)
		},
		// media requests
		func() (string, http.Handler) {
			return mediarpc.NewMediaRequestServiceHandler(media.NewMediaManagerHandler(a.mediaSrv), interceptors)
		},
	}

	for _, svc := range endpoints {
		path, handler := svc()
		mux.Handle(path, handler)
	}
}

func (a *App) useAuth() bool {
	return !info.IsDev() && a.conf.Auth
}

func (a *App) registerHttpHandler(basePath string, subMux http.Handler) (string, http.Handler) {
	if !strings.HasSuffix(basePath, "/") {
		basePath = basePath + "/"
	}

	baseHandler := http.StripPrefix(strings.TrimSuffix(basePath, "/"), subMux)
	if a.useAuth() {
		//httpAuth := auth.NewHttpAuthMiddleware(a.Auth)
		//baseHandler = httpAuth(baseHandler)
	}

	return basePath, baseHandler
}

func initDownloadClient(conf *config.TorrentClient) clients.DownloadClient {
	// load torrent client if previously exists
	if conf.ClientType == "" && !info.IsDev() {
		log.Fatal().Msg("client type is required")
	}

	client, err := clients.InitializeTorrentClient(conf)
	if err != nil {
		if !info.IsDev() {
			// todo dont fatal
			log.Fatal().Err(err).Msg("Failed to initialize torrent client")
		}
		return nil
	}

	log.Info().Str("client", conf.ClientType).Msg("Loaded torrent client")
	return client
}
