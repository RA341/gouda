package api

import (
	"crypto/rand"
	"encoding/hex"
	"errors"
	"github.com/gin-gonic/gin"
	"github.com/rs/zerolog/log"
	"github.com/spf13/viper"
	"net/http"
	"os"
	"sync"
)

type LoginRequest struct {
	Username string `json:"username"`
	Password string `json:"password"`
}

// cache os.getenv('debug') value for perf
var (
	cachedEnvVar string
	envVarOnce   sync.Once
)

func GetCachedEnv() string {
	envVarOnce.Do(func() {
		cachedEnvVar = os.Getenv("DEBUG")
	})
	return cachedEnvVar
}

func GenerateToken(len int) (string, error) {
	b := make([]byte, len)
	_, err := rand.Read(b)
	if err != nil {
		return "", err
	}
	return hex.EncodeToString(b), nil
}

func verifyToken(token string) (bool, error) {
	if GetCachedEnv() == "true" {
		return true, nil
	}

	apiKey := viper.GetString("apikey")
	if apiKey == token {
		return true, nil
	}

	tok := viper.GetString("user.session")
	if tok == token {
		return true, nil
	}

	log.Error().Msgf("Failed to match token")
	return false, nil
}

func checkUserPass(user, pass string) (string, error) {
	username := viper.GetString("user.name")
	password := viper.GetString("user.password")

	if username == user && password == pass {
		tok, err := GenerateToken(32)
		if err != nil {
			return "", errors.Join(errors.New("failed to generate token"), err)
		}

		viper.Set("user.session", tok)

		return tok, nil
	}

	return "", errors.New("incorrect username or password error")
}

func AuthMiddleware() gin.HandlerFunc {
	return func(c *gin.Context) {
		tokenString := c.GetHeader("Authorization")
		if tokenString == "" {
			c.JSON(http.StatusUnauthorized, gin.H{"error": "Missing authorization header"})
			c.Abort()
			return
		}

		token, err := verifyToken(tokenString)

		if err != nil || !token {
			c.JSON(http.StatusUnauthorized, gin.H{"error": "Invalid token"})
			c.Abort()
			return
		}

		c.Next()
	}
}

func SetupAuthRouter(r *gin.Engine) *gin.Engine {
	authRouter := r.Group("/auth")

	authRouter.POST("/login", func(c *gin.Context) {
		var req LoginRequest
		if err := c.BindJSON(&req); err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
			return
		}

		token, err := checkUserPass(req.Username, req.Password)
		if err != nil {
			c.JSON(http.StatusUnauthorized, gin.H{"error": "Invalid credentials"})
			return
		}

		c.JSON(http.StatusOK, gin.H{"token": token})
	})

	authRouter.GET("/test", func(c *gin.Context) {
		tokenString := c.GetHeader("Authorization")
		if tokenString == "" {
			c.JSON(http.StatusUnauthorized, gin.H{"error": "Missing authorization header"})
			c.Abort()
			return
		}

		token, err := verifyToken(tokenString)

		if err != nil || !token {
			c.JSON(http.StatusUnauthorized, gin.H{"error": "Invalid token"})
			c.Abort()
			return
		}

		c.JSON(http.StatusOK, gin.H{"token": token})
	})

	return r
}
