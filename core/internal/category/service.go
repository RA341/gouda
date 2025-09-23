package category

import (
	"github.com/rs/zerolog/log"
)

type Service struct {
	db Store
}

func NewService(db Store) *Service {
	return &Service{db: db}
}

func (srv *Service) CreateCategory(category string) error {
	input := Categories{Category: category}
	if err := srv.db.Create(&input); err != nil {
		return err
	}

	log.Debug().Msgf("CategoryStore %s created at index: %d", input.Category, input.ID)
	return nil
}

func (srv *Service) DeleteCategory(input *Categories) error {
	if err := srv.db.DeleteCategory(input.ID); err != nil {
		return err
	}

	log.Debug().Msgf("CategoryStore %s deleted at index: %d", input.Category, input.ID)
	return nil
}

func (srv *Service) ListCategory() ([]Categories, error) {
	categories, err := srv.db.ListCategories()
	if err != nil {
		return nil, err
	}

	return categories, nil
}
