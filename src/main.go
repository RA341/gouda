package main

import (
	"fmt"
	"github.com/RA341/gouda/api"
	"github.com/RA341/gouda/download_clients"
	models "github.com/RA341/gouda/models"
	"github.com/RA341/gouda/service"
	"github.com/gin-contrib/cors"
	"github.com/gin-contrib/static"
	"github.com/gin-gonic/gin"
	"github.com/rs/zerolog"
	"github.com/rs/zerolog/log"
	"github.com/spf13/viper"
	"gopkg.in/natefinch/lumberjack.v2"
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

	err := InitConfig()
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

	if os.Getenv("DEBUG") == "true" {
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

	apiContext := api.Env{Database: db}

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

	// api setup
	apiServer := gin.Default()

	corsConfig := cors.DefaultConfig()
	corsConfig.AllowAllOrigins = true
	corsConfig.AllowHeaders = append(corsConfig.AllowHeaders, "Authorization")
	apiServer.Use(cors.New(corsConfig))

	if os.Getenv("IS_DOCKER") == "true" {
		apiServer.Use(static.Serve("/", static.LocalFile("./web", false)))
	} else {
		log.Info().Msgf("Frontend is served from brie/build/web")
		apiServer.Use(static.Serve("/", static.LocalFile("./brie/build/web", false)))
	}

	apiServer.HEAD("/", func(context *gin.Context) {
		context.Status(http.StatusOK)
	})

	// This way, /api/auth/* endpoints will be accessible without authentication,
	// while all other /api/* endpoints will require authentication.
	api.SetupAuthRouter(apiServer.Group("/api"))
	protectedApiRoutes := apiServer.Group("/api")
	protectedApiRoutes.Use(api.AuthMiddleware())
	apiContext.SetupTorrentClientEndpoints(protectedApiRoutes)
	apiContext.SetupCategoryEndpoints(protectedApiRoutes)
	apiContext.SetupHistoryEndpoints(protectedApiRoutes)
	apiContext.SetupSettingsEndpoints(protectedApiRoutes)

	port := viper.GetString("server.port")
	err = apiServer.Run(fmt.Sprintf(":%s", port))
	if err != nil {
		log.Error().Err(err).Msgf("Failed to start server")
	}
}
