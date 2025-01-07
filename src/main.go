package main

import (
	"fmt"
	"github.com/RA341/gouda/download_clients"
	grpc "github.com/RA341/gouda/grpc"
	models "github.com/RA341/gouda/models"
	"github.com/RA341/gouda/service"
	"github.com/rs/cors"
	"github.com/rs/zerolog"
	"github.com/rs/zerolog/log"
	"github.com/spf13/viper"
	"golang.org/x/net/http2"
	"golang.org/x/net/http2/h2c"
	"gopkg.in/natefinch/lumberjack.v2"

	connectcors "connectrpc.com/cors"
	"net/http"
	"os"
)

func main() {
	consoleWriter := zerolog.ConsoleWriter{
		Out:        os.Stderr,
		TimeFormat: "2006-01-02 15:04:05",
	}

	log.Logger = log.Output(consoleWriter).
		With().
		Caller().
		Logger()

	err := service.InitConfig()
	if err != nil {
		log.Fatal().Err(err).Msgf("Failed to get config")
	}

	logRotator := &lumberjack.Logger{
		Filename:   viper.GetString("log_dir"),
		MaxSize:    10, // MB
		MaxBackups: 5,  // number of backups
		MaxAge:     30, // days
		Compress:   true,
	}

	// reinitialize logger with log file output
	log.Logger = log.Output(zerolog.MultiLevelWriter(consoleWriter, logRotator)).
		With().
		Caller().
		Logger()

	if service.GetCachedDebugEnv() == "true" {
		log.Warn().Msgf("app is running in debug mode: AUTH IS IGNORED")
	}

	dbPath := viper.GetString("db_path")
	if dbPath == "" {
		log.Fatal().Msgf("db_path is empty")
	}
	db, err := service.InitDB(dbPath)
	if err != nil {
		log.Fatal().Err(err).Msgf("Failed to start database")
	}

	apiContext := grpc.Env{Database: db}

	// load torrent client if previously exists
	if viper.GetString("torrent_client.name") != "" {
		client, err := download_clients.InitializeTorrentClient(models.TorrentClient{
			User:     viper.GetString("torrent_client.user"),
			Password: viper.GetString("torrent_client.password"),
			Protocol: viper.GetString("torrent_client.protocol"),
			Host:     viper.GetString("torrent_client.host"),
			Type:     viper.GetString("torrent_client.name"),
		})

		if err == nil {
			log.Info().Msgf("Loaded torrent client %s", viper.GetString("torrent_client.name"))
			apiContext.DownloadClient = client
		} else {
			log.Error().Err(err).Msgf("Failed to initialize torrent client")
		}
	}

	getRouter := grpc.SetupGRPCEndpoints(&apiContext)

	frontendDir := getFrontendDir()
	getRouter.Handle("/", frontendDir)

	port := viper.GetString("server.port")
	baseUrl := fmt.Sprintf(":%s", port)
	log.Info().Str("Listening on:", baseUrl).Msg("")

	middleware := cors.New(cors.Options{
		AllowedOrigins: []string{"*"},
		AllowedMethods: connectcors.AllowedMethods(),
		AllowedHeaders: append(connectcors.AllowedHeaders(), "Authorization"),
		ExposedHeaders: connectcors.ExposedHeaders(),
	})

	err = http.ListenAndServe(
		baseUrl,
		// Use h2c so we can serve HTTP/2 without TLS.
		middleware.Handler(h2c.NewHandler(getRouter, &http2.Server{})),
	)
	if err != nil {
		log.Fatal().Err(err).Msgf("Failed to start server")
	}
}

func getFrontendDir() http.Handler {
	if os.Getenv("IS_DOCKER") == "true" {
		return http.FileServer(http.Dir("./web"))
	} else {
		log.Info().Msgf("Frontend is served from brie/build/web")
		return http.FileServer(http.Dir("./brie/build/web"))
	}
}
