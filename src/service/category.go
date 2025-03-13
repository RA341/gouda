package service

import (
	models "github.com/RA341/gouda/models"
	"github.com/rs/zerolog/log"
	"gorm.io/gorm"
)

type CategoryService struct {
	db *gorm.DB
}

func NewCategoryService(db *gorm.DB) *CategoryService {
	return &CategoryService{db: db}
}

func (srv *CategoryService) CreateCategory(category string) error {
	input := models.Categories{Category: category}
	result := srv.db.Create(&input)
	if result.Error != nil {
		return result.Error
	}

	log.Debug().Msgf("Category %s created at index: %d", input.Category, input.ID)
	return nil
}

func (srv *CategoryService) DeleteCategory(input *models.Categories) error {
	// perma delete, due to unique constraints
	// normal db.Delete will soft delete stuff https://gorm.io/docs/delete.html
	result := srv.db.Unscoped().Delete(input, input.ID)
	if result.Error != nil {
		return result.Error
	}

	log.Debug().Msgf("Category %s deleted at index: %d", input.Category, input.ID)
	return nil
}

func (srv *CategoryService) ListCategory() ([]models.Categories, error) {
	var categories []models.Categories

	res := srv.db.Find(&categories)
	if res.Error != nil {
		return []models.Categories{}, res.Error
	}

	return categories, nil
}
