package auth

import (
	"connectrpc.com/connect"
	"context"
	"fmt"
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
	username := req.Msg.GetUsername()
	password := req.Msg.GetPassword()

	token, err := a.srv.CheckUserPass(username, password)
	if err != nil {
		return nil, err
	}

	res := connect.NewResponse(&v1.AuthResponse{AuthToken: token})
	return res, nil
}

func (a *Handler) Test(_ context.Context, req *connect.Request[v1.AuthResponse]) (*connect.Response[v1.TestResponse], error) {
	clientToken := req.Msg.GetAuthToken()

	_, err := a.srv.VerifyToken(clientToken)
	if err != nil {
		return nil, err
	}

	res := connect.NewResponse(&v1.TestResponse{})
	return res, nil
}

func NewAuthInterceptor(a *Service) connect.UnaryInterceptorFunc {
	return func(next connect.UnaryFunc) connect.UnaryFunc {
		return func(ctx context.Context, req connect.AnyRequest) (connect.AnyResponse, error) {
			clientToken := req.Header().Get(TokenHeader)
			result, err := a.VerifyToken(clientToken)

			if err != nil || !result {
				return nil, connect.NewError(
					connect.CodeUnauthenticated,
					fmt.Errorf("invalid token %v", err),
				)
			}
			return next(ctx, req)
		}
	}
}
