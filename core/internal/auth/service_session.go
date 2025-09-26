package auth

import (
	"fmt"
	"time"
)

const (
	Day   = time.Hour * 24
	Month = Day * 30

	DefaultSessionDuration = Month
	DefaultRefreshDuration = 12 * Month
)

type SessionService struct {
	store           SessionStore
	sessionDuration time.Duration
	refreshDuration time.Duration
}

func NewSessionService(store SessionStore) *SessionService {
	return &SessionService{
		store:           store,
		sessionDuration: DefaultSessionDuration,
		refreshDuration: DefaultRefreshDuration,
	}
}

func NewSessionServiceWithCustomDuration(
	store SessionStore,
	sessionDuration time.Duration,
	refreshDuration time.Duration,
) *SessionService {
	return &SessionService{
		store:           store,
		sessionDuration: sessionDuration,
		refreshDuration: refreshDuration,
	}
}

func (s *SessionService) SessionDelete(session uint) error {
	return s.store.DeleteSessionByID(session)
}

func (s *SessionService) Logout(refreshToken string) error {
	session, err := s.store.GetSessionFromRefreshToken(refreshToken)
	if err != nil {
		return err
	}

	err = s.SessionDelete(session.ID)
	if err != nil {
		return err
	}

	return nil
}

func (s *SessionService) sessionCreate(user *User) (*Session, error) {
	sessionToken := generateRandomToken(20)
	refreshToken := generateRandomToken(20)

	now := time.Now()
	ses := &Session{
		UserID: user.ID,

		SessionToken:       sessionToken,
		ExpirySessionToken: now.Add(s.sessionDuration),

		RefreshToken:       refreshToken,
		ExpiryRefreshToken: now.Add(s.refreshDuration),
	}

	err := s.store.NewSessionAutoRotating(ses, user.MaxSessions)
	if err != nil {
		return nil, fmt.Errorf("failed to create session: %v", err)
	}

	return ses, nil
}

func (s *SessionService) SessionVerifyToken(token string) error {
	// todo enable/disable auth
	//if info.IsDev() {
	//	return true, nil
	//}

	session, err := s.store.GetSessionFromSessionToken(token)
	if err != nil {
		return fmt.Errorf("failed to get session token %w: %w", ErrInvalidSessionToken, err)
	}

	return s.checkExpiry(session.ExpirySessionToken)
}

// SessionRefresh refresh a user session token
func (s *SessionService) SessionRefresh(refreshToken string) (*Session, error) {
	// todo enable/disable auth
	//if info.IsDev() {
	//	return true, nil
	//}

	currentSession, err := s.store.GetSessionFromRefreshToken(refreshToken)
	if err != nil {
		return nil, fmt.Errorf("failed to get session %w: %w", ErrInvalidRefreshToken, err)
	}

	err = s.checkExpiry(currentSession.ExpiryRefreshToken)
	if err != nil {
		return nil, err
	}

	newSession, err := s.sessionCreate(&currentSession.User)
	if err != nil {
		return nil, err
	}

	err = s.SessionDelete(currentSession.ID)
	if err != nil {
		return nil, err
	}

	return newSession, nil
}

func (s *SessionService) checkExpiry(tokenExpiry time.Time) error {
	if time.Now().After(tokenExpiry) {
		return ErrInvalidSessionTokenExpired
	}
	return nil
}
