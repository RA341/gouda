package main

import (
	"errors"
	"github.com/joho/godotenv"
	"github.com/spf13/viper"
	"gouda/api"
	"log"
	"os"
	"strconv"
)

var (
	DownloadFolder = ""

	//<map> category: download path

	//author name

)

func InitConfig() error {
	err := godotenv.Load()
	if err != nil {
		log.Println("Error loading .env file")
	}

	configDir := "."
	if os.Getenv("IS_DOCKER") != "" {
		configDir = "/config"
	}

	user, pass := os.Getenv("GOUDA_USERNAME"), os.Getenv("GOUDA_PASS")
	if user == "" || pass == "" {
		log.Fatal("A username and password must be set. use GOUDA_USERNAME and GOUDA_PASS environment variables or add them to .env file from where you are executing this program")
	}

	viper.SetConfigName("config")
	viper.SetConfigType("json")
	viper.AddConfigPath(configDir)

	key, err := api.GenerateToken(32)
	if err != nil {
		log.Fatal("Failed to create api key ", err)
	}

	viper.SetDefault("apikey", key)

	// Set defaults
	viper.SetDefault("server.port", "9862")
	viper.SetDefault("user.name", user)
	viper.SetDefault("user.password", pass)

	uid, err := strconv.Atoi(os.Getenv("GOUDA_UID"))
	if err != nil {
		uid = 1000
	}
	viper.SetDefault("user.uid", uid)

	gid, err := strconv.Atoi(os.Getenv("GOUDA_UID"))
	if err != nil {
		gid = 1000
	}
	viper.SetDefault("user.gid", gid)

	// default dirs
	downloadDir := os.Getenv("GOUDA_DOWNLOAD_DIR")
	if downloadDir == "" {
		downloadDir = "/downloads"
	}
	viper.SetDefault("folder.downloads", downloadDir)

	defaultDir := os.Getenv("GOUDA_DEFAULT_DIR")
	if defaultDir == "" {
		defaultDir = "/complete"
	}
	viper.SetDefault("folder.defaults", defaultDir)

	torrentDir := os.Getenv("GOUDA_TORRENT_DIR")
	if torrentDir == "" {
		torrentDir = "/torrents"
	}
	viper.SetDefault("folder.torrents", torrentDir)

	if err := viper.SafeWriteConfig(); err != nil {
		var configFileAlreadyExistsError viper.ConfigFileAlreadyExistsError
		if !errors.As(err, &configFileAlreadyExistsError) {
			return err
		}
	}

	return viper.ReadInConfig()
}
