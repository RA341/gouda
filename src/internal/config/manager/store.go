package manager

import "github.com/RA341/gouda/internal/config"

type Store interface {
	Save(conf *config.GoudaConfig) error
	Get() (*config.GoudaConfig, error)
}
