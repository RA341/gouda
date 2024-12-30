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
	"net/http"
	"os"
)

func main() {
	log.Logger = log.Output(zerolog.ConsoleWriter{Out: os.Stdout})

	err := InitConfig()
	if err != nil {
		log.Fatal().Err(err).Msgf("Failed to get config")
	}

	if os.Getenv("DEBUG") == "true" {
		log.Warn().Msgf("app is running in debug mode: AUTH IS IGNORED")
	}

	dbPath := viper.GetString("DB_PATH")
	if dbPath == "" {
		log.Fatal().Msgf("DB_PATH is empty")
	}
	db, err := service.InitDB(dbPath)
	if err != nil {
		log.Fatal().Err(err).Msgf("Failed to start database")
	}

	apiEnv := api.Env{Database: db}

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
			apiEnv.DownloadClient = client
		} else {
			log.Error().Err(err).Msgf("Failed to initialize torrent client")
		}
	}

	// api setup
	ginRouter := gin.Default()

	corsConfig := cors.DefaultConfig()
	corsConfig.AllowAllOrigins = true
	corsConfig.AllowHeaders = append(corsConfig.AllowHeaders, "Authorization")
	ginRouter.Use(cors.New(corsConfig))

	if os.Getenv("IS_DOCKER") == "true" {
		ginRouter.Use(static.Serve("/", static.LocalFile("./web", false)))
	} else {
		log.Info().Msgf("Frontend is served from brie/build/web")
		ginRouter.Use(static.Serve("/", static.LocalFile("./brie/build/web", false)))
	}

	ginRouter.HEAD("/", func(context *gin.Context) {
		context.Status(http.StatusOK)
	})

	r := api.SetupAuthRouter(ginRouter)
	apiGroup := r.Group("/api")
	apiGroup.Use(api.AuthMiddleware())
	apiGroup = apiEnv.SetupTorrentClientEndpoints(apiGroup)
	apiGroup = apiEnv.SetupCategoryEndpoints(apiGroup)
	apiGroup = apiEnv.SetupHistoryEndpoints(apiGroup)
	_ = apiEnv.SetupSettingsEndpoints(apiGroup)

	port := viper.GetString("server.port")
	err = r.Run(fmt.Sprintf(":%s", port))
	if err != nil {
		log.Error().Err(err).Msgf("Failed to start server")
	}
}
