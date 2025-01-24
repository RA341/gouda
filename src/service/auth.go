package service

import (
	"errors"
	"fmt"
	"github.com/RA341/gouda/utils"
	"github.com/rs/zerolog/log"
)

func VerifyToken(token string) (bool, error) {
	if utils.IsDocker() {
		return true, nil
	}

	apiKey := utils.ApiKey.GetStr()
	if apiKey == token {
		return true, nil
	}

	tok := utils.UserSession.GetStr()
	if tok == token {
		return true, nil
	}

	log.Error().Msgf("Failed to match token")
	return false, nil
}

func CheckUserPass(user, pass string) (string, error) {
	username := utils.Username.GetStr()
	password := utils.Password.GetStr()

	if username == user && password == pass {
		tok, err := utils.GenerateToken(32)
		if err != nil {
			return "", fmt.Errorf("failed to generate token %v", err)
		}

		utils.UserSession.Set(tok)
		return tok, nil
	}

	return "", errors.New("incorrect username or password error")
}
