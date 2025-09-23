package auth

import (
	"context"
	"net/http"

	"connectrpc.com/connect"
)

const AuthSessionHeader = "Authorization"

func NewAuthInterceptor(a *Service) connect.UnaryInterceptorFunc {
	return func(next connect.UnaryFunc) connect.UnaryFunc {
		return func(ctx context.Context, req connect.AnyRequest) (connect.AnyResponse, error) {
			authToken, err := ExtractTokenFromHeaders(req.Header())
			if err != nil {
				return nil, err
			}

			err = a.SessionVerifySessionToken(authToken)
			if err != nil {
				return nil, connect.NewError(
					connect.CodeUnauthenticated,
					err,
				)
			}

			return next(ctx, req)
		}
	}
}

func ExtractTokenFromHeaders(header http.Header) (string, error) {
	key := header.Get(AuthSessionHeader)
	if key == "" {
		return "", ErrNoAuthHeader
	}
	return key, nil
}
