package config

import (
	"github.com/spf13/viper"
	"time"
)

const (
	LogDir Config = "log_dir"
	DbPath Config = "db_path"

	SetupComplete        Config = "setup_complete"
	ApiKey               Config = "apikey"
	ServerPort           Config = "server.port"
	DownloadCheckTimeout Config = "download.timeout"
	IgnoreTimeout        Config = "download.ignore_timeout"
	ExitOnClose          Config = "exit_on_close"

	CompleteFolder Config = "folder.defaults"
	DownloadFolder Config = "folder.downloads"
	TorrentsFolder Config = "folder.torrents"

	Username    Config = "user.name"
	Password    Config = "user.password"
	UserUid     Config = "user.uid"
	GroupUid    Config = "user.gid"
	UserSession Config = "user.session"

	TorrentType     Config = "torrent_client.name"
	TorrentProtocol Config = "torrent_client.protocol"
	TorrentHost     Config = "torrent_client.host"
	TorrentUser     Config = "torrent_client.user"
	TorrentPassword Config = "torrent_client.password"
)

type Config string

// converts key to a string
func (c Config) s() string {
	return string(c)
}

func (c Config) Set(value any) {
	viper.Set(c.s(), value)
}

func (c Config) GetStr() string {
	return viper.GetString(c.s())
}

func (c Config) GetInt() int {
	return viper.GetInt(c.s())
}

func (c Config) GetDuration() time.Duration {
	return viper.GetDuration(c.s())
}

func (c Config) GetBool() bool {
	return viper.GetBool(c.s())
}

func (c Config) GetUint64() uint64 {
	return viper.GetUint64(c.s())
}
