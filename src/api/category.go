package api

import (
	"github.com/gin-gonic/gin"
	"github.com/spf13/viper"
	"net/http"
)

func (api *Env) SetupCategoryEndpoints(r *gin.Engine) *gin.Engine {
	protected := r.Group("/category")
	protected.Use(authMiddleware())

	protected.GET("/list", func(c *gin.Context) {
		catogories := viper.GetStringSlice("categories")
		catList := CatList{Categories: catogories}
		if catogories == nil {
			catList = CatList{Categories: []string{}}
		}

		c.JSON(http.StatusOK, catList)
	})

	protected.POST("/add", func(c *gin.Context) {
		var req CatRequest
		if err := c.BindJSON(&req); err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
			return
		}

		categories := viper.GetStringSlice("categories")
		categories = append(categories, req.Category)
		viper.Set("categories", categories)
		err := viper.WriteConfig()
		if err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
			return
		}

		c.JSON(http.StatusOK, gin.H{"status": "success"})
	})

	protected.DELETE("/del", func(c *gin.Context) {
		var req CatRequest
		if err := c.BindJSON(&req); err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
			return
		}

		categories := viper.GetStringSlice("categories")
		var newCategories []string
		for _, cat := range categories {
			if cat != req.Category {
				newCategories = append(newCategories, cat)
			}
		}
		viper.Set("categories", newCategories)
		err := viper.WriteConfig()
		if err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
			return
		}

		c.JSON(http.StatusOK, gin.H{"status": "success"})
	})

	return r
}
