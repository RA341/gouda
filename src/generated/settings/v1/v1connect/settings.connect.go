// Code generated by protoc-gen-connect-go. DO NOT EDIT.
//
// Source: settings/v1/settings.proto

package v1connect

import (
	connect "connectrpc.com/connect"
	context "context"
	errors "errors"
	v1 "github.com/RA341/gouda/generated/settings/v1"
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
	// SettingsServiceName is the fully-qualified name of the SettingsService service.
	SettingsServiceName = "settings.v1.SettingsService"
)

// These constants are the fully-qualified names of the RPCs defined in this package. They're
// exposed at runtime as Spec.Procedure and as the final two segments of the HTTP route.
//
// Note that these are different from the fully-qualified method names used by
// google.golang.org/protobuf/reflect/protoreflect. To convert from these constants to
// reflection-formatted method names, remove the leading slash and convert the remaining slash to a
// period.
const (
	// SettingsServiceUpdateSettingsProcedure is the fully-qualified name of the SettingsService's
	// UpdateSettings RPC.
	SettingsServiceUpdateSettingsProcedure = "/settings.v1.SettingsService/UpdateSettings"
	// SettingsServiceListSettingsProcedure is the fully-qualified name of the SettingsService's
	// ListSettings RPC.
	SettingsServiceListSettingsProcedure = "/settings.v1.SettingsService/ListSettings"
	// SettingsServiceListSupportedClientsProcedure is the fully-qualified name of the SettingsService's
	// ListSupportedClients RPC.
	SettingsServiceListSupportedClientsProcedure = "/settings.v1.SettingsService/ListSupportedClients"
)

// SettingsServiceClient is a client for the settings.v1.SettingsService service.
type SettingsServiceClient interface {
	UpdateSettings(context.Context, *connect.Request[v1.Settings]) (*connect.Response[v1.UpdateSettingsResponse], error)
	ListSettings(context.Context, *connect.Request[v1.ListSettingsResponse]) (*connect.Response[v1.Settings], error)
	ListSupportedClients(context.Context, *connect.Request[v1.ListSupportedClientsRequest]) (*connect.Response[v1.ListSupportedClientsResponse], error)
}

// NewSettingsServiceClient constructs a client for the settings.v1.SettingsService service. By
// default, it uses the Connect protocol with the binary Protobuf Codec, asks for gzipped responses,
// and sends uncompressed requests. To use the gRPC or gRPC-Web protocols, supply the
// connect.WithGRPC() or connect.WithGRPCWeb() options.
//
// The URL supplied here should be the base URL for the Connect or gRPC server (for example,
// http://api.acme.com or https://acme.com/grpc).
func NewSettingsServiceClient(httpClient connect.HTTPClient, baseURL string, opts ...connect.ClientOption) SettingsServiceClient {
	baseURL = strings.TrimRight(baseURL, "/")
	settingsServiceMethods := v1.File_settings_v1_settings_proto.Services().ByName("SettingsService").Methods()
	return &settingsServiceClient{
		updateSettings: connect.NewClient[v1.Settings, v1.UpdateSettingsResponse](
			httpClient,
			baseURL+SettingsServiceUpdateSettingsProcedure,
			connect.WithSchema(settingsServiceMethods.ByName("UpdateSettings")),
			connect.WithClientOptions(opts...),
		),
		listSettings: connect.NewClient[v1.ListSettingsResponse, v1.Settings](
			httpClient,
			baseURL+SettingsServiceListSettingsProcedure,
			connect.WithSchema(settingsServiceMethods.ByName("ListSettings")),
			connect.WithClientOptions(opts...),
		),
		listSupportedClients: connect.NewClient[v1.ListSupportedClientsRequest, v1.ListSupportedClientsResponse](
			httpClient,
			baseURL+SettingsServiceListSupportedClientsProcedure,
			connect.WithSchema(settingsServiceMethods.ByName("ListSupportedClients")),
			connect.WithClientOptions(opts...),
		),
	}
}

// settingsServiceClient implements SettingsServiceClient.
type settingsServiceClient struct {
	updateSettings       *connect.Client[v1.Settings, v1.UpdateSettingsResponse]
	listSettings         *connect.Client[v1.ListSettingsResponse, v1.Settings]
	listSupportedClients *connect.Client[v1.ListSupportedClientsRequest, v1.ListSupportedClientsResponse]
}

