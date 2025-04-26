package settings

import (
	v1 "github.com/RA341/gouda/generated/settings/v1"
	"github.com/RA341/gouda/internal/config"
	"github.com/RA341/gouda/internal/info"
)

// todo separate logic from handler

func setSettings(settings *v1.Settings) {
	config.ApiKey.Set(settings.ApiKey)
	config.ServerPort.Set(settings.ServerPort)
	config.DownloadCheckTimeout.Set(settings.DownloadCheckTimeout)
	config.IgnoreTimeout.Set(settings.IgnoreTimeout)

	if info.IsDesktopMode() {
		config.ExitOnClose.Set(settings.ExitOnClose)
	}

	config.CompleteFolder.Set(settings.CompleteFolder)
	config.DownloadFolder.Set(settings.DownloadFolder)
	config.TorrentsFolder.Set(settings.TorrentsFolder)
	config.Username.Set(settings.Username)
	config.Password.Set(settings.Password)
	config.UserUid.Set(settings.UserUid)
	config.GroupUid.Set(settings.GroupUid)
	config.TorrentType.Set(settings.TorrentName)
	config.TorrentProtocol.Set(settings.TorrentProtocol)
	config.TorrentHost.Set(settings.TorrentHost)
	config.TorrentUser.Set(settings.TorrentUser)
	config.TorrentPassword.Set(settings.TorrentPassword)
}
