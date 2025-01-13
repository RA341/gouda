package api

import (
	"connectrpc.com/connect"
	"context"
	"fmt"
	auth "github.com/RA341/gouda/generated/auth/v1/v1connect"
	category "github.com/RA341/gouda/generated/category/v1/v1connect"
	media "github.com/RA341/gouda/generated/media_requests/v1/v1connect"
	settings "github.com/RA341/gouda/generated/settings/v1/v1connect"
	models "github.com/RA341/gouda/models"
	"github.com/RA341/gouda/service"
	"net/http"
)

type env models.Env

func SetupGRPCEndpoints(modelEnv *models.Env) *http.ServeMux {
	apiEnv := (*env)(modelEnv)
	// grpc server setup
	mux := http.NewServeMux()
	authInterceptor := connect.WithInterceptors(NewAuthInterceptor())

	services := []func() (string, http.Handler){
		// auth
		func() (string, http.Handler) {
			return auth.NewAuthServiceHandler(&AuthService{})
		},
		// category
		func() (string, http.Handler) {
			return category.NewCategoryServiceHandler(&CategoryService{api: apiEnv}, authInterceptor)
		},
		// settings
		func() (string, http.Handler) {
			return settings.NewSettingsServiceHandler(&SettingsService{api: apiEnv}, authInterceptor)
		},
		// media requests
		func() (string, http.Handler) {
			return media.NewMediaRequestServiceHandler(&MediaRequestService{api: apiEnv}, authInterceptor)
		},
	}

	for _, svc := range services {
		path, handler := svc()
		mux.Handle(path, handler)
	}

	return mux
}

func NewAuthInterceptor() connect.UnaryInterceptorFunc {
	interceptor := func(next connect.UnaryFunc) connect.UnaryFunc {
		return func(
			ctx context.Context,
			req connect.AnyRequest,
		) (connect.AnyResponse, error) {
			clientToken := req.Header().Get(tokenHeader)
			result, err := service.VerifyToken(clientToken)

			if err != nil || !result {
				return nil, connect.NewError(
					connect.CodeUnauthenticated,
					fmt.Errorf("invalid token %v", err),
				)
			}
			return next(ctx, req)
		}
	}
	return interceptor
}
