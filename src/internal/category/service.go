package category

import (
	"github.com/rs/zerolog/log"
	"gorm.io/gorm"
)

type Service struct {
	db *gorm.DB
}

func NewCategoryService(db *gorm.DB) *Service {
	return &Service{db: db}
}

func (srv *Service) CreateCategory(category string) error {
	input := Categories{Category: category}
	result := srv.db.Create(&input)
	if result.Error != nil {
		return result.Error
	}

	log.Debug().Msgf("Category %s created at index: %d", input.Category, input.ID)
	return nil
}

func (srv *Service) DeleteCategory(input *Categories) error {
	// perma delete, due to unique constraints
	// normal db.Delete will soft delete stuff https://gorm.io/docs/delete.html
	result := srv.db.Unscoped().Delete(input, input.ID)
	if result.Error != nil {
		return result.Error
	}

	log.Debug().Msgf("Category %s deleted at index: %d", input.Category, input.ID)
	return nil
}

func (srv *Service) ListCategory() ([]Categories, error) {
	var categories []Categories

	res := srv.db.Find(&categories)
	if res.Error != nil {
		return []Categories{}, res.Error
	}

	return categories, nil
}
