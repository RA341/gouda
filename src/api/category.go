package api

import (
	models "github.com/RA341/gouda/models"
	"github.com/RA341/gouda/service"
	"github.com/gin-gonic/gin"
	"github.com/rs/zerolog/log"
	"net/http"
)

func (api *Env) SetupCategoryEndpoints(r *gin.RouterGroup) {
	protected := r.Group("/category")

	protected.GET("/list", func(c *gin.Context) {
		category, err := service.ListCategory(api.Database)
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error retrieving category": err.Error()})
			return
		}

		c.JSON(http.StatusOK, &category)
	})

	protected.POST("/add", func(c *gin.Context) {
		var req models.Categories
		if err := c.BindJSON(&req); err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
			return
		}

		err := service.CreateCategory(api.Database, &req)
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error creating category": err.Error()})
			return
		}

		c.JSON(http.StatusOK, gin.H{"category added": req.Category})
	})

	protected.DELETE("/del", func(c *gin.Context) {
		var req models.Categories
		if err := c.BindJSON(&req); err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
			return
		}

		if req.ID == 0 {
			log.Debug().Msgf("Empty id, the category id must be passed")
			c.JSON(http.StatusBadRequest, gin.H{"error": "Empty id, the category id must be passed"})
			return
		}

		err := service.DeleteCategory(api.Database, &req)
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error deleting category": err.Error()})
			return
		}

		c.JSON(http.StatusOK, gin.H{"category deleted": req.Category})
	})
}
