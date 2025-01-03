package api

import (
	models "github.com/RA341/gouda/models"
	"github.com/gin-gonic/gin"
	"github.com/spf13/viper"
	"net/http"
)

func (api *Env) SetupSettingsEndpoints(r *gin.RouterGroup) {
	protected := r.Group("/settings")

	protected.POST("/update", func(c *gin.Context) {
		var settings models.SettingsJson
		if err := c.BindJSON(&settings); err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
			return
		}

		// general
		viper.Set("apikey", settings.ApiKey)
		viper.Set("server.port", settings.ServerPort)
		viper.Set("download.timeout", settings.DownloadCheckTimeout)
		// folder settings
		viper.Set("folder.defaults", settings.CompleteFolder)
		viper.Set("folder.downloads", settings.DownloadFolder)
		viper.Set("folder.torrents", settings.TorrentsFolder)
		// user settings
		viper.Set("user.name", settings.Username)
		viper.Set("user.password", settings.Password)
		viper.Set("user.uid", settings.UserID)
		viper.Set("user.gid", settings.GroupID)
		// torrent client settings
		viper.Set("torrent_client.host", settings.TorrentHost)
		viper.Set("torrent_client.name", settings.TorrentName)
		viper.Set("torrent_client.password", settings.TorrentPassword)
		viper.Set("torrent_client.protocol", settings.TorrentProtocol)
		viper.Set("torrent_client.user", settings.TorrentUser)

		// Save the configuration to file
		err := viper.WriteConfig()
		if err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
			return
		}

		c.JSON(http.StatusOK, gin.H{"status": "success"})
	})

	protected.GET("/retrieve", func(c *gin.Context) {
		settings := models.SettingsJson{
			ApiKey:               viper.GetString("apikey"),
			ServerPort:           viper.GetString("server.port"),
			DownloadCheckTimeout: viper.GetInt("download.timeout"),
			CompleteFolder:       viper.GetString("folder.defaults"),
			DownloadFolder:       viper.GetString("folder.downloads"),
			TorrentsFolder:       viper.GetString("folder.torrents"),
			Username:             viper.GetString("user.name"),
			Password:             viper.GetString("user.password"),
			UserID:               viper.GetInt("user.uid"),
			GroupID:              viper.GetInt("user.gid"),
			TorrentHost:          viper.GetString("torrent_client.host"),
			TorrentName:          viper.GetString("torrent_client.name"),
			TorrentPassword:      viper.GetString("torrent_client.password"),
			TorrentProtocol:      viper.GetString("torrent_client.protocol"),
			TorrentUser:          viper.GetString("torrent_client.user"),
		}

		c.JSON(http.StatusOK, settings)
	})

}
