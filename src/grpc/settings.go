package api

import (
	"connectrpc.com/connect"
	"context"
	"fmt"
	"github.com/RA341/gouda/download_clients"
	v1 "github.com/RA341/gouda/generated/settings/v1"
	models "github.com/RA341/gouda/models"
	"github.com/rs/zerolog/log"
	"github.com/spf13/viper"
)

type SettingsService struct {
	api *Env
}

func (setSrv *SettingsService) UpdateSettings(_ context.Context, req *connect.Request[v1.Settings]) (*connect.Response[v1.UpdateSettingsResponse], error) {
	settings := req.Msg

	client, err := download_clients.InitializeTorrentClient(models.TorrentClient{
		User:     settings.TorrentUser,
		Password: settings.TorrentPassword,
		Protocol: settings.TorrentProtocol,
		Host:     settings.TorrentHost,
		Type:     settings.TorrentName,
	})
	if err != nil {
		log.Fatal().Err(err).Msg("Unable to save torrent client")
		return nil, fmt.Errorf("unable to save torrent client: %v", err)
	}

	setSrv.api.DownloadClient = client

	// general
	viper.Set("apikey", settings.ApiKey)
	viper.Set("server.port", settings.ServerPort)
	viper.Set("download.timeout", settings.DownloadCheckTimeout)
	// folder settings
	viper.Set("folder.defaults", settings.CompleteFolder)
	viper.Set("folder.downloads", settings.DownloadFolder)
	viper.Set("folder.torrents", settings.TorrentsFolder)
	// user settings
	viper.Set("user.name", settings.Username)
	viper.Set("user.password", settings.Password)
	viper.Set("user.uid", settings.UserUid)
	viper.Set("user.gid", settings.GroupUid)
	// torrent client settings
	viper.Set("torrent_client.host", settings.TorrentHost)
	viper.Set("torrent_client.name", settings.TorrentName)
	viper.Set("torrent_client.password", settings.TorrentPassword)
	viper.Set("torrent_client.protocol", settings.TorrentProtocol)
	viper.Set("torrent_client.user", settings.TorrentUser)

	// Save the configuration to file
	err = viper.WriteConfig()
	if err != nil {
		return nil, fmt.Errorf("unable to save settings %v", err.Error())
	}

	return connect.NewResponse(&v1.UpdateSettingsResponse{}), nil
}

func (setSrv *SettingsService) ListSettings(_ context.Context, _ *connect.Request[v1.ListSettingsResponse]) (*connect.Response[v1.Settings], error) {
	res := connect.NewResponse(&v1.Settings{
		// general
		ApiKey:               viper.GetString("apikey"),
		ServerPort:           viper.GetString("server.port"),
		DownloadCheckTimeout: uint64(viper.GetInt("download.timeout")),
		// folder settings
		CompleteFolder: viper.GetString("folder.defaults"),
		DownloadFolder: viper.GetString("folder.downloads"),
		TorrentsFolder: viper.GetString("folder.torrents"),
		// user auth
		Username: viper.GetString("user.name"),
		Password: viper.GetString("user.password"),
		UserUid:  uint64(viper.GetInt("user.uid")),
		GroupUid: uint64(viper.GetInt("user.gid")),
		// torrent stuff
		TorrentHost:     viper.GetString("torrent_client.host"),
		TorrentName:     viper.GetString("torrent_client.name"),
		TorrentPassword: viper.GetString("torrent_client.password"),
		TorrentProtocol: viper.GetString("torrent_client.protocol"),
		TorrentUser:     viper.GetString("torrent_client.user"),
	})

	return res, nil
}
