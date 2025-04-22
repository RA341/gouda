package auth

import (
	"errors"
	"fmt"
	"github.com/RA341/gouda/pkg"
	"github.com/rs/zerolog/log"
)

func VerifyToken(token string) (bool, error) {
	if pkg.IsDocker() {
		return true, nil
	}

	apiKey := pkg.ApiKey.GetStr()
	if apiKey == token {
		return true, nil
	}

	tok := pkg.UserSession.GetStr()
	if tok == token {
		return true, nil
	}

	log.Error().Msgf("Failed to match token")
	return false, nil
}

func CheckUserPass(user, pass string) (string, error) {
	username := pkg.Username.GetStr()
	password := pkg.Password.GetStr()

	if username == user && password == pass {
		tok, err := pkg.GenerateToken(32)
		if err != nil {
			return "", fmt.Errorf("failed to generate token %v", err)
		}

		pkg.UserSession.Set(tok)
		return tok, nil
	}

	return "", errors.New("incorrect username or password error")
}
