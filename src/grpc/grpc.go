package api

import (
	"connectrpc.com/connect"
	"context"
	"fmt"
	auth "github.com/RA341/gouda/generated/auth/v1/v1connect"
	category "github.com/RA341/gouda/generated/category/v1/v1connect"

	"github.com/RA341/gouda/service"
	"net/http"
)

func SetupGRPCEndpoints(env *Env) *http.ServeMux {

	// setup service structs
	authSrv := &AuthServer{}
	categorySrv := &CategoryServer{
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
