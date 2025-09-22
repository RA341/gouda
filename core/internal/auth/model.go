package auth

import (
	"errors"
	"time"

	"gorm.io/gorm"
)

var ErrUserExists = errors.New("username already exists, choose a different user")
var ErrInvalidCredentials = errors.New("invalid username/password")

var ErrInvalidSessionToken = errors.New("invalid session token")
var ErrInvalidSessionTokenExpired = errors.New("invalid session token")

var ErrInvalidRefreshToken = errors.New("invalid refresh token")

type UserStore interface {
	CreateUser(model *User) error
	DeleteUser(model *User) error
	GetUser(username string) (*User, error)
	GetUserById(id uint) (*User, error)

	UpdateRole(uid uint, role Role) error
	UpdatePassword(uid uint, hashedPassword string) error
	UpdateMaxSessions(userid uint, count uint) error
}

type Role = string

const (
	RoleAdmin = "admin"
	RoleUser  = "user"
)

type User struct {
	gorm.Model
	Username       string `gorm:"uniqueIndex"`
	HashedPassword string
	MaxSessions    uint   `gorm:"default:3"`
	Role           string `gorm:"index"`
}

type Session struct {
	gorm.Model

	UserID uint `gorm:"not null"`
	User   User `gorm:"constraint:OnUpdate:CASCADE,OnDelete:CASCADE"`

	SessionToken       string    `gorm:"index"`
	ExpirySessionToken time.Time `gorm:"not null"`

	RefreshToken       string    `gorm:"index"`
	ExpiryRefreshToken time.Time `gorm:"not null"`
}

type SessionStore interface {
	NewSession(session *Session, maxSessions uint) error
	GetRefreshToken(refreshToken string) (*Session, error)
	GetSessionToken(token string) (*Session, error)
	DeleteSessionByID(id uint) error
}
