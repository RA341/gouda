package settings

import (
	"connectrpc.com/connect"
	"context"
	"fmt"
	v1 "github.com/RA341/gouda/generated/settings/v1"
	"github.com/RA341/gouda/internal/download_clients"
	media "github.com/RA341/gouda/internal/media_requests"
	"github.com/RA341/gouda/pkg"
	"github.com/rs/zerolog/log"
	"github.com/spf13/viper"
)

type Handler struct {
	downloadSrv *media.DownloadService
}

func NewSettingsHandler(downloadService *media.DownloadService) *Handler {
	return &Handler{downloadSrv: downloadService}
}

func (setSrv *Handler) GetMetadata(_ context.Context, _ *connect.Request[v1.GetMetadataRequest]) (*connect.Response[v1.GetMetadataResponse], error) {
	return connect.NewResponse(&v1.GetMetadataResponse{
		Version:    pkg.Version,
		BinaryType: string(pkg.Flavour),
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

	pkg.SetSettings(settings)
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
		ApiKey:               pkg.ApiKey.GetStr(),
		ServerPort:           pkg.ServerPort.GetStr(),
		DownloadCheckTimeout: pkg.DownloadCheckTimeout.GetUint64(),
		IgnoreTimeout:        pkg.IgnoreTimeout.GetBool(),
		// folder settings
		CompleteFolder: pkg.CompleteFolder.GetStr(),
		DownloadFolder: pkg.DownloadFolder.GetStr(),
		TorrentsFolder: pkg.TorrentsFolder.GetStr(),
		// user auth
		Username: pkg.Username.GetStr(),
		Password: pkg.Password.GetStr(),
		UserUid:  pkg.UserUid.GetUint64(),
		GroupUid: pkg.GroupUid.GetUint64(),
		// torrent stuff
		TorrentName:     pkg.TorrentType.GetStr(),
		TorrentHost:     pkg.TorrentHost.GetStr(),
		TorrentProtocol: pkg.TorrentProtocol.GetStr(),
		TorrentPassword: pkg.TorrentPassword.GetStr(),
		TorrentUser:     pkg.TorrentUser.GetStr(),
	})

	if pkg.IsDesktopMode() {
		res.Msg.ExitOnClose = pkg.ExitOnClose.GetBool()
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
