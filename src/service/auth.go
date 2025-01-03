package service

import (
	"crypto/rand"
	"encoding/hex"
	"errors"
	"fmt"
	"github.com/rs/zerolog/log"
	"github.com/spf13/viper"
	"os"
	"sync"
)

// cache os.getenv('debug') value for perf
var (
	cachedEnvVar string
	envVarOnce   sync.Once
)

func getCachedEnv() string {
	envVarOnce.Do(func() {
		cachedEnvVar = os.Getenv("DEBUG")
	})
	return cachedEnvVar
}

func VerifyToken(token string) (bool, error) {
	if getCachedEnv() == "true" {
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

func GenerateToken(len int) (string, error) {
	b := make([]byte, len)
	_, err := rand.Read(b)
	if err != nil {
		return "", err
	}
	return hex.EncodeToString(b), nil
}

func CheckUserPass(user, pass string) (string, error) {
	username := viper.GetString("user.name")
	password := viper.GetString("user.password")

	if username == user && password == pass {
		tok, err := GenerateToken(32)
		if err != nil {
			return "", fmt.Errorf("failed to generate token %v", err)
		}

		viper.Set("user.session", tok)

		return tok, nil
	}

	return "", errors.New("incorrect username or password error")
}
