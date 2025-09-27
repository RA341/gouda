package auth

import (
	"context"
	"fmt"
	"net/http"

	"connectrpc.com/connect"
)

const SessionHeader = "Authorization"
const ContextKeySession = "Session"

func NewAuthInterceptor(srv *Service) connect.UnaryInterceptorFunc {
	return func(next connect.UnaryFunc) connect.UnaryFunc {
		return func(ctx context.Context, req connect.AnyRequest) (connect.AnyResponse, error) {
			ctx, err := checkAuth(ctx, req, srv)
			if err != nil {
				return nil, err
			}

			return next(ctx, req)
		}
	}
}

func checkAuth(ctx context.Context, req connect.AnyRequest, a *Service) (context.Context, error) {
	authToken, err := extractTokenFromHeaders(req.Header())
	if err != nil {
		return nil, err
	}

	session, err := a.SessionVerifyToken(authToken)
	if err != nil {
		return nil, connect.NewError(
			connect.CodeUnauthenticated,
			err,
		)
	}

	ctx = context.WithValue(ctx, ContextKeySession, session)
	return ctx, nil
}

func extractTokenFromHeaders(header http.Header) (string, error) {
	key := header.Get(SessionHeader)
	if key == "" {
		return "", ErrNoAuthHeader
	}
	return key, nil
}

// NewAdminInterceptor checks if user is admin
//
// requires AuthInterceptor to set user session in ctx first
func NewAdminInterceptor() connect.UnaryInterceptorFunc {
	return func(next connect.UnaryFunc) connect.UnaryFunc {
		return func(ctx context.Context, req connect.AnyRequest) (connect.AnyResponse, error) {
			err := checkAdmin(ctx)
			if err != nil {
				return nil, connect.NewError(connect.CodeUnauthenticated, err)
			}

			return next(ctx, req)
		}
	}
}

func checkAdmin(ctx context.Context) error {
	session, err := GetUserSessionFromCtx(ctx)
	if err != nil {
		return err
	}

	if session.User.Role != RoleAdmin {
		return fmt.Errorf("endpoint requires role admin")
	}

	return nil
}

func GetUserSessionFromCtx(ctx context.Context) (*Session, error) {
	val := ctx.Value(ContextKeySession)
	if val == nil {
		return nil, fmt.Errorf("session data not found")
	}

	session, ok := val.(*Session)
	if !ok {
		return nil, fmt.Errorf("unable to assert session model in context")
	}

	return session, nil
}
