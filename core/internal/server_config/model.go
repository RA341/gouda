package server_config

import (
	"sync"
	"time"
)

type GoudaConfig struct {
	RW sync.RWMutex `yaml:"-"`

	Port           int             `yaml:"port" config:"flag=port,env=PORT,default=9862,usage=Port to run gouda on"`
	AllowedOrigins string          `yaml:"allowedOrigins" config:"flag=origins,env=ORIGINS,default=*,usage=Allowed origins for the API (in CSV)"`
	UIPath         string          `yaml:"uiPath" config:"flag=ui,env=UI_PATH,default=web,usage=Path to frontend files"`
	MamToken       string          `yaml:"mamToken" config:"flag=mam,env=MAM_TOKEN,default=,usage=myanaonmouse token,hide=true"`
	Dir            Directories     `yaml:"dir" config:""`
	Log            Logger          `yaml:"log" config:""`
	Downloader     Downloader      `yaml:"downloader" config:""`
	Permissions    UserPermissions `yaml:"permissions" config:""`
	TorrentClient  TorrentClient   `yaml:"torrentClient" config:""`
}

func (cfg *GoudaConfig) GetVal() *GoudaConfig {
	cfg.RW.RLock()
	defer cfg.RW.RUnlock()

	return cfg
}

type Directories struct {
	DownloadDir string `yaml:"downloadDir" config:"flag=df,env=DOWNLOAD,default=./download,usage=Directory to store download files"`
	CompleteDir string `yaml:"completeDir" config:"flag=cmf,env=COMPLETE,default=./complete,usage=Directory for completed files"`
	TorrentDir  string `yaml:"torrentDir" config:"flag=tf,env=TORRENT,default=./torrent,usage=Directory for storing torrent files"`
}

type Logger struct {
	Level   string `yaml:"level" config:"flag=logLevel,env=LOG_LEVEL,default=info,usage=disabled|debug|info|warn|error|fatal"`
	Verbose bool   `yaml:"verbose" config:"flag=logVerbose,env=LOG_VERBOSE,default=false,usage=show more info in logs"`
}

type Downloader struct {
	Timeout       string `yaml:"timeout" config:"flag=dt,env=TIMEOUT,default=15m,usage=300ms/1.5h/2h45m. Valid units ns/us/ms/s/m/h"`
	IgnoreTimeout bool   `yaml:"ignoreTimeout" config:"flag=digt,env=IGNORE_TIMEOUT,default=false,usage=Ignore time limit for download"`
	CheckInterval string `yaml:"checkInterval" config:"flag=cit,env=CHECK_INTERVAL,default=1m,usage=Download check interval"`
}

func (d Downloader) GetDownloadLimit(defaultTime time.Duration) time.Duration {
	dur, err := time.ParseDuration(d.Timeout)
	if err != nil {
		return defaultTime
	}
	return dur
}

func (d Downloader) GetCheckInterval(defaultTime time.Duration) time.Duration {
	dur, err := time.ParseDuration(d.CheckInterval)
	if err != nil {
		return defaultTime
	}
	return dur
}

type UserPermissions struct {
	UID int `yaml:"uid" config:"flag=uid,env=UID,default=1000,usage=User ID permissions for files"`
	GID int `yaml:"gid" config:"flag=gid,env=GID,default=1000,usage=Group ID permissions for files"`
}

type TorrentClient struct {
	ClientType string `yaml:"clientType" config:"flag=ct,env=CLIENT_TYPE,default=,usage=Client: qbit|transmission|deluge"`
	User       string `yaml:"user" config:"flag=torUser,env=TORRENT_USER,default=,usage=Username for torrent client authentication"`
	Password   string `yaml:"password" config:"flag=torPass,env=TORRENT_PASSWORD,default=,usage=Password for torrent client authentication"`
	Protocol   string `yaml:"protocol" config:"flag=torProto,env=TORRENT_PROTOCOL,default=http,usage=Protocol for torrent client connection http|https,hide=true"`
	Host       string `yaml:"host" config:"flag=host,env=TORRENT_HOST,default=localhost:8080,usage=Host e.g. localhost:8080|qbit.somedomain.com"`
}