// UpdateSettings calls settings.v1.SettingsService.UpdateSettings.
func (c *settingsServiceClient) UpdateSettings(ctx context.Context, req *connect.Request[v1.Settings]) (*connect.Response[v1.UpdateSettingsResponse], error) {
	return c.updateSettings.CallUnary(ctx, req)
}

// ListSettings calls settings.v1.SettingsService.ListSettings.
func (c *settingsServiceClient) ListSettings(ctx context.Context, req *connect.Request[v1.ListSettingsResponse]) (*connect.Response[v1.Settings], error) {
	return c.listSettings.CallUnary(ctx, req)
}

// ListSupportedClients calls settings.v1.SettingsService.ListSupportedClients.
func (c *settingsServiceClient) ListSupportedClients(ctx context.Context, req *connect.Request[v1.ListSupportedClientsRequest]) (*connect.Response[v1.ListSupportedClientsResponse], error) {
	return c.listSupportedClients.CallUnary(ctx, req)
}

// SettingsServiceHandler is an implementation of the settings.v1.SettingsService service.
type SettingsServiceHandler interface {
	UpdateSettings(context.Context, *connect.Request[v1.Settings]) (*connect.Response[v1.UpdateSettingsResponse], error)
	ListSettings(context.Context, *connect.Request[v1.ListSettingsResponse]) (*connect.Response[v1.Settings], error)
	ListSupportedClients(context.Context, *connect.Request[v1.ListSupportedClientsRequest]) (*connect.Response[v1.ListSupportedClientsResponse], error)
}

// NewSettingsServiceHandler builds an HTTP handler from the service implementation. It returns the
// path on which to mount the handler and the handler itself.
//
// By default, handlers support the Connect, gRPC, and gRPC-Web protocols with the binary Protobuf
// and JSON codecs. They also support gzip compression.
func NewSettingsServiceHandler(svc SettingsServiceHandler, opts ...connect.HandlerOption) (string, http.Handler) {
	settingsServiceMethods := v1.File_settings_v1_settings_proto.Services().ByName("SettingsService").Methods()
	settingsServiceUpdateSettingsHandler := connect.NewUnaryHandler(
		SettingsServiceUpdateSettingsProcedure,
		svc.UpdateSettings,
		connect.WithSchema(settingsServiceMethods.ByName("UpdateSettings")),
		connect.WithHandlerOptions(opts...),
	)
	settingsServiceListSettingsHandler := connect.NewUnaryHandler(
		SettingsServiceListSettingsProcedure,
		svc.ListSettings,
		connect.WithSchema(settingsServiceMethods.ByName("ListSettings")),
		connect.WithHandlerOptions(opts...),
	)
	settingsServiceListSupportedClientsHandler := connect.NewUnaryHandler(
		SettingsServiceListSupportedClientsProcedure,
		svc.ListSupportedClients,
		connect.WithSchema(settingsServiceMethods.ByName("ListSupportedClients")),
		connect.WithHandlerOptions(opts...),
	)
	return "/settings.v1.SettingsService/", http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		switch r.URL.Path {
		case SettingsServiceUpdateSettingsProcedure:
			settingsServiceUpdateSettingsHandler.ServeHTTP(w, r)
		case SettingsServiceListSettingsProcedure:
			settingsServiceListSettingsHandler.ServeHTTP(w, r)
		case SettingsServiceListSupportedClientsProcedure:
			settingsServiceListSupportedClientsHandler.ServeHTTP(w, r)
		default:
			http.NotFound(w, r)
		}
	})
}

// UnimplementedSettingsServiceHandler returns CodeUnimplemented from all methods.
type UnimplementedSettingsServiceHandler struct{}

func (UnimplementedSettingsServiceHandler) UpdateSettings(context.Context, *connect.Request[v1.Settings]) (*connect.Response[v1.UpdateSettingsResponse], error) {
	return nil, connect.NewError(connect.CodeUnimplemented, errors.New("settings.v1.SettingsService.UpdateSettings is not implemented"))
}

func (UnimplementedSettingsServiceHandler) ListSettings(context.Context, *connect.Request[v1.ListSettingsResponse]) (*connect.Response[v1.Settings], error) {
	return nil, connect.NewError(connect.CodeUnimplemented, errors.New("settings.v1.SettingsService.ListSettings is not implemented"))
}

func (UnimplementedSettingsServiceHandler) ListSupportedClients(context.Context, *connect.Request[v1.ListSupportedClientsRequest]) (*connect.Response[v1.ListSupportedClientsResponse], error) {
	return nil, connect.NewError(connect.CodeUnimplemented, errors.New("settings.v1.SettingsService.ListSupportedClients is not implemented"))
}
