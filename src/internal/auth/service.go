package auth

import (
	"errors"
	"github.com/RA341/gouda/internal/config"
	"github.com/RA341/gouda/internal/info"
	"github.com/rs/zerolog/log"
)

// add permission system

type Service struct {
	conf *config.GoudaConfig
}

func NewService(conf *config.GoudaConfig) *Service {
	if info.IsDev() {
		log.Info().Msg("Dev mode, auth is disabled")
	}

	return &Service{conf: conf}
}

func (s *Service) VerifyToken(token string) (bool, error) {
	//if info.IsDev() {
	//	return true, nil
	//}
	//
	//// todo
	////apiKey := s.conf.ApiKey.GetStr()
	////if apiKey == token {
	////	return true, nil
	////}
	//
	//tok := config.UserSession.GetStr()
	//if tok == token {
	//	return true, nil
	//}
	//
	//log.Error().Msgf("Failed to match token")
	return true, nil
}

func (s *Service) CheckUserPass(user, pass string) (string, error) {
	//username := config.Username.GetStr()
	//password := config.Password.GetStr()
	//
	//if username == user && password == pass {
	//	tok, err := pkg.GenerateToken(32)
	//	if err != nil {
	//		return "", fmt.Errorf("failed to generate token %v", err)
	//	}
	//
	//	config.UserSession.Set(tok)
	//	return tok, nil
	//}

	return "", errors.New("incorrect username or password error")
}
