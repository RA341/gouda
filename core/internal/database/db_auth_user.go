package database

import (
	"errors"
	"fmt"

	"github.com/RA341/gouda/internal/auth"
	"gorm.io/gorm"
)

type AuthStore struct {
	db *gorm.DB
}

func NewAuthStoreGorm(db *gorm.DB) *AuthStore {
	return &AuthStore{db: db}
}

// CreateUser creates a new user in the database
func (a *AuthStore) CreateUser(user *auth.User) error {
	err := a.db.Create(user).Error
	if err != nil {
		if err.Error() == "UNIQUE constraint failed: users.username" {
			return auth.ErrUserExists
		}
		return err
	}

	return nil
}

func (a *AuthStore) ListUsers() ([]auth.User, error) {
	var users []auth.User
	err := a.db.Select("id", "username", "role").Find(&users).Error
	return users, err
}

func (a *AuthStore) EditUser(model *auth.User) error {
	id := model.ID
	model.ID = 0

	result := a.db.
		Model(&auth.User{}).
		Where("id = ?", id).
		Updates(model)

	return result.Error
}

func (a *AuthStore) DeleteUser(user *auth.User) error {
	if user.ID == 0 {
		return fmt.Errorf("user must have a nonzero ID")
	}

	var result *gorm.DB
	result = a.db.Unscoped().Delete(&auth.User{}, user.ID)
	return result.Error
}

func (a *AuthStore) GetUserById(id uint) (*auth.User, error) {
	user := &auth.User{}
	err := a.db.
		First(&user, id).Error
	if err != nil {
		return nil, err
	}

	return user, nil
}

func (a *AuthStore) UpdateMaxSessions(userid uint, count uint) error {
	return a.db.Model(auth.User{}).
		Where("id = ?", userid).
		Update("max_sessions", count).
		Error
}

// GetUser retrieves a user from the database
func (a *AuthStore) GetUser(username string) (*auth.User, error) {
	var user auth.User

	err := a.db.
		Where("username = ?", username).
		First(&user).Error
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return nil, auth.ErrInvalidCredentials
		}
		return nil, err
	}

	return &user, nil
}

// UpdateRole updates a user's role by their ID
func (a *AuthStore) UpdateRole(uid uint, role auth.Role) error {
	if uid == 0 {
		return fmt.Errorf("user ID cannot be zero")
	}

	// todo make this more scalable
	if role != auth.RoleAdmin && role != auth.RoleMouse {
		return fmt.Errorf("invalid role")
	}

	result := a.db.Model(&auth.User{}).Where("id = ?", uid).Update("role", string(role))
	if result.Error != nil {
		return result.Error
	}

	if result.RowsAffected == 0 {
		return fmt.Errorf("user not found")
	}

	return nil
}

// UpdatePassword updates a user's hashed password by their ID
func (a *AuthStore) UpdatePassword(uid uint, hashedPassword string) error {
	if uid == 0 {
		return fmt.Errorf("user ID cannot be zero")
	}

	if hashedPassword == "" {
		return fmt.Errorf("hashed password cannot be empty")
	}

	result := a.db.Model(&auth.User{}).
		Where("id = ?", uid).
		Update("hashed_password", hashedPassword)
	if result.Error != nil {
		return result.Error
	}

	if result.RowsAffected == 0 {
		return fmt.Errorf("user not found")
	}

	return nil
}
