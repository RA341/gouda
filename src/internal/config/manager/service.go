package manager

import (
	"fmt"
	settingsrpc "github.com/RA341/gouda/generated/settings/v1"
	"github.com/RA341/gouda/internal/config"
	"github.com/RA341/gouda/internal/info"
	"github.com/rs/zerolog/log"
	"github.com/spf13/viper"
)

// todo separate logic from handler

func loadConfigToRPC() *settingsrpc.Settings {
	settings := &settingsrpc.Settings{
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
		Client: &settingsrpc.TorrentClient{
			TorrentName:     config.TorrentType.GetStr(),
			TorrentHost:     config.TorrentHost.GetStr(),
			TorrentProtocol: config.TorrentProtocol.GetStr(),
			TorrentPassword: config.TorrentPassword.GetStr(),
			TorrentUser:     config.TorrentUser.GetStr(),
		},
		SetupComplete: config.SetupComplete.GetBool(),
	}

	if info.IsDesktopMode() {
		settings.ExitOnClose = config.ExitOnClose.GetBool()
	}
	return settings
}

func saveConfigFromRPC(settings *settingsrpc.Settings) error {
	loadConfigFromRPC(settings)
	// Save the config to file
	if err := viper.WriteConfig(); err != nil {
		return fmt.Errorf("unable to save settings %v", err.Error())
	}

	log.Debug().Msg("new settings from rpc saved")
	return nil
}

func loadConfigFromRPC(settings *settingsrpc.Settings) {
	config.ApiKey.Set(settings.ApiKey)
	config.ServerPort.Set(settings.ServerPort)
	config.DownloadCheckTimeout.Set(settings.DownloadCheckTimeout)
	config.IgnoreTimeout.Set(settings.IgnoreTimeout)
	config.SetupComplete.Set(settings.SetupComplete)
	config.CompleteFolder.Set(settings.CompleteFolder)
	config.DownloadFolder.Set(settings.DownloadFolder)
	config.TorrentsFolder.Set(settings.TorrentsFolder)
	config.Username.Set(settings.Username)
	config.Password.Set(settings.Password)
	config.UserUid.Set(settings.UserUid)
	config.GroupUid.Set(settings.GroupUid)
	config.TorrentType.Set(settings.Client.TorrentName)
	config.TorrentProtocol.Set(settings.Client.TorrentProtocol)
	config.TorrentHost.Set(settings.Client.TorrentHost)
	config.TorrentUser.Set(settings.Client.TorrentUser)
	config.TorrentPassword.Set(settings.Client.TorrentPassword)

	if info.IsDesktopMode() {
		config.ExitOnClose.Set(settings.ExitOnClose)
	}
}
