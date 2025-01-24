package main

import (
	connectcors "connectrpc.com/cors"
	"embed"
	"fmt"
	"github.com/RA341/gouda/download_clients"
	grpc "github.com/RA341/gouda/grpc"
	models "github.com/RA341/gouda/models"
	"github.com/RA341/gouda/service"
	"github.com/RA341/gouda/utils"
	"github.com/rs/cors"
	"github.com/rs/zerolog/log"
	"golang.org/x/net/http2"
	"golang.org/x/net/http2/h2c"
	"io/fs"
	"net/http"
	"os"
	"path/filepath"
)

//go:embed web
var frontendDir embed.FS

func main() {
	log.Logger = utils.ConsoleLogger()

	log.Info().
		Str("flavour", utils.BinaryType).
		Str("version", utils.Version).
		Msgf("Starting application %s", filepath.Base(os.Args[0]))

	utils.InitConfig()

	if utils.Username.GetStr() == "admin" || utils.Password.GetStr() == "admin" {
		log.Warn().Msgf("Default username or password detected make sure to change this via the web ui")
	}

	// reinitialize logger with log file output, once a log directory has been set by viper
	log.Logger = utils.FileConsoleLogger()

	if utils.IsDebugMode() {
		log.Warn().Msgf("app is running in debug mode: AUTH IS IGNORED")
	}

	db, err := utils.InitDB()
	if err != nil {
		log.Fatal().Err(err).Msgf("Failed to start database")
	}

	apiContext := &models.Env{Database: db}

	// load torrent client if previously exists
	if utils.TorrentType.GetStr() != "" {
		client, err := download_clients.InitializeTorrentClient()
		if err != nil {
			log.Error().Err(err).Msgf("Failed to initialize torrent client")
		} else {
			log.Info().Msgf("Loaded torrent client %s", utils.TorrentType.GetStr())
			apiContext.DownloadClient = client

			log.Info().Msgf("starting intial download monitor")
			go service.MonitorDownloads(apiContext)
		}
	}

	if utils.IsDesktopMode() {
		log.Info().Msgf("Running server on a go routine")
		// server as routine
		go func() {
			if err := startServer(apiContext); err != nil {
				log.Fatal().Err(err).Msgf("Failed to start server")
			}
		}()
		// systray will run indefinitely
		InitSystray()
	} else {
		log.Info().Msgf("Running server on the main thread")
		if err := startServer(apiContext); err != nil {
			log.Fatal().Err(err).Msgf("Failed to start server")
		}
	}
}

func startServer(apiContext *models.Env) error {
	grpcRouter := grpc.SetupGRPCEndpoints(apiContext)
	// serve frontend dir
	log.Info().Msgf("Setting up ui files")
	grpcRouter.Handle("/", getFrontendDir())

	baseUrl := fmt.Sprintf(":%s", utils.ServerPort.GetStr())
	log.Info().Str("Listening on:", baseUrl).Msg("")

	middleware := cors.New(cors.Options{
		AllowedOrigins:      []string{"*"},
		AllowPrivateNetwork: true,
		AllowedMethods:      connectcors.AllowedMethods(),
		AllowedHeaders:      append(connectcors.AllowedHeaders(), "Authorization"),
		ExposedHeaders:      connectcors.ExposedHeaders(),
	})

	// Use h2c to serve HTTP/2 without TLS
	return http.ListenAndServe(
		baseUrl,
		middleware.Handler(h2c.NewHandler(grpcRouter, &http2.Server{})),
	)
}

func getFrontendDir() http.Handler {
	subFS, err := fs.Sub(frontendDir, "web")
	if err != nil {
		log.Fatal().Err(err).Msgf("Failed to load frontend directory")
	}
	return http.FileServer(http.FS(subFS))
}
