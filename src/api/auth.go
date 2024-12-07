package api

import (
	"crypto/rand"
	"encoding/hex"
	"errors"
	"github.com/spf13/viper"
	"log"
	"net/http"
	"os"
)
import "github.com/gin-gonic/gin"

type LoginRequest struct {
	Username string `json:"username"`
	Password string `json:"password"`
}

func GenerateToken(len int) (string, error) {
	b := make([]byte, len)
	_, err := rand.Read(b)
	if err != nil {
		return "", err
	}
	return hex.EncodeToString(b), nil
}

// TODO: Implement actual authentication
func verifyToken(token string) (bool, error) {
	if os.Getenv("DEBUG") == "true" {
		//fmt.Println("Warning app is running in debug mode auth is ignored")
		return true, nil
	}

	apiKey := viper.GetString("apikey")
	if apiKey == token {
		return true, nil
	}

	// todo login token
	tok := viper.GetString("user.session")
	if tok == token {
		return true, nil
	}

	log.Println("Failed to match token")
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

func authMiddleware() gin.HandlerFunc {
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
