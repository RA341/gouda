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

func (h *Handler) UpdateMam(_ context.Context, req *connect.Request[v1.UpdateMamRequest]) (*connect.Response[v1.UpdateMamResponse], error) {
	err := h.srv.updateMamToken(req.Msg.MamToken)
	if err != nil {
		return nil, err
	}

	return connect.NewResponse(&v1.UpdateMamResponse{}), nil

}

func (h *Handler) UpdateDownloader(_ context.Context, req *connect.Request[v1.UpdateDownloaderRequest]) (*connect.Response[v1.UpdateDownloaderResponse], error) {
	client := TorrentClientFromRpc(req.Msg.Client)
	downloader := DownloaderFromRpc(req.Msg.Downloader)

	err := h.srv.updateTorrentClient(client, downloader)
	if err != nil {
		return nil, err
	}

	return connect.NewResponse(&v1.UpdateDownloaderResponse{}), nil
}

func (h *Handler) UpdateDir(_ context.Context, req *connect.Request[v1.UpdateDirRequest]) (*connect.Response[v1.UpdateDirResponse], error) {
	client := DirectoryFromRpc(req.Msg.Dirs)
	err := h.srv.updateDirectory(client)
	if err != nil {
		return nil, err
	}

	return connect.NewResponse(&v1.UpdateDirResponse{}), nil
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

	return nil, fmt.Errorf("implement me TestClient")
}

func (h *Handler) ListSupportedClients(_ context.Context, _ *connect.Request[v1.ListSupportedClientsRequest]) (*connect.Response[v1.ListSupportedClientsResponse], error) {
	supportedClients, err := h.srv.supportedClientsProvider()
	if err != nil {
		return nil, err
	}

	res := v1.ListSupportedClientsResponse{
		Clients: supportedClients,
	}

	return connect.NewResponse(&res), nil
}

func (h *Handler) UpdateMamToken(ctx context.Context, req *connect.Request[v1.UpdateMamTokenRequest]) (*connect.Response[v1.UpdateMamTokenResponse], error) {

	return nil, fmt.Errorf("implement me UpdateMamToken")
}
