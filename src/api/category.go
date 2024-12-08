package api

import "github.com/gin-gonic/gin"

func (api *Env) SetupCategoryEndpoints(r *gin.Engine) *gin.Engine {
	protected := r.Group("/category")
	protected.Use(authMiddleware())

	return r
}
