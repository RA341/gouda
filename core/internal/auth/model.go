package auth

import "gorm.io/gorm"

type Store interface{}

type Role int

const (
	Admin = iota
	User
	UserRequestFreeleech
)

type UserModel struct {
	gorm.Model
	Username       string
	HashedPassword string
	Role           int
}
