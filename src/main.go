package main

import (
	"fmt"
	"github.com/RA341/gouda/api"
	"github.com/gin-contrib/cors"
	"github.com/gin-gonic/gin"
	"github.com/rs/zerolog"
	"github.com/rs/zerolog/log"
	"github.com/spf13/viper"
	"net/http"
	"os"
	"path/filepath"
)

var ff = "https://file-examples.com/wp-content/storage/2017/02/file-sample_100kB.doc"

func main() {
	log.Info().Msgf(filepath.Base("sample/downloads/Storm Bound (Places of Power 4 )  Leonard Petracci.epub"))

	log.Logger = log.Output(zerolog.ConsoleWriter{Out: os.Stderr})

	err := InitConfig()
	if err != nil {
		log.Fatal().Err(err).Msgf("Failed to get config")
	}

	apiEnv := api.Env{}

	// load torrent client if previously exists
	if viper.GetString("torrent_client.name") != "" {
		client, err := api.InitializeTorrentClient(api.TorrentClient{
			User:     viper.GetString("torrent_client.user"),
			Password: viper.GetString("torrent_client.password"),
			Protocol: viper.GetString("torrent_client.protocol"),
			Host:     viper.GetString("torrent_client.host"),
			Type:     viper.GetString("torrent_client.name"),
		})

		if err == nil {
			log.Info().Msgf("Loaded torrent client %s", viper.GetString("torrent_client.type"))
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

	ginRouter.HEAD("/", func(context *gin.Context) {
		context.Status(http.StatusOK)
	})

	r := api.SetupAuthRouter(ginRouter)
	r = apiEnv.SetupTorrentClientEndpoints(r)

	port := viper.GetString("server.port")
	err = r.Run(fmt.Sprintf(":%s", port))
	if err != nil {
		log.Error().Err(err).Msgf("Failed to start server")
	}
}
