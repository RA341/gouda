package media_manager

import "github.com/RA341/gouda/internal/downloads"

type Store interface {
	Get(id uint, media *downloads.Media) error
	Search(query string, results []*downloads.Media) error
	ListMedia(offset int, limit int, results []*downloads.Media) error
	DeleteMedia(id uint) error
	Edit(media *downloads.Media) error
	Exists(mamId uint64, media *downloads.Media) (bool, error)
	Retry(mediaId uint64, media *downloads.Media) error
	Add(media *downloads.Media) error
	CountAllMedia() (int64, error)
}
