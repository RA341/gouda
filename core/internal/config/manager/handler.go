package manager

import (
	"context"

	"connectrpc.com/connect"
	v1 "github.com/RA341/gouda/generated/settings/v1"
	"github.com/RA341/gouda/internal/config"
	"github.com/RA341/gouda/internal/downloads"
	"github.com/RA341/gouda/internal/downloads/clients"
	"github.com/RA341/gouda/internal/info"
)

type Handler struct {
	downloadSrv *downloads.DownloadService
}

func NewSettingsHandler(downloadService *downloads.DownloadService) *Handler {
	return &Handler{downloadSrv: downloadService}
}

func (srv *Handler) GetMetadata(_ context.Context, _ *connect.Request[v1.GetMetadataRequest]) (*connect.Response[v1.GetMetadataResponse], error) {
	return connect.NewResponse(&v1.GetMetadataResponse{
		Version:    info.Version,
		BinaryType: string(info.Flavour),
	}), nil
}

func (srv *Handler) UpdateSettings(_ context.Context, req *connect.Request[v1.Settings]) (*connect.Response[v1.UpdateSettingsResponse], error) {
	settings := req.Msg

	err := srv.downloadSrv.TestAndUpdateClient(&config.TorrentClient{
		ClientType: settings.Client.TorrentName,
		User:       settings.Client.TorrentUser,
		Password:   settings.Client.TorrentPassword,
		Protocol:   settings.Client.TorrentProtocol,
		Host:       settings.Client.TorrentHost,
	})
	if err != nil {
		return nil, err
	}

	//if err = saveConfigFromRPC(settings); err != nil {
	//	return nil, err
	//}

	return connect.NewResponse(&v1.UpdateSettingsResponse{}), nil
}

func (srv *Handler) TestClient(_ context.Context, c *connect.Request[v1.TorrentClient]) (*connect.Response[v1.TestTorrentResponse], error) {
	rpcClient := c.Msg
	_, err := srv.downloadSrv.TestClient(&config.TorrentClient{
		ClientType: rpcClient.TorrentName,
		User:       rpcClient.TorrentUser,
		Password:   rpcClient.TorrentPassword,
		Protocol:   rpcClient.TorrentProtocol,
		Host:       rpcClient.TorrentHost,
	})
	if err != nil {
		return nil, err
	}

	// successful connect
	return connect.NewResponse(&v1.TestTorrentResponse{}), nil
}

func (srv *Handler) ListSettings(_ context.Context, _ *connect.Request[v1.ListSettingsResponse]) (*connect.Response[v1.Settings], error) {
	//rpcSettings := loadConfigToRPC()
	//res := connect.NewResponse(rpcSettings)
	// todo
	return connect.NewResponse(&v1.Settings{}), nil
}

func (srv *Handler) ListSupportedClients(_ context.Context, _ *connect.Request[v1.ListSupportedClientsRequest]) (*connect.Response[v1.ListSupportedClientsResponse], error) {
	supportedClients := clients.GetSupportedClients()

	res := connect.NewResponse(&v1.ListSupportedClientsResponse{
		Clients: supportedClients,
	})

	return res, nil
}
