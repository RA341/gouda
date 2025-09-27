package user

import (
	"context"

	"connectrpc.com/connect"
	v1 "github.com/RA341/gouda/generated/user/v1"
	"github.com/RA341/gouda/internal/auth"
	"github.com/rs/zerolog/log"
)

type Handler struct{}

func NewHandler() *Handler {
	return &Handler{}
}

func (h *Handler) GetUserInfo(ctx context.Context, _ *connect.Request[v1.GetUserInfoRequest]) (*connect.Response[v1.GetUserInfoResponse], error) {
	session, err := auth.GetUserSessionFromCtx(ctx)
	if err != nil {
		log.Error().Err(err).Msg("THIS LOG SHOULD NEVER HAPPEN!!!")
		return nil, err
	}

	return connect.NewResponse(&v1.GetUserInfoResponse{
		User: &v1.User{
			Username: session.User.Username,
			Role:     session.User.Role,
		},
	}), nil
}
