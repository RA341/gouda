package auth

import (
	"fmt"

	"github.com/rs/zerolog/log"
)

type Service struct {
	sessions SessionStore
	user     UserStore
}

func NewService(session SessionStore, user UserStore) *Service {
	// todo
	//if info.IsDev() {
	//	log.Info().Msg("Dev mode, auth is disabled")
	//}

	s := &Service{
		sessions: session,
		user:     user,
	}

	err := s.CreateInitialAdmin()
	if err != nil {
		log.Fatal().Err(err).Msg("Unable to create admin account")
	}

	return s
}

const (
	DefaultAdminUsername = "admin"
	DefaultAdminPassword = "gouda"
	// DefaultAdminID 1 should always be the admin
	DefaultAdminID = 1
)

// CreateInitialAdmin creates an admin account if there are no previous users
func (s *Service) CreateInitialAdmin() error {
	_, err := s.user.GetUserById(DefaultAdminID)
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
	dbUser, err := s.user.GetUser(user)
	if err != nil {
		return nil, err
	}

	err = checkEncryptedString(pass, dbUser.HashedPassword)
	if err != nil {
		return nil, ErrInvalidCredentials
	}

	session, err := s.createSession(dbUser)
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
	err = s.user.CreateUser(u)
	if err != nil {
		return fmt.Errorf("failed to create user: %w", err)
	}

	return nil
}

func (s *Service) UpdateUserSessionLimit(userID, limit uint) error {
	err := s.user.UpdateMaxSessions(userID, limit)
	if err != nil {
		return err
	}
	return nil
}
