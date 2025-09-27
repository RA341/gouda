package manager

import (
	sc "github.com/RA341/gouda/internal/server_config"
)

type Store interface {
	Save(conf *sc.GoudaConfig) error
	Get() (*sc.GoudaConfig, error)
}
