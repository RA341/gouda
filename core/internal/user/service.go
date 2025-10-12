package user

import (
	"github.com/RA341/gouda/internal/auth"
)

type Service struct {
	srv *auth.Service
}

func NewService(srv *auth.Service) *Service {
	return &Service{srv: srv}
}

func (s *Service) store() auth.UserStore {
	return s.srv.User
}

func (s *Service) UserAdd() func(user string, pass string, role auth.Role, admin *auth.User) error {
	return s.srv.Register
}

func (s *Service) UserEdit(model *auth.User, password string) error {
	if password != "" {
		hashed, err := auth.EncryptPassword(password)
		if err != nil {
			return err
		}
		model.HashedPassword = hashed
	}

	err := s.store().EditUser(model)
	if err != nil {
		return err
	}

	return nil
}

func (s *Service) UserDelete(userId uint) error {
	var user auth.User
	user.ID = userId

	return s.store().DeleteUser(&user)
}

func (s *Service) UserList() ([]auth.User, error) {
	return s.store().ListUsers()
}
