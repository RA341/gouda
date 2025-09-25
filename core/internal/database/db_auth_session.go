package database

import (
	"github.com/RA341/gouda/internal/auth"
	"gorm.io/gorm"
)

type AuthSessionStore struct {
	db *gorm.DB
}

func NewAuthSessionGorm(db *gorm.DB) *AuthSessionStore {
	return &AuthSessionStore{db: db}
}

func (a *AuthSessionStore) NewSession(session *auth.Session) error {
	return a.db.Create(session).Error
}

func (a *AuthSessionStore) NewSessionAutoRotating(newSession *auth.Session, maxSessions uint) error {
	return a.db.Transaction(func(tx *gorm.DB) error {
		// If maxSessions > 0, enforce limit by removing oldest sessions
		if maxSessions > 0 {
			var count int64
			err := tx.Model(&auth.Session{}).
				Where("user_id = ?", newSession.UserID).
				Count(&count).Error
			if err != nil {
				return err
			}

			if uint(count) >= maxSessions {
				// First, find the oldest sessions to delete
				var oldestSessions []auth.Session
				err = tx.Where("user_id = ?", newSession.UserID).
					Order("created_at ASC").
					Limit(1).
					Find(&oldestSessions).Error
				if err != nil {
					return err
				}

				if len(oldestSessions) > 0 {
					var sessionIDs []uint
					for _, session := range oldestSessions {
						sessionIDs = append(sessionIDs, session.ID)
					}
					tx.Unscoped().Delete(&auth.Session{}, sessionIDs)
				}
			}
		}

		return tx.Create(newSession).Error
	})
}

func (a *AuthSessionStore) GetSessionFromSessionToken(token string) (*auth.Session, error) {
	var session auth.Session

	err := a.db.
		Preload("User").
		Where("session_token = ?", token).
		First(&session).Error
	if err != nil {
		return nil, err
	}

	return &session, nil
}

func (a *AuthSessionStore) GetSessionFromRefreshToken(refreshToken string) (*auth.Session, error) {
	var session auth.Session

	err := a.db.
		Preload("User").
		Where("refresh_token = ?", refreshToken).
		First(&session).Error
	if err != nil {
		return nil, err
	}

	return &session, nil
}

func (a *AuthSessionStore) DeleteSessionByID(id uint) error {
	return a.db.Unscoped().Delete(&auth.Session{}, id).Error
}
