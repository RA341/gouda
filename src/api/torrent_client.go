package api

import (
	"errors"
	"fmt"
	clients "github.com/RA341/gouda/download_clients"
	"github.com/RA341/gouda/mam"
	"github.com/gin-gonic/gin"
	"github.com/rs/zerolog/log"
	"github.com/spf13/viper"
	"net/http"
	"os"
	"path/filepath"
	"time"
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
		if api.DownloadClient == nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": "Download client is not setup"})
			return
		}

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

	go ProcessDownloads(env, torrent, request.Author, request.Book, request.Category)

	return nil
}

func ProcessDownloads(env *Env, torrentId int64, author, book, category string) {
	timeRunning := time.Second * 0
	timeout := time.Minute * viper.GetDuration(fmt.Sprintf("download.timeout"))

	for {
		log.Info().Msgf("getting torrent info with id:%d", torrentId)
		info, err := env.DownloadClient.CheckTorrentStatus(torrentId)
		if err != nil {
			log.Warn().Msgf("Failed to get info with id: %d", torrentId)
			break
		} else {
			if info.Status == "seeding" {
				destPath := viper.GetString("folder.defaults")
				catPath := fmt.Sprintf("%s/%s", destPath, category)
				destPath = fmt.Sprintf("%s/%s/%s", catPath, author, book)

				info.DownloadPath = fmt.Sprintf("%s/%s", info.DownloadPath, info.Name)

				log.Info().Msgf("Torrent %s complete, linking to download location: %s ------> destination: %s", info.Name, info.DownloadPath, destPath)

				err := mam.HardLinkFolder(info.DownloadPath, destPath)
				if err != nil {
					log.Error().Err(err).Msgf("Failed to link info with id: %d", torrentId)
					break
				}

				sourceUID := viper.GetInt("user.uid")
				sourceGID := viper.GetInt("user.gid")
				log.Info().Msgf("Changing file perm to %d:%d", sourceUID, sourceGID)
				err = recursiveChown(catPath, sourceUID, sourceGID)
				if err != nil {
					log.Error().Err(err).Msgf("Failed to chown info with id: %d", torrentId)
					break
				}

				log.Info().Msgf("Download complete: %s and hardlinked to %s", info.Name, destPath)
				break
			}

			if timeout < timeRunning {
				log.Error().Msgf("Maximum timeout reached abandoning check for %d:%s after %s, max timeout was set to %s, check your torrent client or increase timeout in settings", torrentId, info.Name, timeRunning.String(), timeout)
				break
			}

			timeRunning = timeRunning + 1*time.Minute
			log.Info().Msgf("Torrent check for %s with status:%s checking again in a minute", info.Name, info.Status)
			time.Sleep(1 * time.Minute)
		}
	}
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

func recursiveChown(path string, uid, gid int) error {
	// Walk the directory tree
	return filepath.Walk(path, func(name string, info os.FileInfo, err error) error {
		if err != nil {
			return err
		}

		// Change ownership of the current file/directory
		err = os.Chown(name, uid, gid)
		if err != nil {
			return fmt.Errorf("failed to chown %s: %v", name, err)
		}

		return nil
	})
}
