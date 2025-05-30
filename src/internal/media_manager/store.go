package media_manager

import "github.com/RA341/gouda/internal/downloads"

type Store interface {
	Get(id uint) (*downloads.Media, error)
	Search(query string) ([]downloads.Media, error)
	ListMedia(offset int, limit int) ([]downloads.Media, error)
	DeleteMedia(id uint) error
	Edit(media *downloads.Media) error
	Exists(mamId uint64) (*downloads.Media, bool, error)
	Add(media *downloads.Media) error
	CountAllMedia() (int64, error)
}
