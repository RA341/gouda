package pkg

import (
	v1 "github.com/RA341/gouda/generated/settings/v1"
	"github.com/spf13/viper"
	"time"
)

var (
	// internal use
	LogDir = Config{LogDirKey}
	DbPath = Config{DbPathKey}
	// general
	ApiKey               = Config{ApiKeyKey}
	ServerPort           = Config{ServerPortKey}
	DownloadCheckTimeout = Config{DownloadCheckTimeoutKey}
	IgnoreTimeout        = Config{IgnoreTimeoutKey}
	ExitOnClose          = Config{ExitOnCloseKey}
	// folder stuff
	CompleteFolder = Config{CompleteFolderKey}
	DownloadFolder = Config{DownloadFolderKey}
	TorrentsFolder = Config{TorrentsFolderKey}
	// user
	Username    = Config{UsernameKey}
	Password    = Config{PasswordKey}
	UserUid     = Config{UserUidKey}
	GroupUid    = Config{GroupUidKey}
	UserSession = Config{UserSessionKey}
	// torrent management
	TorrentType     = Config{TorrentTypeKey}
	TorrentProtocol = Config{TorrentProtocolKey}
	TorrentHost     = Config{TorrentHostKey}
	TorrentUser     = Config{TorrentUserNameKey}
	TorrentPassword = Config{TorrentPasswordKey}
)

const (
	DbPathKey               = "db_path"
	LogDirKey               = "log_dir"
	ApiKeyKey               = "apikey"
	ServerPortKey           = "server.port"
	DownloadCheckTimeoutKey = "download.timeout"
	IgnoreTimeoutKey        = "download.ignore_timeout"
	ExitOnCloseKey          = "exit_on_close"

	CompleteFolderKey = "folder.defaults"
	DownloadFolderKey = "folder.downloads"
	TorrentsFolderKey = "folder.torrents"

	UsernameKey    = "user.name"
	PasswordKey    = "user.password"
	UserUidKey     = "user.uid"
	GroupUidKey    = "user.gid"
	UserSessionKey = "user.session"

	TorrentHostKey     = "torrent_client.host"
	TorrentTypeKey     = "torrent_client.name"
	TorrentPasswordKey = "torrent_client.password"
	TorrentProtocolKey = "torrent_client.protocol"
	TorrentUserNameKey = "torrent_client.user"
)

type Config struct {
	ConfigKey string
}

func (c Config) Set(value any) {
	viper.Set(c.ConfigKey, value)
}

func (c Config) GetStr() string {
	return viper.GetString(c.ConfigKey)
}

func (c Config) GetInt() int {
	return viper.GetInt(c.ConfigKey)
}

func (c Config) GetDuration() time.Duration {
	return viper.GetDuration(c.ConfigKey)
}

func (c Config) GetBool() bool {
	return viper.GetBool(c.ConfigKey)
}

func (c Config) GetUint64() uint64 {
	return viper.GetUint64(c.ConfigKey)
}

func SetSettings(settings *v1.Settings) {
	ApiKey.Set(settings.ApiKey)
	ServerPort.Set(settings.ServerPort)
	DownloadCheckTimeout.Set(settings.DownloadCheckTimeout)
	IgnoreTimeout.Set(settings.IgnoreTimeout)

	if IsDesktopMode() {
		ExitOnClose.Set(settings.ExitOnClose)
	}

	CompleteFolder.Set(settings.CompleteFolder)
	DownloadFolder.Set(settings.DownloadFolder)
	TorrentsFolder.Set(settings.TorrentsFolder)
	Username.Set(settings.Username)
	Password.Set(settings.Password)
	UserUid.Set(settings.UserUid)
	GroupUid.Set(settings.GroupUid)
	TorrentType.Set(settings.TorrentName)
	TorrentProtocol.Set(settings.TorrentProtocol)
	TorrentHost.Set(settings.TorrentHost)
	TorrentUser.Set(settings.TorrentUser)
	TorrentPassword.Set(settings.TorrentPassword)
}
