package database

import (
	"github.com/RA341/gouda/internal/auth"
	"github.com/RA341/gouda/internal/category"
	"github.com/RA341/gouda/internal/config"
	"github.com/RA341/gouda/internal/downloads"
)

type Service struct {
	*CategoryStore
	*DownloadsStore
	*MediaManagerStore
	*AuthStore
	*AuthSessionStore
}

func NewDBService(conf *config.GoudaConfig) (*Service, error) {
	models := []interface{}{
		&category.Categories{},
		&downloads.Media{},
		&auth.User{},
		&auth.Session{},
	}

	db, err := connect(conf, models...)
	if err != nil {
		return nil, err
	}

	return &Service{
		CategoryStore:     &CategoryStore{db: db},
		DownloadsStore:    &DownloadsStore{db: db},
		MediaManagerStore: &MediaManagerStore{db: db},
		AuthSessionStore:  &AuthSessionStore{db: db},
		AuthStore:         &AuthStore{db: db},
	}, nil
}
