package database

import (
	"github.com/RA341/gouda/internal/category"
	"gorm.io/gorm"
)

type CategoryDB struct {
	db *gorm.DB
}

func (c *CategoryDB) Create(category *category.Categories) error {
	result := c.db.Create(category)
	if result.Error != nil {
		return result.Error
	}
	return nil
}

func (c *CategoryDB) DeleteCategory(categoryId uint) error {
	result := c.db.Unscoped().Delete(category.Categories{}, categoryId)
	if result.Error != nil {
		return result.Error
	}
	return nil
}

func (c *CategoryDB) ListCategories(results []category.Categories) error {
	res := c.db.Find(results)
	if res.Error != nil {
		return res.Error
	}
	return nil
}
