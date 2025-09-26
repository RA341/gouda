package auth

import (
	"context"
	"fmt"

	"connectrpc.com/connect"
	v1 "github.com/RA341/gouda/generated/auth/v1"
)

type Handler struct {
	srv *Service
}

func NewAuthHandler(srv *Service) *Handler {
	return &Handler{srv: srv}
}

func (a *Handler) Login(_ context.Context, req *connect.Request[v1.LoginRequest]) (*connect.Response[v1.LoginResponse], error) {
	username := req.Msg.GetUsername()
	password := req.Msg.GetPassword()

	loginSession, err := a.srv.Login(username, password)
	if err != nil {
		return nil, err
	}

	return connect.NewResponse(&v1.LoginResponse{
		Session: SessionToRPC(loginSession),
	}), err
}

func (a *Handler) Register(ctx context.Context, req *connect.Request[v1.RegisterRequest]) (*connect.Response[v1.RegisterResponse], error) {
	return nil, fmt.Errorf("implement Register")
}

func (a *Handler) VerifySession(ctx context.Context, req *connect.Request[v1.VerifySessionRequest]) (*connect.Response[v1.VerifySessionResponse], error) {
	token := req.Msg.SessionToken
	if token == "" {
		return nil, fmt.Errorf("session token is empty")
	}

	err := a.srv.SessionVerifyToken(token)
	if err != nil {
		return nil, err
	}

	return connect.NewResponse(&v1.VerifySessionResponse{}), nil
}

func (a *Handler) RefreshSession(ctx context.Context, req *connect.Request[v1.RefreshSessionRequest]) (*connect.Response[v1.RefreshSessionResponse], error) {
	refreshToken := req.Msg.RefreshToken
	if refreshToken == "" {
		return nil, fmt.Errorf("empty refresh token")
	}

	newSession, err := a.srv.SessionRefresh(refreshToken)
	if err != nil {
		return nil, err
	}

	return connect.NewResponse(&v1.RefreshSessionResponse{
		Session: SessionToRPC(newSession),
	}), err
}

func SessionToRPC(ses *Session) *v1.Session {
	return &v1.Session{
		RefreshToken: ses.RefreshToken,
		SessionToken: ses.SessionToken,
	}
}
