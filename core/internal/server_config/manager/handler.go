package manager

import (
	"context"
	"fmt"

	"connectrpc.com/connect"
	v1 "github.com/RA341/gouda/generated/settings/v1"
	"github.com/RA341/gouda/internal/downloads"
	"github.com/RA341/gouda/internal/downloads/clients"
	"github.com/RA341/gouda/internal/info"
	"github.com/RA341/gouda/internal/server_config"
)

type Handler struct {
	// todo interface
	downloadSrv *downloads.DownloadService
}

func NewSettingsHandler(downloadService *downloads.DownloadService) *Handler {
	return &Handler{downloadSrv: downloadService}
}

func (srv *Handler) GetMetadata(_ context.Context, _ *connect.Request[v1.GetMetadataRequest]) (*connect.Response[v1.GetMetadataResponse], error) {
	return connect.NewResponse(&v1.GetMetadataResponse{
		Version:    info.Version,
		BinaryType: info.Flavour,
	}), nil
}

func (srv *Handler) UpdateSettings(_ context.Context, req *connect.Request[v1.Settings]) (*connect.Response[v1.UpdateSettingsResponse], error) {
	settings := req.Msg

	err := srv.downloadSrv.TestAndUpdateClient(&server_config.TorrentClient{
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
	_, err := srv.downloadSrv.TestClient(&server_config.TorrentClient{
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

func (srv *Handler) UpdateMamToken(ctx context.Context, c *connect.Request[v1.UpdateMamTokenRequest]) (*connect.Response[v1.UpdateMamTokenResponse], error) {
	return nil, fmt.Errorf("implement me UpdateMamToken")
}
