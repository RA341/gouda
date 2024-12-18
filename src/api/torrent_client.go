package api

import (
	"github.com/RA341/gouda/download_clients"
	models "github.com/RA341/gouda/models"
	"github.com/RA341/gouda/service"
	"github.com/gin-gonic/gin"
	"github.com/spf13/viper"
	"net/http"
)

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

		var req models.TorrentRequest
		if err := c.BindJSON(&req); err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
			return
		}

		err := AddTorrent(api, req)
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
			return
		}

		c.JSON(http.StatusOK, gin.H{"status": "success"})
	})

	return r
}

func AddTorrent(env *Env, request models.TorrentRequest) error {
	torrentDir := viper.GetString("folder.torrents")

	file, err := service.DownloadTorrentFile(request.FileLink, torrentDir)
	if err != nil {
		return err
	}

	downloadsDir := viper.GetString("folder.downloads")
	torrent, err := env.DownloadClient.DownloadTorrent(file, downloadsDir)
	if err != nil {
		return err
	}

	go service.ProcessDownloads(&env.DownloadClient, torrent, request.Author, request.Book, request.Category)

	return nil
}
