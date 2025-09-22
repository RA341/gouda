package auth

import (
	"fmt"

	"github.com/rs/zerolog/log"
)

const (
	DefaultAdminUsername = "admin"
	DefaultAdminPassword = "gouda"
	// DefaultAdminID 1 should always be the admin
	DefaultAdminID = 1
)

type Service struct {
	*SessionService
	User UserStore
}

func NewService(sessionStore SessionStore, user UserStore) *Service {
	// todo
	//if info.IsDev() {
	//	log.Info().Msg("Dev mode, auth is disabled")
	//}

	session := NewSessionService(sessionStore)

	s := &Service{
		SessionService: session,
		User:           user,
	}

	err := s.CreateInitialAdmin()
	if err != nil {
		log.Fatal().Err(err).Msg("Unable to create admin account")
	}

	return s
}

// CreateInitialAdmin creates an admin account if there are no previous users
func (s *Service) CreateInitialAdmin() error {
	_, err := s.User.GetUserById(DefaultAdminID)
	if err == nil {
		return nil
	}

	err = s.Register(DefaultAdminUsername, DefaultAdminPassword, RoleAdmin)
	if err != nil {
		return err
	}

	return nil
}

func (s *Service) Login(user, pass string) (*Session, error) {
	dbUser, err := s.User.GetUser(user)
	if err != nil {
		return nil, err
	}

	err = checkEncryptedString(pass, dbUser.HashedPassword)
	if err != nil {
		return nil, ErrInvalidCredentials
	}

	session, err := s.sessionCreate(dbUser)
	if err != nil {
		return nil, err
	}

	return session, nil
}

func (s *Service) Register(user, pass string, role Role) error {
	pass, err := encryptPassword(pass)
	if err != nil {
		return fmt.Errorf("failed to encrypt password: %w", err)
	}

	u := &User{
		Username:       user,
		HashedPassword: pass,
		Role:           role,
	}
	err = s.User.CreateUser(u)
	if err != nil {
		return fmt.Errorf("failed to create user: %w", err)
	}

	return nil
}

func (s *Service) UpdateUserSessionLimit(userID, limit uint) error {
	err := s.User.UpdateMaxSessions(userID, limit)
	if err != nil {
		return err
	}
	return nil
}
