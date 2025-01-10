// Code generated by protoc-gen-connect-go. DO NOT EDIT.
//
// Source: auth/v1/auth.proto

package v1connect

import (
	connect "connectrpc.com/connect"
	context "context"
	errors "errors"
	v1 "github.com/RA341/gouda/generated/auth/v1"
	http "net/http"
	strings "strings"
)

// This is a compile-time assertion to ensure that this generated file and the connect package are
// compatible. If you get a compiler error that this constant is not defined, this code was
// generated with a version of connect newer than the one compiled into your binary. You can fix the
// problem by either regenerating this code with an older version of connect or updating the connect
// version compiled into your binary.
const _ = connect.IsAtLeastVersion1_13_0

const (
	// AuthServiceName is the fully-qualified name of the AuthService service.
	AuthServiceName = "auth.v1.AuthService"
)

// These constants are the fully-qualified names of the RPCs defined in this package. They're
// exposed at runtime as Spec.Procedure and as the final two segments of the HTTP route.
//
// Note that these are different from the fully-qualified method names used by
// google.golang.org/protobuf/reflect/protoreflect. To convert from these constants to
// reflection-formatted method names, remove the leading slash and convert the remaining slash to a
// period.
const (
	// AuthServiceAuthenticateProcedure is the fully-qualified name of the AuthService's Authenticate
	// RPC.
	AuthServiceAuthenticateProcedure = "/auth.v1.AuthService/Authenticate"
	// AuthServiceTestProcedure is the fully-qualified name of the AuthService's Test RPC.
	AuthServiceTestProcedure = "/auth.v1.AuthService/Test"
)

// AuthServiceClient is a client for the auth.v1.AuthService service.
type AuthServiceClient interface {
	Authenticate(context.Context, *connect.Request[v1.AuthRequest]) (*connect.Response[v1.AuthResponse], error)
	Test(context.Context, *connect.Request[v1.AuthResponse]) (*connect.Response[v1.TestResponse], error)
}

// NewAuthServiceClient constructs a client for the auth.v1.AuthService service. By default, it uses
// the Connect protocol with the binary Protobuf Codec, asks for gzipped responses, and sends
// uncompressed requests. To use the gRPC or gRPC-Web protocols, supply the connect.WithGRPC() or
// connect.WithGRPCWeb() options.
//
// The URL supplied here should be the base URL for the Connect or gRPC server (for example,
// http://api.acme.com or https://acme.com/grpc).
func NewAuthServiceClient(httpClient connect.HTTPClient, baseURL string, opts ...connect.ClientOption) AuthServiceClient {
	baseURL = strings.TrimRight(baseURL, "/")
	authServiceMethods := v1.File_auth_v1_auth_proto.Services().ByName("AuthService").Methods()
	return &authServiceClient{
		authenticate: connect.NewClient[v1.AuthRequest, v1.AuthResponse](
			httpClient,
			baseURL+AuthServiceAuthenticateProcedure,
			connect.WithSchema(authServiceMethods.ByName("Authenticate")),
			connect.WithClientOptions(opts...),
		),
		test: connect.NewClient[v1.AuthResponse, v1.TestResponse](
			httpClient,
			baseURL+AuthServiceTestProcedure,
			connect.WithSchema(authServiceMethods.ByName("Test")),
			connect.WithClientOptions(opts...),
		),
	}
}

// authServiceClient implements AuthServiceClient.
type authServiceClient struct {
	authenticate *connect.Client[v1.AuthRequest, v1.AuthResponse]
	test         *connect.Client[v1.AuthResponse, v1.TestResponse]
}

// Authenticate calls auth.v1.AuthService.Authenticate.
func (c *authServiceClient) Authenticate(ctx context.Context, req *connect.Request[v1.AuthRequest]) (*connect.Response[v1.AuthResponse], error) {
	return c.authenticate.CallUnary(ctx, req)
}

// Test calls auth.v1.AuthService.Test.
func (c *authServiceClient) Test(ctx context.Context, req *connect.Request[v1.AuthResponse]) (*connect.Response[v1.TestResponse], error) {
	return c.test.CallUnary(ctx, req)
}

// AuthServiceHandler is an implementation of the auth.v1.AuthService service.
type AuthServiceHandler interface {
	Authenticate(context.Context, *connect.Request[v1.AuthRequest]) (*connect.Response[v1.AuthResponse], error)
	Test(context.Context, *connect.Request[v1.AuthResponse]) (*connect.Response[v1.TestResponse], error)
}

// NewAuthServiceHandler builds an HTTP handler from the service implementation. It returns the path
// on which to mount the handler and the handler itself.
//
// By default, handlers support the Connect, gRPC, and gRPC-Web protocols with the binary Protobuf
// and JSON codecs. They also support gzip compression.
func NewAuthServiceHandler(svc AuthServiceHandler, opts ...connect.HandlerOption) (string, http.Handler) {
	authServiceMethods := v1.File_auth_v1_auth_proto.Services().ByName("AuthService").Methods()
	authServiceAuthenticateHandler := connect.NewUnaryHandler(
		AuthServiceAuthenticateProcedure,
		svc.Authenticate,
		connect.WithSchema(authServiceMethods.ByName("Authenticate")),
		connect.WithHandlerOptions(opts...),
	)
	authServiceTestHandler := connect.NewUnaryHandler(
		AuthServiceTestProcedure,
		svc.Test,
		connect.WithSchema(authServiceMethods.ByName("Test")),
		connect.WithHandlerOptions(opts...),
	)
	return "/auth.v1.AuthService/", http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		switch r.URL.Path {
		case AuthServiceAuthenticateProcedure:
			authServiceAuthenticateHandler.ServeHTTP(w, r)
		case AuthServiceTestProcedure:
			authServiceTestHandler.ServeHTTP(w, r)
		default:
			http.NotFound(w, r)
		}
	})
}

// UnimplementedAuthServiceHandler returns CodeUnimplemented from all methods.
type UnimplementedAuthServiceHandler struct{}

func (UnimplementedAuthServiceHandler) Authenticate(context.Context, *connect.Request[v1.AuthRequest]) (*connect.Response[v1.AuthResponse], error) {
	return nil, connect.NewError(connect.CodeUnimplemented, errors.New("auth.v1.AuthService.Authenticate is not implemented"))
}

func (UnimplementedAuthServiceHandler) Test(context.Context, *connect.Request[v1.AuthResponse]) (*connect.Response[v1.TestResponse], error) {
	return nil, connect.NewError(connect.CodeUnimplemented, errors.New("auth.v1.AuthService.Test is not implemented"))
}
