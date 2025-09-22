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

	err := s.store.NewSession(ses, user.MaxSessions)
	if err != nil {
		return nil, fmt.Errorf("failed to create session: %v", err)
	}

	return ses, nil
}

func (s *SessionService) SessionVerifySessionToken(token string) error {
	//if info.IsDev() {
	//	return true, nil
	//}

	session, err := s.store.GetSessionToken(token)
	if err != nil {
		return fmt.Errorf("failed to get session token %w: %w", ErrInvalidSessionToken, err)
	}

	if session.ExpirySessionToken.Compare(time.Now()) == -1 {
		return ErrInvalidSessionTokenExpired
	}

	return nil
}
