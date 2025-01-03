package api

import (
	"github.com/RA341/gouda/download_clients"
	models "github.com/RA341/gouda/models"
	"github.com/gin-gonic/gin"
	"github.com/spf13/viper"
	"net/http"
)

type Env models.Env

func (api *Env) SetupTorrentClientEndpoints(r *gin.RouterGroup) *gin.RouterGroup {
	endpoints := r.Group("/torrent")

	endpoints.POST("/addTorrentClient", func(c *gin.Context) {
		var req models.TorrentClient
		if err := c.BindJSON(&req); err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
			return
		}

		newTorrentClient, err := download_clients.InitializeTorrentClient(req)
		if err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error initializing client": err.Error()})
			return
		}

		err = download_clients.WriteTorrentConfig(req)
		if err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error saving client": err.Error()})
			return
		}

		api.DownloadClient = newTorrentClient

		c.JSON(http.StatusOK, gin.H{"status": "success"})
	})

	endpoints.GET("/torrentclient", func(c *gin.Context) {
		client := models.TorrentClient{
			User:     viper.GetString("torrent_client.user"),
			Password: viper.GetString("torrent_client.password"),
			Protocol: viper.GetString("torrent_client.protocol"),
			Host:     viper.GetString("torrent_client.host"),
			Type:     viper.GetString("torrent_client.name"),
		}
		c.JSON(http.StatusOK, client)
	})

	return r
}
