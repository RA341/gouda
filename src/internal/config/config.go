package config

import (
	"flag"
	"fmt"
	"github.com/RA341/gouda/pkg/argos"
	fu "github.com/RA341/gouda/pkg/file_utils"
	"github.com/joho/godotenv"
	"github.com/rs/zerolog/log"
	"gorm.io/gorm"
	"io/fs"
	"time"
)

type GoudaConfig struct {
	gorm.Model
	Port           int             `config:"flag=port,env=PORT,default=9862,usage=Port to run gouda on"`
	AllowedOrigins string          `config:"flag=origins,env=ORIGINS,default=*,usage=Allowed origins for the API (in CSV)"`
	UIPath         string          `config:"flag=ui,env=UI_PATH,default=web,usage=Path to frontend files"`
	Auth           bool            `config:"flag=auth,env=AUTH_ENABLE,default=true,usage=Enable gouda auth"`
	MamToken       string          `config:"flag=mam,env=MAM_TOKEN,default=,usage=myanaonmouse token,hide=true"`
	Dir            Directories     `config:""`
	Log            Logger          `config:""`
	Downloader     Downloader      `config:""`
	Permissions    UserPermissions `config:""`
	UIFS           fs.FS           `gorm:"-"`
}

type Directories struct {
	ConfigDir   string `config:"flag=cf,env=CONFIG,default=./config,usage=Directory to store gouda config"`
	DownloadDir string `config:"flag=df,env=DOWNLOAD,default=./download,usage=Directory to store download files"`
	CompleteDir string `config:"flag=cmf,env=COMPLETE,default=./complete,usage=Directory for completed files"`
	TorrentDir  string `config:"flag=tf,env=TORRENT,default=./torrent,usage=Directory for storing torrent files"`
}

type Logger struct {
	Level   string `config:"flag=logLevel,env=LOG_LEVEL,default=info,usage=disabled|debug|info|warn|error|fatal"`
	Verbose bool   `config:"flag=logVerbose,env=LOG_VERBOSE,default=false,usage=show more info in logs"`
}

type Downloader struct {
	Timeout       string `config:"flag=dt,env=TIMEOUT,default=15m,usage=300ms/1.5h/2h45m. Valid units ns/us/ms/s/m/h"`
	IgnoreTimeout bool   `config:"flag=digt,env=IGNORE_TIMEOUT,default=false,usage=Ignore time limit for download"`
}

type UserPermissions struct {
	UID int `config:"flag=uid,env=UID,default=1000,usage=User ID permissions for files"`
	GID int `config:"flag=gid,env=GID,default=1000,usage=Group ID permissions for files"`
}

func (d Downloader) GetLimit() (time.Duration, error) {
	return time.ParseDuration(d.Timeout)
}

const GoudaEnv = "GOUDA"

func LoadConf() (*GoudaConfig, error) {
	if err := godotenv.Load(); err != nil {
		log.Debug().Err(err).Msgf("Error loading .env file")
	}

	var conf GoudaConfig
	err := argos.Scan(&conf, GoudaEnv)
	if err != nil {
		return nil, fmt.Errorf("unable to setup config: %w", err)
	}
	flag.Parse() // load config

	err = fu.ResolvePaths([]*string{
		&conf.Dir.ConfigDir,
		&conf.Dir.TorrentDir,
		&conf.Dir.CompleteDir,
		&conf.Dir.DownloadDir,
	})
	if err != nil {
		return nil, fmt.Errorf("unable to resolve path: %w", err)
	}

	argos.PrettyPrint(conf, GoudaEnv)
	return &conf, nil
}
