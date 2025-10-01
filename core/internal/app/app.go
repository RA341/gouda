package app

import (
	"net/http"
	"strings"

	"connectrpc.com/connect"
	authrpc "github.com/RA341/gouda/generated/auth/v1/v1connect"
	categoryrpc "github.com/RA341/gouda/generated/category/v1/v1connect"
	mamrpc "github.com/RA341/gouda/generated/mam/v1/v1connect"
	mediarpc "github.com/RA341/gouda/generated/media_requests/v1/v1connect"
	settingsrpc "github.com/RA341/gouda/generated/settings/v1/v1connect"
	userrpc "github.com/RA341/gouda/generated/user/v1/v1connect"

	"github.com/RA341/gouda/internal/auth"
	"github.com/RA341/gouda/internal/category"
	"github.com/RA341/gouda/internal/database"
	"github.com/RA341/gouda/internal/downloads"
	"github.com/RA341/gouda/internal/downloads/clients"
	"github.com/RA341/gouda/internal/mam"
	mediaManager "github.com/RA341/gouda/internal/media_manager"
	sc "github.com/RA341/gouda/internal/server_config"
	"github.com/RA341/gouda/internal/user"
	"github.com/rs/zerolog/log"
)

type App struct {
	conf       *sc.GoudaConfig
	settingSrv *sc.Service

	categorySrv *category.Service
	mamSrv      *mam.Service
	authSrv     *auth.Service
	downloadSrv *downloads.Service
	mediaSrv    *mediaManager.MediaManagerService
}

func NewApp(conf *sc.GoudaConfig) *App {
	db, err := database.NewDBService(sc.GoudaConfigDir)
	if err != nil {
		log.Fatal().Err(err).Msgf("Failed to connect to database")
	}

	authSrv := auth.NewService(db, db)
	catSrv := category.NewService(db)
	mamSrv := mam.NewService(func() sc.MamConfig {
		return conf.GetVal().Mam
	})
	downloadSrv := downloads.NewService(
		db,
		func() *sc.TorrentClient {
			val := conf.GetVal().TorrentClient
			return &val
		},
		func() *sc.UserPermissions {
			val := conf.GetVal().Permissions
			return &val
		},
		func() *sc.Directories {
			val := conf.GetVal().Dir
			return &val
		},
		func() *sc.Downloader {
			val := conf.GetVal().Downloader
			return &val
		},
	)

	settingSrv := sc.NewService(conf,
		mam.NewMamValidator,
		downloadSrv.ValidateClient,
		func() ([]string, error) {
			return clients.GetSupportedClients(), nil
		},
	)

	mediaSrv := mediaManager.NewService(db, downloadSrv, mamSrv)

	a := &App{
		categorySrv: catSrv,
		mamSrv:      mamSrv,
		authSrv:     authSrv,
		settingSrv:  settingSrv,
		conf:        conf,
		downloadSrv: downloadSrv,
		mediaSrv:    mediaSrv,
	}

	return a
}

func (a *App) registerEndpoints(mux *http.ServeMux) {
	authInterceptor := auth.NewAuthInterceptor(a.authSrv)
	adminInterceptor := auth.NewAdminInterceptor()

	globalInterceptor := connect.WithInterceptors(authInterceptor)

	endpoints := []func() (string, http.Handler){
		// auth
		func() (string, http.Handler) {
			return authrpc.NewAuthServiceHandler(auth.NewAuthHandler(a.authSrv))
		},
		// category
		func() (string, http.Handler) {
			return categoryrpc.NewCategoryServiceHandler(
				category.NewCategoryHandler(a.categorySrv),
				globalInterceptor,
				connect.WithInterceptors(adminInterceptor),
			)
		},
		// mam
		func() (string, http.Handler) {
			return mamrpc.NewMamServiceHandler(
				mam.NewHandler(a.mamSrv),
				globalInterceptor,
			)
		},
		func() (string, http.Handler) {
			return userrpc.NewUserServiceHandler(
				user.NewHandler(),
				globalInterceptor,
				connect.WithInterceptors(adminInterceptor),
			)
		},
		// settings
		func() (string, http.Handler) {
			return settingsrpc.NewSettingsServiceHandler(
				sc.NewSettingsHandler(a.settingSrv),
				globalInterceptor,
			)
		},
		// media requests
		func() (string, http.Handler) {
			return mediarpc.NewMediaRequestServiceHandler(
				mediaManager.NewMediaManagerHandler(a.mediaSrv),
				globalInterceptor,
			)
		},
	}

	for _, svc := range endpoints {
		path, handler := svc()
		mux.Handle(path, handler)
	}
}

func (a *App) registerHttpHandler(basePath string, subMux http.Handler) (string, http.Handler) {
	if !strings.HasSuffix(basePath, "/") {
		basePath = basePath + "/"
	}

	baseHandler := http.StripPrefix(strings.TrimSuffix(basePath, "/"), subMux)
	return basePath, baseHandler
}
