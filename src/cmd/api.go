package cmd

import (
	"connectrpc.com/connect"
	connectcors "connectrpc.com/cors"
	"context"
	"embed"
	"fmt"
	authrpc "github.com/RA341/gouda/generated/auth/v1/v1connect"
	categoryrpc "github.com/RA341/gouda/generated/category/v1/v1connect"
	mediarpc "github.com/RA341/gouda/generated/media_requests/v1/v1connect"
	settingsrpc "github.com/RA341/gouda/generated/settings/v1/v1connect"
	"github.com/RA341/gouda/internal/auth"
	"github.com/RA341/gouda/internal/category"
	"github.com/RA341/gouda/internal/config"
	settings "github.com/RA341/gouda/internal/config/manager"
	media "github.com/RA341/gouda/internal/media_manager"
	"github.com/rs/cors"
	"github.com/rs/zerolog/log"
	"golang.org/x/net/http2"
	"golang.org/x/net/http2/h2c"
	"io/fs"
	"net/http"
)

//go:embed web
var frontendDir embed.FS

// StartServerWithAddr starts the grpc server using the base addr/port from config automatically
func StartServerWithAddr() {
	baseUrl := fmt.Sprintf(":%s", config.ServerPort.GetStr())
	if err := StartServer(baseUrl); err != nil {
		log.Fatal().Err(err).Msgf("Failed to start server")
	}
}

// StartServer starts the grpc server on baseUrl
func StartServer(baseUrl string) error {
	grpcRouter := setupGRPCEndpoints()
	grpcRouter.Handle("/", getFrontendDir(frontendDir))

	middleware := cors.New(cors.Options{
		AllowedOrigins:      []string{"*"},
		AllowPrivateNetwork: true,
		AllowedMethods:      connectcors.AllowedMethods(),
		AllowedHeaders:      append(connectcors.AllowedHeaders(), "Authorization"),
		ExposedHeaders:      connectcors.ExposedHeaders(),
	})

	log.Info().Msgf("Gouda initialized successfully")
	log.Info().Str("addr", baseUrl).Msg("starting server....")
	// Use h2c to serve HTTP/2 without TLS
	return http.ListenAndServe(
		baseUrl,
		middleware.Handler(h2c.NewHandler(grpcRouter, &http2.Server{})),
	)
}

func setupGRPCEndpoints() *http.ServeMux {
	cat, downloads, mediaManager := initServices()

	mux := http.NewServeMux()
	authInterceptor := connect.WithInterceptors(newAuthInterceptor())
	endpoints := []func() (string, http.Handler){
		// auth
		func() (string, http.Handler) {
			return authrpc.NewAuthServiceHandler(auth.NewAuthHandler())
		},
		// category
		func() (string, http.Handler) {
			return categoryrpc.NewCategoryServiceHandler(category.NewCategoryHandler(cat), authInterceptor)
		},
		// settings
		func() (string, http.Handler) {
			return settingsrpc.NewSettingsServiceHandler(settings.NewSettingsHandler(downloads), authInterceptor)
		},
		// media requests
		func() (string, http.Handler) {
			return mediarpc.NewMediaRequestServiceHandler(media.NewMediaManagerHandler(mediaManager), authInterceptor)
		},
	}

	for _, svc := range endpoints {
		path, handler := svc()
		mux.Handle(path, handler)
	}

	return mux
}

func newAuthInterceptor() connect.UnaryInterceptorFunc {
	return func(next connect.UnaryFunc) connect.UnaryFunc {
		return func(ctx context.Context, req connect.AnyRequest) (connect.AnyResponse, error) {
			clientToken := req.Header().Get(auth.TokenHeader)
			result, err := auth.VerifyToken(clientToken)

			if err != nil || !result {
				return nil, connect.NewError(
					connect.CodeUnauthenticated,
					fmt.Errorf("invalid token %v", err),
				)
			}
			return next(ctx, req)
		}
	}
}

func getFrontendDir(dir embed.FS) http.Handler {
	subFS, err := fs.Sub(dir, "web")
	if err != nil {
		log.Fatal().Err(err).Msgf("Failed to load frontend directory")
	}
	return http.FileServer(http.FS(subFS))
}
