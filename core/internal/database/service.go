package database

import "github.com/RA341/gouda/internal/config"

type Service struct {
	*CategoryDB
	*DownloadsDB
	*MediaManagerDB
}

func NewDBService(conf *config.GoudaConfig) (*Service, error) {
	db, err := connect(conf)
	if err != nil {
		return nil, err
	}

	return &Service{
		CategoryDB:     &CategoryDB{db: db},
		DownloadsDB:    &DownloadsDB{db: db},
		MediaManagerDB: &MediaManagerDB{db: db},
	}, nil
}
