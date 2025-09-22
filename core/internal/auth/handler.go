package auth

import (
	"context"
	"fmt"

	"connectrpc.com/connect"
	v1 "github.com/RA341/gouda/generated/auth/v1"
)

const TokenHeader = "Authorization"

type Handler struct {
	srv *Service
}

func NewAuthHandler(srv *Service) *Handler {
	return &Handler{srv: srv}
}

func (a *Handler) Authenticate(_ context.Context, req *connect.Request[v1.AuthRequest]) (*connect.Response[v1.AuthResponse], error) {
	//username := req.Msg.GetUsername()
	//password := req.Msg.GetPassword()

	//token, err := a.srv.Login(username, password)
	//if err != nil {
	//	return nil, err
	//}

	//res := connect.NewResponse(&v1.AuthResponse{AuthToken: token})
	return nil, fmt.Errorf("todo not implemented Authenticate")
}

func (a *Handler) Test(_ context.Context, req *connect.Request[v1.AuthResponse]) (*connect.Response[v1.TestResponse], error) {
	clientToken := req.Msg.GetAuthToken()

	err := a.srv.VerifySessionToken(clientToken)
	if err != nil {
		return nil, err
	}

	res := connect.NewResponse(&v1.TestResponse{})
	return res, nil
}
