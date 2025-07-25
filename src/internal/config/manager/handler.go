package manager

import (
	"connectrpc.com/connect"
	"context"
	v1 "github.com/RA341/gouda/generated/settings/v1"
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

	err := srv.downloadSrv.TestAndUpdateClient(&clients.TorrentClient{
		User:     settings.Client.TorrentUser,
		Password: settings.Client.TorrentPassword,
		Protocol: settings.Client.TorrentProtocol,
		Host:     settings.Client.TorrentHost,
		Type:     settings.Client.TorrentName,
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
	_, err := srv.downloadSrv.TestClient(&clients.TorrentClient{
		User:     rpcClient.TorrentUser,
		Password: rpcClient.TorrentPassword,
		Protocol: rpcClient.TorrentProtocol,
		Host:     rpcClient.TorrentHost,
		Type:     rpcClient.TorrentName,
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

//
//func loadConfigFromRPC(settings *settingsrpc.Settings) {
//	//config.ApiKey.Set(settings.ApiKey)
//	//config.ServerPort.Set(settings.ServerPort)
//	//config.DownloadCheckTimeout.Set(settings.DownloadCheckTimeout)
//	//config.IgnoreTimeout.Set(settings.IgnoreTimeout)
//	//config.SetupComplete.Set(settings.SetupComplete)
//	//config.CompleteFolder.Set(settings.CompleteFolder)
//	//config.DownloadFolder.Set(settings.DownloadFolder)
//	//config.TorrentsFolder.Set(settings.TorrentsFolder)
//	//config.Username.Set(settings.Username)
//	//config.Password.Set(settings.Password)
//	//config.UserUid.Set(settings.UserUid)
//	//config.GroupUid.Set(settings.GroupUid)
//	//config.TorrentType.Set(settings.Client.TorrentName)
//	//config.TorrentProtocol.Set(settings.Client.TorrentProtocol)
//	//config.TorrentHost.Set(settings.Client.TorrentHost)
//	//config.TorrentUser.Set(settings.Client.TorrentUser)
//	//config.TorrentPassword.Set(settings.Client.TorrentPassword)
//	//
//	//if info.IsDesktopMode() {
//	//	config.ExitOnClose.Set(settings.ExitOnClose)
//	//}
//}
//
//func loadConfigToRPC() {
//
//	//settings := &settingsrpc.Settings{
//	//	// general
//	//	ApiKey:               config.ApiKey.GetStr(),
//	//	ServerPort:           config.ServerPort.GetStr(),
//	//	DownloadCheckTimeout: config.DownloadCheckTimeout.GetUint64(),
//	//	IgnoreTimeout:        config.IgnoreTimeout.GetBool(),
//	//	// folder settings
//	//	CompleteFolder: config.CompleteFolder.GetStr(),
//	//	DownloadFolder: config.DownloadFolder.GetStr(),
//	//	TorrentsFolder: config.TorrentsFolder.GetStr(),
//	//	// user auth
//	//	Username: config.Username.GetStr(),
//	//	Password: config.Password.GetStr(),
//	//	UserUid:  config.UserUid.GetUint64(),
//	//	GroupUid: config.GroupUid.GetUint64(),
//	//	// torrent stuff
//	//	Client: &settingsrpc.TorrentClient{
//	//		TorrentName:     config.TorrentType.GetStr(),
//	//		TorrentHost:     config.TorrentHost.GetStr(),
//	//		TorrentProtocol: config.TorrentProtocol.GetStr(),
//	//		TorrentPassword: config.TorrentPassword.GetStr(),
//	//		TorrentUser:     config.TorrentUser.GetStr(),
//	//	},
//	//	SetupComplete: config.SetupComplete.GetBool(),
//	//}
//	//
//	//if info.IsDesktopMode() {
//	//	settings.ExitOnClose = config.ExitOnClose.GetBool()
//	//}
//	//return settings
//}
