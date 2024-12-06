package main

import (
	"fmt"
	"github.com/gin-gonic/gin"
	"github.com/spf13/viper"
	"log"
	"net/http"
)
import api "gouda/api"

var ff = "https://file-examples.com/wp-content/storage/2017/02/file-sample_100kB.doc"

func main() {
	err := InitConfig()
	if err != nil {
		log.Fatal("Failed to get config ", err)
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
			fmt.Print("Loaded torrent client", viper.GetString("torrent_client.type"))
			apiEnv.DownloadClient = client
		} else {
			log.Fatal("Failed to initialize torrent client", err)
		}
	}

	// api setup
	ginRouter := gin.Default()

	ginRouter.HEAD("/", func(context *gin.Context) {
		context.Status(http.StatusOK)
	})

	r := api.SetupAuthRouter(ginRouter)
	r = apiEnv.SetupTorrentClientEndpoints(r)

	port := viper.GetString("server.port")
	err = r.Run(fmt.Sprintf(":%s", port))
	if err != nil {
		log.Fatal(err)
	}
}
