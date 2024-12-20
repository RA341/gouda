package api

import (
	models "github.com/RA341/gouda/models"
	"github.com/gin-gonic/gin"
	"net/http"
)

func (api *Env) SetupHistoryEndpoints(r *gin.RouterGroup) *gin.RouterGroup {
	group := r.Group("/history")

	group.GET("/all", func(c *gin.Context) {
		var torrents []models.RequestTorrent

		resp := api.Database.Find(&torrents)
		if resp.Error != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error retrieving torrent history": resp.Error.Error()})
			return
		}

		c.JSON(http.StatusOK, &torrents)
	})

	return r
}
