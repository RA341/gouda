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
	media "github.com/RA341/gouda/internal/media_manager"
	"github.com/RA341/gouda/internal/settings"
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
	log.Info().Str("Listening on:", baseUrl).Msg("")

	if err := StartServer(baseUrl); err != nil {
		log.Fatal().Err(err).Msgf("Failed to start server")
	}
}

// StartServer starts the grpc server on baseUrl
func StartServer(baseUrl string) error {
	grpcRouter := SetupGRPCEndpoints()
	// serve frontend dir
	log.Info().Msgf("Setting up ui files")
	grpcRouter.Handle("/", getFrontendDir(frontendDir))
	log.Info().Msgf("gouda initialized successfully")

	middleware := cors.New(cors.Options{
		AllowedOrigins:      []string{"*"},
		AllowPrivateNetwork: true,
		AllowedMethods:      connectcors.AllowedMethods(),
		AllowedHeaders:      append(connectcors.AllowedHeaders(), "Authorization"),
		ExposedHeaders:      connectcors.ExposedHeaders(),
	})

	log.Info().Str("addr", baseUrl).Msg("starting server....")
	// Use h2c to serve HTTP/2 without TLS
	return http.ListenAndServe(
		baseUrl,
		middleware.Handler(h2c.NewHandler(grpcRouter, &http2.Server{})),
	)
}

func getFrontendDir(dir embed.FS) http.Handler {
	subFS, err := fs.Sub(dir, "web")
	if err != nil {
		log.Fatal().Err(err).Msgf("Failed to load frontend directory")
	}
	return http.FileServer(http.FS(subFS))
}

func SetupGRPCEndpoints() *http.ServeMux {
	cat, down, mediaReq := initServices()

	mux := http.NewServeMux()
	authInterceptor := connect.WithInterceptors(NewAuthInterceptor())

	services := []func() (string, http.Handler){
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
			return settingsrpc.NewSettingsServiceHandler(settings.NewSettingsHandler(down), authInterceptor)
		},
		// media requests
		func() (string, http.Handler) {
			return mediarpc.NewMediaRequestServiceHandler(media.NewMediaManagerHandler(mediaReq), authInterceptor)
		},
	}

	for _, svc := range services {
		path, handler := svc()
		mux.Handle(path, handler)
	}

	return mux
}

func NewAuthInterceptor() connect.UnaryInterceptorFunc {
	interceptor := func(next connect.UnaryFunc) connect.UnaryFunc {
		return func(
			ctx context.Context,
			req connect.AnyRequest,
		) (connect.AnyResponse, error) {
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
	return interceptor
}
