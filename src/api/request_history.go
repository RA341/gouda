package api

import (
	models "github.com/RA341/gouda/models"
	"github.com/RA341/gouda/service"
	"github.com/gin-gonic/gin"
	"net/http"
)

func (api *Env) SetupHistoryEndpoints(r *gin.RouterGroup) *gin.RouterGroup {
	group := r.Group("/history")

	group.GET("/all", func(c *gin.Context) {
		var torrents []models.RequestTorrent

		resp := api.Database.Order("created_at desc").Find(&torrents)
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

		resp := api.Database.Unscoped().Delete(&models.RequestTorrent{}, id)
		if resp.Error != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error deleting request": resp.Error.Error()})
			return
		}
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

	return r
}
