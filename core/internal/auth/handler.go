package auth

import (
	"context"
	"fmt"

	"connectrpc.com/connect"
	v1 "github.com/RA341/gouda/generated/auth/v1"
	userrpc "github.com/RA341/gouda/generated/user/v1"
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

func (a *Handler) UserProfile(ctx context.Context, c *connect.Request[v1.UserProfileRequest]) (*connect.Response[v1.UserProfileResponse], error) {
	ctx, err := checkSessionAuth(a.srv.SessionVerifyToken, ctx)
	session, err := GetUserSessionFromCtx(ctx)
	if err != nil {
		return nil, err
	}

	rpcUser := UserToRpc(&session.User)
	return connect.NewResponse(&v1.UserProfileResponse{User: rpcUser}), nil
}

func (a *Handler) Logout(_ context.Context, req *connect.Request[v1.LogoutRequest]) (*connect.Response[v1.LogoutResponse], error) {
	err := a.srv.Logout(req.Msg.Refresh)
	if err != nil {
		return nil, err
	}

	return connect.NewResponse(&v1.LogoutResponse{}), nil
}

func (a *Handler) VerifySession(_ context.Context, req *connect.Request[v1.VerifySessionRequest]) (*connect.Response[v1.VerifySessionResponse], error) {
	token := req.Msg.SessionToken
	if token == "" {
		return nil, fmt.Errorf("session token is empty")
	}

	_, err := a.srv.SessionVerifyToken(token)
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

func RoleToRpc(role Role) userrpc.Role {
	switch role {
	case RoleAdmin:
		return userrpc.Role_Admin
	case RoleMouse:
		return userrpc.Role_Mouse
	default:
		return userrpc.Role_Unknown // or handle the default case appropriately
	}
}

func UserToRpc(user *User) *userrpc.User {
	return &userrpc.User{
		Username: user.Username,
		Role:     RoleToRpc(user.Role),
		UserId:   uint32(user.ID),
	}
}
