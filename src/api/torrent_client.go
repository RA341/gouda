package api

import (
	"fmt"
	"github.com/RA341/gouda/download_clients"
	models "github.com/RA341/gouda/models"
	"github.com/RA341/gouda/service"
	"github.com/gin-gonic/gin"
	"github.com/rs/zerolog/log"
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

	endpoints.POST("/addTorrent", func(c *gin.Context) {
		if api.DownloadClient == nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": "Download client is not setup"})
			return
		}

		var req models.RequestTorrent
		if err := c.BindJSON(&req); err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
			return
		}

		err := service.SaveTorrentReq(api.Database, &req)
		if err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"Unable to save info to database": err.Error()})
			return
		}

		err = service.AddTorrent((*models.Env)(api), &req, true)
		if err != nil {
			req.Status = fmt.Sprintf("failed %s", err.Error())
			res := api.Database.Save(&req)
			if res.Error != nil {
				log.Error().Err(err).Msgf("Failed to process torrent, and saving info to database")
			}

			c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
			return
		}

		c.JSON(http.StatusOK, gin.H{"status": "success"})
	})

	return r
}
