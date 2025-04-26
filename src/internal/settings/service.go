package settings

import (
	v1 "github.com/RA341/gouda/generated/settings/v1"
	"github.com/RA341/gouda/pkg"
)

// todo separate logic from handler

func setSettings(settings *v1.Settings) {
	pkg.ApiKey.Set(settings.ApiKey)
	pkg.ServerPort.Set(settings.ServerPort)
	pkg.DownloadCheckTimeout.Set(settings.DownloadCheckTimeout)
	pkg.IgnoreTimeout.Set(settings.IgnoreTimeout)

	if pkg.IsDesktopMode() {
		pkg.ExitOnClose.Set(settings.ExitOnClose)
	}

	pkg.CompleteFolder.Set(settings.CompleteFolder)
	pkg.DownloadFolder.Set(settings.DownloadFolder)
	pkg.TorrentsFolder.Set(settings.TorrentsFolder)
	pkg.Username.Set(settings.Username)
	pkg.Password.Set(settings.Password)
	pkg.UserUid.Set(settings.UserUid)
	pkg.GroupUid.Set(settings.GroupUid)
	pkg.TorrentType.Set(settings.TorrentName)
	pkg.TorrentProtocol.Set(settings.TorrentProtocol)
	pkg.TorrentHost.Set(settings.TorrentHost)
	pkg.TorrentUser.Set(settings.TorrentUser)
	pkg.TorrentPassword.Set(settings.TorrentPassword)
}
