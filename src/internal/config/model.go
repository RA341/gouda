package config

import (
	"encoding/json"
	"fmt"
	fu "github.com/RA341/gouda/pkg/file_utils"
	"os"
	"sync"
	"time"
)

type GoudaConfig struct {
	RW *sync.RWMutex `json:"-"`

	Port           int             `json:"port" config:"flag=port,env=PORT,default=9862,usage=Port to run gouda on"`
	AllowedOrigins string          `json:"allowedOrigins" config:"flag=origins,env=ORIGINS,default=*,usage=Allowed origins for the API (in CSV)"`
	UIPath         string          `json:"uiPath" config:"flag=ui,env=UI_PATH,default=web,usage=Path to frontend files"`
	Auth           bool            `json:"auth" config:"flag=auth,env=AUTH_ENABLE,default=true,usage=Enable gouda auth"`
	MamToken       string          `json:"mamToken" config:"flag=mam,env=MAM_TOKEN,default=,usage=myanaonmouse token,hide=true"`
	Dir            Directories     `json:"dir" config:""`
	Log            Logger          `json:"log" config:""`
	Downloader     Downloader      `json:"downloader" config:""`
	Permissions    UserPermissions `json:"permissions" config:""`
	TorrentClient  TorrentClient   `json:"torrentClient" config:""`
}

// DumpToJSON writes the GoudaConfig to a JSON file
func (cfg *GoudaConfig) DumpToJSON() error {
	filename := GoudaJSON

	file, err := os.Create(filename)
	if err != nil {
		return fmt.Errorf("failed to create config file: %w", err)
	}
	defer fu.Close(file)

	encoder := json.NewEncoder(file)
	encoder.SetIndent("", "  ") // pretty print
	if err = encoder.Encode(cfg); err != nil {
		return fmt.Errorf("failed to encode config to JSON: %w", err)
	}
	return nil
}

// LoadFromJSON reads the GoudaConfig from a JSON file
func (cfg *GoudaConfig) LoadFromJSON() error {
	filename := GoudaJSON

	file, err := os.Open(filename)
	if err != nil {
		return fmt.Errorf("failed to open config file: %w", err)
	}
	defer fu.Close(file)

	decoder := json.NewDecoder(file)
	if err = decoder.Decode(cfg); err != nil {
		return fmt.Errorf("failed to decode config from JSON: %w", err)
	}
	return nil
}

type Directories struct {
	ConfigDir   string `json:"configDir" config:"flag=cf,env=CONFIG,default=./config,usage=Directory to store gouda config"`
	DownloadDir string `json:"downloadDir" config:"flag=df,env=DOWNLOAD,default=./download,usage=Directory to store download files"`
	CompleteDir string `json:"completeDir" config:"flag=cmf,env=COMPLETE,default=./complete,usage=Directory for completed files"`
	TorrentDir  string `json:"torrentDir" config:"flag=tf,env=TORRENT,default=./torrent,usage=Directory for storing torrent files"`
}

type Logger struct {
	Level   string `json:"level" config:"flag=logLevel,env=LOG_LEVEL,default=info,usage=disabled|debug|info|warn|error|fatal"`
	Verbose bool   `json:"verbose" config:"flag=logVerbose,env=LOG_VERBOSE,default=false,usage=show more info in logs"`
}

type Downloader struct {
	Timeout       string `json:"timeout" config:"flag=dt,env=TIMEOUT,default=15m,usage=300ms/1.5h/2h45m. Valid units ns/us/ms/s/m/h"`
	IgnoreTimeout bool   `json:"ignoreTimeout" config:"flag=digt,env=IGNORE_TIMEOUT,default=false,usage=Ignore time limit for download"`
}

type UserPermissions struct {
	UID int `json:"uid" config:"flag=uid,env=UID,default=1000,usage=User ID permissions for files"`
	GID int `json:"gid" config:"flag=gid,env=GID,default=1000,usage=Group ID permissions for files"`
}

type TorrentClient struct {
	ClientType string `json:"clientType" config:"flag=ct,env=CLIENT_TYPE,default=,usage=Client: qbit|transmission|deluge"`
	User       string `json:"user" config:"flag=torUser,env=TORRENT_USER,default=,usage=Username for torrent client authentication"`
	Password   string `json:"password" config:"flag=torPass,env=TORRENT_PASSWORD,default=,usage=Password for torrent client authentication"`
	Protocol   string `json:"protocol" config:"flag=torProto,env=TORRENT_PROTOCOL,default=http,usage=Protocol for torrent client connection http|https,hide=true"`
	Host       string `json:"host" config:"flag=host,env=TORRENT_HOST,default=localhost:8080,usage=Host e.g. localhost:8080|qbit.somedomain.com"`
}

func (d Downloader) GetLimit() (time.Duration, error) {
	return time.ParseDuration(d.Timeout)
}
