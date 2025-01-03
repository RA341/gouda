package service

import (
	models "github.com/RA341/gouda/models"
	"github.com/rs/zerolog/log"
	"gorm.io/gorm"
)

func CreateCategory(db *gorm.DB, category string) error {
	input := models.Categories{Category: category}
	result := db.Create(&input)
	if result.Error != nil {
		return result.Error
	}

	log.Debug().Msgf("Category %s created at index: %d", input.Category, input.ID)
	return nil
}

func DeleteCategory(db *gorm.DB, input *models.Categories) error {
	// perma delete, due to unique constraints
	// normal db.Delete will soft delete stuff https://gorm.io/docs/delete.html
	result := db.Unscoped().Delete(input)
	if result.Error != nil {
		return result.Error
	}

	log.Debug().Msgf("Category %s deleted at index: %d", input.Category, input.ID)
	return nil
}

func ListCategory(db *gorm.DB) ([]models.Categories, error) {
	var categories []models.Categories

	res := db.Find(&categories)
	if res.Error != nil {
		return []models.Categories{}, res.Error
	}

	return categories, nil
}
