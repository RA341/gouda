package server_config

import (
	"context"
	"fmt"

	"connectrpc.com/connect"
	v1 "github.com/RA341/gouda/generated/settings/v1"
	"github.com/RA341/gouda/internal/info"
)

type Handler struct {
	srv *Service
	// todo interface
}

func NewSettingsHandler(srv *Service) *Handler {
	return &Handler{srv: srv}
}

func (h *Handler) LoadSettings(context.Context, *connect.Request[v1.LoadSettingsRequest]) (*connect.Response[v1.LoadSettingsResponse], error) {
	data := h.srv.loadConfigToRPC()
	return connect.NewResponse(&v1.LoadSettingsResponse{
		Settings: data,
	}), nil
}

func (h *Handler) UpdateSettings(_ context.Context, req *connect.Request[v1.UpdateSettingsRequest]) (*connect.Response[v1.UpdateSettingsResponse], error) {
	settings := req.Msg.Settings

	err := h.srv.saveConfigFromRPC(settings)
	if err != nil {
		return nil, err
	}

	return connect.NewResponse(&v1.UpdateSettingsResponse{}), nil
}

func (h *Handler) GetMetadata(_ context.Context, _ *connect.Request[v1.GetMetadataRequest]) (*connect.Response[v1.GetMetadataResponse], error) {
	return connect.NewResponse(&v1.GetMetadataResponse{
		Version:    info.Version,
		BinaryType: info.Flavour,
	}), nil
}

func (h *Handler) TestClient(_ context.Context, c *connect.Request[v1.TorrentClient]) (*connect.Response[v1.TestTorrentResponse], error) {
	// todo
	//rpcClient := c.Msg
	//_, err := h.downloadSrv.TestClient(&sc.TorrentClient{
	//	ClientType: rpcClient.TorrentName,
	//	User:       rpcClient.TorrentUser,
	//	Password:   rpcClient.TorrentPassword,
	//	Protocol:   rpcClient.TorrentProtocol,
	//	Host:       rpcClient.TorrentHost,
	//})
	//if err != nil {
	//	return nil, err
	//}

	// successful connect
	return connect.NewResponse(&v1.TestTorrentResponse{}), nil
}

func (h *Handler) ListSupportedClients(_ context.Context, _ *connect.Request[v1.ListSupportedClientsRequest]) (*connect.Response[v1.ListSupportedClientsResponse], error) {
	// todo
	//supportedClients := clients.GetSupportedClients()
	//
	//res := connect.NewResponse(&v1.ListSupportedClientsResponse{
	//	Clients: supportedClients,
	//})

	return nil, fmt.Errorf("ListSupportedClients not implemented")
}

func (h *Handler) UpdateMamToken(ctx context.Context, c *connect.Request[v1.UpdateMamTokenRequest]) (*connect.Response[v1.UpdateMamTokenResponse], error) {
	return nil, fmt.Errorf("implement me UpdateMamToken")
}
