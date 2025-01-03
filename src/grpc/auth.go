package api

import (
	"connectrpc.com/connect"
	"context"
	"fmt"
	v1 "github.com/RA341/gouda/generated/auth/v1"
	"github.com/RA341/gouda/service"
)

const tokenHeader = "Authorization"

type AuthService struct{}

func (authSrc *AuthService) Authenticate(_ context.Context, req *connect.Request[v1.AuthRequest]) (*connect.Response[v1.AuthResponse], error) {
	username := req.Msg.GetUsername()
	password := req.Msg.GetPassword()

	token, err := service.CheckUserPass(username, password)
	if err != nil {
		return nil, err
	}

	res := connect.NewResponse(&v1.AuthResponse{AuthToken: token})
	return res, nil
}

func (authSrc *AuthService) Test(_ context.Context, req *connect.Request[v1.AuthResponse]) (*connect.Response[v1.TestResponse], error) {
	clientToken := req.Msg.GetAuthToken()

	status, err := service.VerifyToken(clientToken)
	if err != nil || !status {
		return nil, fmt.Errorf("invalid token %v", err)
	}

	res := connect.NewResponse(&v1.TestResponse{})
	return res, nil
}
