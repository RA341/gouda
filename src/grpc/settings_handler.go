package api

import (
	"connectrpc.com/connect"
	"context"
	"fmt"
	"github.com/RA341/gouda/download_clients"
	v1 "github.com/RA341/gouda/generated/settings/v1"
	types "github.com/RA341/gouda/models"
	"github.com/RA341/gouda/service"
	"github.com/RA341/gouda/utils"
	"github.com/rs/zerolog/log"
	"github.com/spf13/viper"
)

type SettingsHandler struct {
	downloadSrv *service.DownloadService
}

func (setSrv *SettingsHandler) GetMetadata(_ context.Context, _ *connect.Request[v1.GetMetadataRequest]) (*connect.Response[v1.GetMetadataResponse], error) {
	return connect.NewResponse(&v1.GetMetadataResponse{
		Version:    utils.Version,
		BinaryType: utils.BinaryType,
	}), nil
}

func (setSrv *SettingsHandler) UpdateSettings(_ context.Context, req *connect.Request[v1.Settings]) (*connect.Response[v1.UpdateSettingsResponse], error) {
	settings := req.Msg

	client, err := download_clients.CheckTorrentClient(&types.TorrentClient{
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

	utils.SetSettings(settings)
	// Save the configuration to file
	err = viper.WriteConfig()
	if err != nil {
		return nil, fmt.Errorf("unable to save settings %v", err.Error())
	}

	log.Debug().Msg("settings saved")

	return connect.NewResponse(&v1.UpdateSettingsResponse{}), nil
}

func (setSrv *SettingsHandler) ListSettings(_ context.Context, _ *connect.Request[v1.ListSettingsResponse]) (*connect.Response[v1.Settings], error) {
	res := connect.NewResponse(&v1.Settings{
		// general
		ApiKey:               utils.ApiKey.GetStr(),
		ServerPort:           utils.ServerPort.GetStr(),
		DownloadCheckTimeout: utils.DownloadCheckTimeout.GetUint64(),
		IgnoreTimeout:        utils.IgnoreTimeout.GetBool(),
		// folder settings
		CompleteFolder: utils.CompleteFolder.GetStr(),
		DownloadFolder: utils.DownloadFolder.GetStr(),
		TorrentsFolder: utils.TorrentsFolder.GetStr(),
		// user auth
		Username: utils.Username.GetStr(),
		Password: utils.Password.GetStr(),
		UserUid:  utils.UserUid.GetUint64(),
		GroupUid: utils.GroupUid.GetUint64(),
		// torrent stuff
		TorrentName:     utils.TorrentType.GetStr(),
		TorrentHost:     utils.TorrentHost.GetStr(),
		TorrentProtocol: utils.TorrentProtocol.GetStr(),
		TorrentPassword: utils.TorrentPassword.GetStr(),
		TorrentUser:     utils.TorrentUser.GetStr(),
	})

	if utils.IsDesktopMode() {
		res.Msg.ExitOnClose = utils.ExitOnClose.GetBool()
	}

	return res, nil
}

func (setSrv *SettingsHandler) ListSupportedClients(_ context.Context, _ *connect.Request[v1.ListSupportedClientsRequest]) (*connect.Response[v1.ListSupportedClientsResponse], error) {
	clients := download_clients.GetSupportedClients()

	res := connect.NewResponse(&v1.ListSupportedClientsResponse{
		Clients: clients,
	})

	return res, nil
}
