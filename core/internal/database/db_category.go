package database

import (
	"github.com/RA341/gouda/internal/category"
	"gorm.io/gorm"
)

type CategoryStore struct {
	db *gorm.DB
}

func (c *CategoryStore) Create(category *category.Categories) error {
	result := c.db.Create(category)
	if result.Error != nil {
		return result.Error
	}
	return nil
}

func (c *CategoryStore) DeleteCategory(categoryId uint) error {
	// perma delete, due to unique constraints
	// normal db.Delete soft deletes https://gorm.io/docs/delete.html
	result := c.db.Unscoped().Delete(category.Categories{}, categoryId)
	if result.Error != nil {
		return result.Error
	}
	return nil
}

func (c *CategoryStore) ListCategories() ([]category.Categories, error) {
	var result []category.Categories
	res := c.db.Find(&result)
	if res.Error != nil {
		return nil, res.Error
	}

	return result, nil
}
