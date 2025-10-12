package auth

import (
	"context"
	"fmt"

	"connectrpc.com/connect"
)

const SessionHeader = "Authorization"

// ContextKeySessionToken stores the string auth token fomr SessionHeader token
const ContextKeySessionToken = "AuthToken"

// NewSessionExtractor extracts SessionHeader from headers if present, else sets empty
func NewSessionExtractor() connect.UnaryInterceptorFunc {
	return func(next connect.UnaryFunc) connect.UnaryFunc {
		return func(ctx context.Context, req connect.AnyRequest) (connect.AnyResponse, error) {
			sessionToken := req.Header().Get(SessionHeader)
			ctx = context.WithValue(ctx, ContextKeySessionToken, sessionToken)
			return next(ctx, req)
		}
	}
}

// ContextKeyUserSession stores the actual Session object in context
const ContextKeyUserSession = "UserSession"

type VerifySessionToken = func(token string) (*Session, error)

func NewAuthInterceptor(verifier VerifySessionToken) connect.UnaryInterceptorFunc {
	return func(next connect.UnaryFunc) connect.UnaryFunc {
		return func(ctx context.Context, req connect.AnyRequest) (connect.AnyResponse, error) {
			ctx, err := checkSessionAuth(verifier, ctx)
			if err != nil {
				return nil, err
			}

			return next(ctx, req)
		}
	}
}

func checkSessionAuth(verifier VerifySessionToken, ctx context.Context) (context.Context, error) {
	authToken, ok := ctx.Value(ContextKeySessionToken).(string)
	if !ok || authToken == "" {
		return nil, ErrNoAuthHeader
	}

	session, err := verifier(authToken)
	if err != nil {
		return nil, connect.NewError(
			connect.CodeUnauthenticated,
			err,
		)
	}

	ctx = context.WithValue(ctx, ContextKeyUserSession, session)
	return ctx, nil
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
	val := ctx.Value(ContextKeyUserSession)
	if val == nil {
		return nil, fmt.Errorf("session data not found")
	}

	session, ok := val.(*Session)
	if !ok {
		return nil, fmt.Errorf("unable to assert session model in context")
	}

	return session, nil
}
