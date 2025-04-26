package category

import (
	"github.com/rs/zerolog/log"
)

type Service struct {
	db Store
}

func NewCategoryService(db Store) *Service {
	return &Service{db: db}
}

func (srv *Service) CreateCategory(category string) error {
	input := Categories{Category: category}
	if err := srv.db.Create(&input); err != nil {
		return err
	}

	log.Debug().Msgf("Category %s created at index: %d", input.Category, input.ID)
	return nil
}

func (srv *Service) DeleteCategory(input *Categories) error {
	// perma delete, due to unique constraints
	// normal db.DeleteCategory will soft delete stuff https://gorm.io/docs/delete.html
	if err := srv.db.DeleteCategory(input.ID); err != nil {
		return err
	}

	log.Debug().Msgf("Category %s deleted at index: %d", input.Category, input.ID)
	return nil
}

func (srv *Service) ListCategory() ([]Categories, error) {
	var categories []Categories

	if err := srv.db.ListCategories(categories); err != nil {
		return nil, err
	}

	return categories, nil
}
