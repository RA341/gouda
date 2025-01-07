package types

import (
	v1 "github.com/RA341/gouda/generated/category/v1"
	"gorm.io/gorm"
)

// Categories gorm category table
type Categories struct {
	gorm.Model
	Category string `json:"category" gorm:"unique"`
}

func (c Categories) ToProto() *v1.Category {
	return &v1.Category{
		ID:       uint64(c.ID),
		Category: c.Category,
	}
}

func (c Categories) FromProto(proto *v1.Category) *Categories {
	return &Categories{
		Model:    gorm.Model{ID: uint(proto.ID)},
		Category: proto.Category,
	}
}
