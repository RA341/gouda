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
	err := h.srv.saveConfigWithValidation(settings)
	if err != nil {
		return nil, err
	}

	return connect.NewResponse(&v1.UpdateSettingsResponse{}), nil
}

func (h *Handler) UpdateMamSettings(ctx context.Context, req *connect.Request[v1.UpdateMamSettingsRequest]) (*connect.Response[v1.UpdateMamSettingsResponse], error) {
	err := h.srv.updateMam(req.Msg.MamToken)
	if err != nil {
		return nil, err
	}

	return connect.NewResponse(&v1.UpdateMamSettingsResponse{}), nil
}

func (h *Handler) UpdateTorrentClient(ctx context.Context, req *connect.Request[v1.UpdateTorrentClientRequest]) (*connect.Response[v1.UpdateTorrentClientResponse], error) {
	client := TorrentClientFromRpc(req.Msg.Client)
	err := h.srv.updateTorrentClient(client)
	if err != nil {
		return nil, err
	}

	return connect.NewResponse(&v1.UpdateTorrentClientResponse{}), nil
}

func (h *Handler) UpdateFolderPaths(ctx context.Context, req *connect.Request[v1.UpdateFolderPathsRequest]) (*connect.Response[v1.UpdateFolderPathsResponse], error) {

	//TODO implement me
	return nil, fmt.Errorf("implement me UpdateFolderPaths")
}

func (h *Handler) ListDirectories(_ context.Context, req *connect.Request[v1.ListDirectoriesRequest]) (*connect.Response[v1.ListDirectoriesResponse], error) {
	folders, files, err := h.srv.listDir(req.Msg.FilePath)
	if err != nil {
		return nil, err
	}

	return connect.NewResponse(
		&v1.ListDirectoriesResponse{
			Folders: folders,
			Files:   files,
		}), nil
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
