package api

import (
	"connectrpc.com/connect"
	"context"
	"fmt"
	auth "github.com/RA341/gouda/generated/auth/v1/v1connect"
	category "github.com/RA341/gouda/generated/category/v1/v1connect"
	media "github.com/RA341/gouda/generated/media_requests/v1/v1connect"
	settings "github.com/RA341/gouda/generated/settings/v1/v1connect"
	"github.com/RA341/gouda/service"
	"net/http"
)

func SetupGRPCEndpoints(env *Env) *http.ServeMux {

	// setup service structs
	authSrv := &AuthService{}
	categorySrv := &CategoryService{
		api: env,
	}
	settingsSrv := &SettingsService{
		api: env,
	}
	mediaHistory := &MediaRequestService{
		api: env,
	}

	// grpc server setup
	mux := http.NewServeMux()
	authInterceptor := connect.WithInterceptors(NewAuthInterceptor())

	// auth
	authPath, authHandler := auth.NewAuthServiceHandler(authSrv)
	mux.Handle(authPath, authHandler)
	// category
	catPath, catHandler := category.NewCategoryServiceHandler(categorySrv, authInterceptor)
	mux.Handle(catPath, catHandler)
	// settings
	settingsPath, settingsHandler := settings.NewSettingsServiceHandler(settingsSrv, authInterceptor)
	mux.Handle(settingsPath, settingsHandler)
	// media history
	mediaHistoryPath, mediaHistoryHandler := media.NewMediaRequestServiceHandler(mediaHistory, authInterceptor)
	mux.Handle(mediaHistoryPath, mediaHistoryHandler)

	return mux
}

func NewAuthInterceptor() connect.UnaryInterceptorFunc {
	interceptor := func(next connect.UnaryFunc) connect.UnaryFunc {
		return connect.UnaryFunc(func(
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
		})
	}
	return connect.UnaryInterceptorFunc(interceptor)
}
