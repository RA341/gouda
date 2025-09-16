package auth

import (
	"context"
	"fmt"

	"connectrpc.com/connect"
)

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

//type HttpMiddleware struct {
//	Srv *Service
//}
//
//func NewHttpAuthMiddleware(srv *Service) func(next http.Handler) http.Handler {
//	return func(next http.Handler) http.Handler {
//		return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
//			u, err := verifyCookie(r.Cookies(), srv)
//			if err != nil {
//				http.Error(w, err.Error(), http.StatusUnauthorized)
//				return
//			}
//
//			r.WithContext(context.WithValue(r.Context(), KeyUserCtx, u))
//			next.ServeHTTP(w, r)
//		})
//	}
//}
//
//func getCookie(name string, cookies []*http.Cookie) (*http.Cookie, error) {
//	if name == "" {
//		return nil, http.ErrNoCookie
//	}
//
//	for _, c := range cookies {
//		if c.Name == HeaderAuth {
//			return c, nil
//		}
//	}
//
//	return nil, http.ErrNoCookie
//}
//
//func verifyCookie(cookies []*http.Cookie, srv *Service) (*User, error) {
//	cookie, err := getCookie(HeaderAuth, cookies)
//	if err != nil {
//		return nil, err
//	}
//
//	token := cookie.Value
//	userInfo, err := srv.VerifyToken(token)
//	if err != nil {
//		log.Error().Err(err).Msg("Unable to verify token")
//		return nil, fmt.Errorf("unable to verify token")
//	}
//
//	return userInfo, nil
//}
