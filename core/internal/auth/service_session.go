package auth

import (
	"fmt"
	"time"
)

func (s *Service) DeleteSession(session uint) error {
	return s.sessions.DeleteSessionByID(session)
}

func (s *Service) createSession(user *User) (*Session, error) {
	const Day = time.Hour * 24
	const Month = Day * 30

	sessionToken := generateRandomToken(20)
	refreshToken := generateRandomToken(20)

	sessionDuration := Month
	refreshDuration := 12 * Month

	now := time.Now()
	ses := &Session{
		UserID: user.ID,

		SessionToken:       sessionToken,
		ExpirySessionToken: now.Add(sessionDuration),

		RefreshToken:       refreshToken,
		ExpiryRefreshToken: now.Add(refreshDuration),
	}

	err := s.sessions.NewSession(ses, user.MaxSessions)
	if err != nil {
		return nil, fmt.Errorf("failed to create session: %v", err)
	}

	return ses, nil
}

func (s *Service) VerifySessionToken(token string) error {
	//if info.IsDev() {
	//	return true, nil
	//}

	session, err := s.sessions.GetSessionToken(token)
	if err != nil {
		return fmt.Errorf("failed to check session token: %w", err)
	}

	if session.ExpirySessionToken.Compare(time.Now()) == -1 {
		return ErrInvalidSessionTokenExpired
	}

	return nil
}
