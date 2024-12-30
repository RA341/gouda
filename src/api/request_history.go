package api

import (
	"fmt"
	models "github.com/RA341/gouda/models"
	"github.com/RA341/gouda/service"
	"github.com/gin-gonic/gin"
	"github.com/rs/zerolog/log"
	"net/http"
	"os"
	"strconv"
)

func (api *Env) SetupHistoryEndpoints(r *gin.RouterGroup) {
	group := r.Group("/history")

	group.GET("/all", func(c *gin.Context) {
		limit := 30 // default limit
		offset := 0 // default offset

		// Parse limit from query
		if limitQuery := c.Query("limit"); limitQuery != "" {
			parsedLimit, err := strconv.Atoi(limitQuery)
			if err != nil || parsedLimit < 0 {
				c.JSON(http.StatusBadRequest, gin.H{
					"error": "Invalid limit parameter",
				})
				return
			}
			limit = parsedLimit
		}

		// Parse offset from query
		if offsetQuery := c.Query("offset"); offsetQuery != "" {
			parsedOffset, err := strconv.Atoi(offsetQuery)
			if err != nil || parsedOffset < 0 {
				c.JSON(http.StatusBadRequest, gin.H{
					"error": "Invalid offset parameter",
				})
				return
			}
			offset = parsedOffset
		}

		log.Debug().Int("limit", limit).Int("offset", offset).Msg("history setup endpoints")

		var torrents []models.RequestTorrent

		resp := api.Database.Limit(limit).Offset(offset).Order("created_at desc").Find(&torrents)
		if resp.Error != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error retrieving torrent history": resp.Error.Error()})
			return
		}

		c.JSON(http.StatusOK, &torrents)
	})

	group.DELETE("/delete/:id", func(c *gin.Context) {
		id := c.Param("id")
		if id == "" {
			c.JSON(http.StatusBadRequest, gin.H{"error retrieving request ID": "Make sure to pass the Id in path param, for example: /retry/12"})
			return
		}

		var torrent models.RequestTorrent
		result := api.Database.First(&torrent, id)
		if result.Error != nil {
			// Handle error - record not found or other DB error
			c.JSON(http.StatusInternalServerError, gin.H{"error getting item": result.Error.Error()})
			return
		}

		resp := api.Database.Unscoped().Delete(&models.RequestTorrent{}, id)
		if resp.Error != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error deleting request": resp.Error.Error()})
			return
		}

		err := os.Remove(torrent.TorrentFileLocation)
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"Unable to delete the torrent file": resp.Error.Error()})
			return
		}

		c.JSON(http.StatusOK, gin.H{"deleted request": id})
	})

	group.POST("/edit", func(c *gin.Context) {
		var req models.RequestTorrent
		if err := c.BindJSON(&req); err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
			return
		}

		if req.ID == 0 {
			log.Warn().Msgf("Torrent ID is zero %v", req)
			c.JSON(http.StatusBadRequest, gin.H{"error": "Could not find item ID"})
			return
		}

		var torrent models.RequestTorrent
		result := api.Database.Save(&torrent)
		if result.Error != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error getting item": result.Error.Error()})
			return
		}

		c.JSON(http.StatusOK, gin.H{"Updated": req.ID})
	})

	group.GET("/exists/:mamId", func(c *gin.Context) {
		id := c.Param("id")
		if id == "" {
			c.JSON(http.StatusBadRequest, gin.H{"error retrieving request ID": "Make sure to pass the Id in path param, for example: /retry/12"})
			return
		}

		var torrRequest models.RequestTorrent

		resp := api.Database.Where("mam_book_id = ?", id).First(&torrRequest)
		if resp.Error != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error retrieving request": resp.Error.Error()})
			return
		}

		c.JSON(http.StatusOK, gin.H{"Exists": torrRequest})
	})

	group.GET("/retry/:id", func(c *gin.Context) {
		id := c.Param("id")
		if id == "" {
			c.JSON(http.StatusBadRequest, gin.H{"error retrieving request ID": "Make sure to pass the Id in path param, for example: /retry/12"})
			return
		}

		var torrRequest models.RequestTorrent

		resp := api.Database.First(&torrRequest, id)
		if resp.Error != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error retrieving request": resp.Error.Error()})
			return
		}

		err := service.AddTorrent((*models.Env)(api), &torrRequest, false)
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error retrying request": err.Error()})
			return
		}

		c.JSON(http.StatusOK, gin.H{"Success": "Added to retry"})
	})

	group.POST("/addTorrent", func(c *gin.Context) {
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
}
