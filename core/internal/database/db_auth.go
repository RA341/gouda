package database

import (
	"errors"
	"fmt"

	"github.com/RA341/gouda/internal/auth"
	"gorm.io/gorm"
)

type AuthStoreGorm struct {
	db *gorm.DB
}

func NewAuthStoreGorm(db *gorm.DB) *AuthStoreGorm {
	return &AuthStoreGorm{db: db}
}

// CreateUser creates a new user in the database
func (a *AuthStoreGorm) CreateUser(user *auth.User) error {
	err := a.db.Create(user).Error
	if err != nil {
		if err.Error() == "UNIQUE constraint failed: users.username" {
			return auth.ErrUserExists
		}
		return err
	}

	return nil
}

// DeleteUser deletes a user from the database
func (a *AuthStoreGorm) DeleteUser(user *auth.User) error {
	// Delete by ID if provided, otherwise by username
	var result *gorm.DB
	if user.ID != 0 {
		result = a.db.Delete(&auth.User{}, user.ID)
	} else {
		return fmt.Errorf("user must have a ID set")
	}

	if result.Error != nil {
		return result.Error
	}

	if result.RowsAffected == 0 {
		return fmt.Errorf("user not found")
	}

	return nil
}

func (a *AuthStoreGorm) GetUserById(id uint) (*auth.User, error) {
	user := &auth.User{}
	err := a.db.
		First(&user, id).Error
	if err != nil {
		return nil, err
	}

	return user, nil
}

func (a *AuthStoreGorm) UpdateMaxSessions(userid uint, count uint) error {
	return a.db.Model(auth.User{}).
		Where("id = ?", userid).
		Update("max_sessions", count).
		Error
}

// GetUser retrieves a user from the database
func (a *AuthStoreGorm) GetUser(username string) (*auth.User, error) {
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
func (a *AuthStoreGorm) UpdateRole(uid uint, role auth.Role) error {
	if uid == 0 {
		return fmt.Errorf("user ID cannot be zero")
	}

	// todo make this more scalable
	if role != auth.RoleAdmin && role != auth.RoleUser {
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
func (a *AuthStoreGorm) UpdatePassword(uid uint, hashedPassword string) error {
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
