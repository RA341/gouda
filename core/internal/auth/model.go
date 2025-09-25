package auth

import (
	"errors"
	"time"

	"gorm.io/gorm"
)

var ErrUserExists = errors.New("username already exists, choose a different user")
var ErrInvalidCredentials = errors.New("invalid username/password")

var ErrInvalidSessionToken = errors.New("invalid session token")
var ErrInvalidSessionTokenExpired = errors.New("token has expired")

var ErrInvalidRefreshToken = errors.New("invalid refresh token")

var ErrNoAuthHeader = errors.New("empty auth header")

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
	// NewSession only creates a new session
	NewSession(session *Session) error
	// NewSessionAutoRotating automatically removes the oldest session and creates a new one
	NewSessionAutoRotating(session *Session, maxSessions uint) error

	GetSessionFromRefreshToken(refreshToken string) (*Session, error)
	GetSessionFromSessionToken(token string) (*Session, error)

	DeleteSessionByID(id uint) error
}
