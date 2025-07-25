package manager

import (
	"fmt"
	"github.com/RA341/gouda/internal/config"
)

// todo separate logic from handler

type Service struct {
	store Store
}

func (s *Service) loadConfigToRPC() (*config.GoudaConfig, error) {
	get, err := s.store.Get()
	if err != nil {
		return nil, err
	}

	return get, nil
}

func (s *Service) saveConfigFromRPC(settings *config.GoudaConfig) error {
	err := s.store.Save(settings)
	if err != nil {
		return fmt.Errorf("error saving config: %s", err)
	}

	return nil
}
