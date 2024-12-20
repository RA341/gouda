package types

import "gorm.io/gorm"

// Categories gorm category table
type Categories struct {
	gorm.Model
	Category string `json:"category" gorm:"unique"`
}
