package settings

import (
	"connectrpc.com/connect"
	"context"
	"fmt"
	v1 "github.com/RA341/gouda/generated/settings/v1"
	"github.com/RA341/gouda/internal/config"
	"github.com/RA341/gouda/internal/download_clients"
	"github.com/RA341/gouda/internal/downloads"
	"github.com/RA341/gouda/internal/info"
	"github.com/rs/zerolog/log"
	"github.com/spf13/viper"
)

type Handler struct {
	downloadSrv *downloads.DownloadService
}

func NewSettingsHandler(downloadService *downloads.DownloadService) *Handler {
	return &Handler{downloadSrv: downloadService}
}

func (setSrv *Handler) GetMetadata(_ context.Context, _ *connect.Request[v1.GetMetadataRequest]) (*connect.Response[v1.GetMetadataResponse], error) {
	return connect.NewResponse(&v1.GetMetadataResponse{
		Version:    info.Version,
		BinaryType: string(info.Flavour),
	}), nil
}

func (setSrv *Handler) UpdateSettings(_ context.Context, req *connect.Request[v1.Settings]) (*connect.Response[v1.UpdateSettingsResponse], error) {
	settings := req.Msg

	client, err := download_clients.CheckTorrentClient(&download_clients.TorrentClient{
		User:     settings.TorrentUser,
		Password: settings.TorrentPassword,
		Protocol: settings.TorrentProtocol,
		Host:     settings.TorrentHost,
		Type:     settings.TorrentName,
	})
	if err != nil {
		log.Error().Err(err).Msg("Unable to connect torrent client")
		return nil, fmt.Errorf("unable to connect torrent client: %v", err)
	}

	setSrv.downloadSrv.SetClient(client)

	setSettings(settings)
	// Save the configuration to file
	err = viper.WriteConfig()
	if err != nil {
		return nil, fmt.Errorf("unable to save settings %v", err.Error())
	}

	log.Debug().Msg("settings saved")

	return connect.NewResponse(&v1.UpdateSettingsResponse{}), nil
}

func (setSrv *Handler) ListSettings(_ context.Context, _ *connect.Request[v1.ListSettingsResponse]) (*connect.Response[v1.Settings], error) {
	res := connect.NewResponse(&v1.Settings{
		// general
		ApiKey:               config.ApiKey.GetStr(),
		ServerPort:           config.ServerPort.GetStr(),
		DownloadCheckTimeout: config.DownloadCheckTimeout.GetUint64(),
		IgnoreTimeout:        config.IgnoreTimeout.GetBool(),
		// folder settings
		CompleteFolder: config.CompleteFolder.GetStr(),
		DownloadFolder: config.DownloadFolder.GetStr(),
		TorrentsFolder: config.TorrentsFolder.GetStr(),
		// user auth
		Username: config.Username.GetStr(),
		Password: config.Password.GetStr(),
		UserUid:  config.UserUid.GetUint64(),
		GroupUid: config.GroupUid.GetUint64(),
		// torrent stuff
		TorrentName:     config.TorrentType.GetStr(),
		TorrentHost:     config.TorrentHost.GetStr(),
		TorrentProtocol: config.TorrentProtocol.GetStr(),
		TorrentPassword: config.TorrentPassword.GetStr(),
		TorrentUser:     config.TorrentUser.GetStr(),
	})

	if info.IsDesktopMode() {
		res.Msg.ExitOnClose = config.ExitOnClose.GetBool()
	}

	return res, nil
}

func (setSrv *Handler) ListSupportedClients(_ context.Context, _ *connect.Request[v1.ListSupportedClientsRequest]) (*connect.Response[v1.ListSupportedClientsResponse], error) {
	clients := download_clients.GetSupportedClients()

	res := connect.NewResponse(&v1.ListSupportedClientsResponse{
		Clients: clients,
	})

	return res, nil
}
