package main

import (
	connectcors "connectrpc.com/cors"
	"embed"
	"fmt"
	"github.com/RA341/gouda/download_clients"
	grpc "github.com/RA341/gouda/grpc"
	models "github.com/RA341/gouda/models"
	"github.com/RA341/gouda/service"
	"github.com/rs/cors"
	"github.com/rs/zerolog/log"
	"github.com/spf13/viper"
	"golang.org/x/net/http2"
	"golang.org/x/net/http2/h2c"
	"io/fs"
	"net/http"
)

//go:embed web
var frontendDir embed.FS

func main() {
	log.Logger = service.ConsoleLogger()

	service.InitConfig()

	if viper.GetString("user.name") == "admin" || viper.GetString("user.password") == "admin" {
		log.Warn().Msgf("Default username or password detected make sure to change this via the web ui")
	}

	// reinitialize logger with log file output, once a log directory has been set by viper
	log.Logger = service.FileConsoleLogger()

	if service.IsDebugMode() {
		log.Warn().Msgf("app is running in debug mode: AUTH IS IGNORED")
	}

	db, err := service.InitDB()
	if err != nil {
		log.Fatal().Err(err).Msgf("Failed to start database")
	}

	apiContext := grpc.Env{Database: db}

	// load torrent client if previously exists
	if viper.GetString("torrent_client.name") != "" {
		client, err := download_clients.InitializeTorrentClient()

		if err == nil {
			log.Info().Msgf("Loaded torrent client %s", viper.GetString("torrent_client.name"))
			apiContext.DownloadClient = client

			log.Info().Msgf("starting intial download monitor")
			go service.MonitorDownloads(&models.Env{
				DownloadClient: apiContext.DownloadClient,
				Database:       apiContext.Database,
			})
		} else {
			log.Error().Err(err).Msgf("Failed to initialize torrent client")
		}
	}

	grpcRouter := grpc.SetupGRPCEndpoints(&apiContext)
	// serve frontend dir
	if service.IsDebugMode() || service.IsDocker() {
		log.Info().Msgf("Setting up ui files")
		grpcRouter.Handle("/", getFrontendDir())
	}

	baseUrl := fmt.Sprintf(":%s", viper.GetString("server.port"))
	log.Info().Str("Listening on:", baseUrl).Msg("")

	middleware := cors.New(cors.Options{
		AllowedOrigins:      []string{"*"},
		AllowPrivateNetwork: true,
		AllowedMethods:      connectcors.AllowedMethods(),
		AllowedHeaders:      append(connectcors.AllowedHeaders(), "Authorization"),
		ExposedHeaders:      connectcors.ExposedHeaders(),
	})

	err = http.ListenAndServe(
		baseUrl,
		// Use h2c so we can serve HTTP/2 without TLS.
		middleware.Handler(h2c.NewHandler(grpcRouter, &http2.Server{})),
	)
	if err != nil {
		log.Fatal().Err(err).Msgf("Failed to start server")
	}
}

func getFrontendDir() http.Handler {
	subFS, err := fs.Sub(frontendDir, "web")
	if err != nil {
		log.Fatal().Err(err).Msgf("Failed to load frontend directory")
	}
	return http.FileServer(http.FS(subFS))
}
