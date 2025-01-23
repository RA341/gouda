package service

import (
	"errors"
	"fmt"
	"github.com/RA341/gouda/utils"
	"github.com/rs/zerolog/log"
	"github.com/spf13/viper"
)

func VerifyToken(token string) (bool, error) {
	if utils.IsDocker() {
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

func CheckUserPass(user, pass string) (string, error) {
	username := viper.GetString("user.name")
	password := viper.GetString("user.password")

	if username == user && password == pass {
		tok, err := utils.GenerateToken(32)
		if err != nil {
			return "", fmt.Errorf("failed to generate token %v", err)
		}

		viper.Set("user.session", tok)

		return tok, nil
	}

	return "", errors.New("incorrect username or password error")
}
