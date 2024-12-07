package api

import (
	"errors"
	"fmt"
	"github.com/gin-gonic/gin"
	"github.com/spf13/viper"
	clients "gouda/download_clients"
	"gouda/mam"
	"log"
	"net/http"
)

func (api *Env) SetupTorrentClientEndpoints(r *gin.Engine) *gin.Engine {
	protected := r.Group("/torrent")
	protected.Use(authMiddleware())

	protected.POST("/addTorrentClient", func(c *gin.Context) {
		var req TorrentClient
		if err := c.BindJSON(&req); err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
			return
		}

		initializeTorrentClient, err := InitializeTorrentClient(req)
		if err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error saving client": err.Error()})
			return
		}

		api.DownloadClient = initializeTorrentClient

		c.JSON(http.StatusOK, gin.H{"status": "success"})
	})

	protected.GET("/torrentclient", func(c *gin.Context) {
		client := TorrentClient{
			User:     viper.GetString("torrent_client.user"),
			Password: viper.GetString("torrent_client.password"),
			Protocol: viper.GetString("torrent_client.protocol"),
			Host:     viper.GetString("torrent_client.host"),
			Type:     viper.GetString("torrent_client.name"),
		}
		c.JSON(http.StatusOK, client)
	})

	protected.POST("/addTorrent", func(c *gin.Context) {
		var req TorrentRequest
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

	protected.GET("/torrentprogress", func(c *gin.Context) {
		status, err := api.DownloadClient.CheckTorrentStatus(api.activeDownloads)
		if err != nil {
			log.Fatal(err)
		}

		c.JSON(http.StatusOK, status)
	})

	return r
}

func AddTorrent(env *Env, request TorrentRequest) error {
	torrentDir := viper.GetString("folder.torrents")

	file, err := mam.DownloadTorrentFile(request.FileLink, torrentDir)
	if err != nil {
		return err
	}

	downloadsDir := viper.GetString("folder.downloads")
	torrent, err := env.DownloadClient.DownloadTorrent(file, downloadsDir)
	if err != nil {
		return err
	}

	env.activeDownloads = append(env.activeDownloads, torrent)
	return nil
}

func InitializeTorrentClient(details TorrentClient) (clients.DownloadClient, error) {
	if details.Type == "transmission" {
		transmission, err := clients.InitTransmission(details.Host, details.Protocol, details.User, details.Password)
		if err != nil {
			return nil, err
		}

		_, _, err = transmission.Health()
		if err != nil {
			return nil, err
		}

		viper.Set("torrent_client.name", details.Type)
		viper.Set("torrent_client.host", details.Host)
		viper.Set("torrent_client.protocol", details.Protocol)
		viper.Set("torrent_client.user", details.User)
		viper.Set("torrent_client.password", details.Password)
		err = viper.WriteConfig()
		if err != nil {
			return nil, err
		}

		return transmission, nil
	} else {
		return nil, errors.New(fmt.Sprintf("Unsupported torrent client: %s", details.Type))
	}
}
