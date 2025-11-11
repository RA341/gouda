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
	userSrv     *user.Service
}

func NewApp(conf *sc.GoudaConfig) *App {
	db, err := database.NewDBService(sc.GoudaConfigDir)
	if err != nil {
		log.Fatal().Err(err).Msgf("Failed to connect to database")
	}

	authSrv := auth.NewService(db, db)
	catSrv := category.NewService(db)
	mamSrv := mam.NewService(
		func() *sc.MamConfig {
			return &conf.Load().Mam
		},
		func() *sc.Logger {
			return &conf.Load().Log
		},
	)
	downloadSrv := downloads.NewService(
		db,
		func() *sc.TorrentClient {
			return &conf.Load().TorrentClient
		},
		func() *sc.UserPermissions {
			return &conf.Load().Permissions
		},
		func() *sc.Directories {
			return &conf.Load().Dir
		},
		func() *sc.Downloader {
			return &conf.Load().Downloader
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

	userSrv := user.NewService(authSrv)

	a := &App{
		conf:        conf,
		authSrv:     authSrv,
		userSrv:     userSrv,
		settingSrv:  settingSrv,
		categorySrv: catSrv,
		mamSrv:      mamSrv,
		downloadSrv: downloadSrv,
		mediaSrv:    mediaSrv,
	}

	return a
}

func (a *App) registerEndpoints(mux *http.ServeMux) {
	sessionExtractor := auth.NewSessionExtractor()
	authInterceptor := auth.NewAuthInterceptor(a.authSrv.SessionVerifyToken)
	globalInterceptor := connect.WithInterceptors(
		sessionExtractor,
		authInterceptor,
	)

	adminInterceptor := auth.NewAdminInterceptor()

	endpoints := []func() (string, http.Handler){
		// auth
		func() (string, http.Handler) {
			return authrpc.NewAuthServiceHandler(
				auth.NewAuthHandler(a.authSrv),
				connect.WithInterceptors(sessionExtractor),
			)
		},
		// user
		func() (string, http.Handler) {
			return userrpc.NewUserServiceHandler(
				user.NewHandler(a.userSrv),
				globalInterceptor,
				connect.WithInterceptors(adminInterceptor),
			)
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
