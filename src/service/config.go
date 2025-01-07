package service

import (
	"errors"
	"fmt"
	"github.com/joho/godotenv"
	"github.com/rs/zerolog/log"
	"github.com/spf13/viper"
	"os"
	"strconv"
)

func InitConfig() error {
	err := godotenv.Load()
	if err != nil {
		log.Warn().Err(err).Msgf("could not load .env file, if you do not have \".env\" file you can ignore this warning")
	}

	viper.AutomaticEnv()

	baseDir := "./appdata"
	if os.Getenv("IS_DOCKER") != "" {
		baseDir = "/appdata"
	}

	configDir := "config"
	configDir = fmt.Sprintf("%s/%s", baseDir, configDir)
	err = os.MkdirAll(configDir, DefaultFilePerm)
	if err != nil {
		return err
	}

	// create log directory
	logDir := fmt.Sprintf("%s/logs/app.log", configDir)
	viper.SetDefault("log_dir", logDir)

	user, pass := os.Getenv("GOUDA_USERNAME"), os.Getenv("GOUDA_PASS")
	if user == "" || pass == "" {
		log.Fatal().Msgf("A username and password must be set. use GOUDA_USERNAME and GOUDA_PASS environment variables or add them to .env file from where you are executing this program")
	}

	viper.SetConfigName("config")
	viper.SetConfigType("json")
	viper.AddConfigPath(configDir)

	// set database path
	viper.SetDefault("db_path", fmt.Sprintf("%s/gouda_database.db", configDir))

	// set apikey
	key, err := GenerateToken(32)
	if err != nil {
		log.Fatal().Msgf("Failed to create api key")
	}
	viper.SetDefault("apikey", key)

	// Set defaults
	viper.SetDefault("server.port", "9862")
	viper.SetDefault("user.name", user)
	viper.SetDefault("user.password", pass)
	viper.SetDefault("download.timeout", 15)

	uid, err := strconv.Atoi(os.Getenv("GOUDA_UID"))
	if err != nil {
		uid = 1000
	}
	viper.SetDefault("user.uid", uid)

	gid, err := strconv.Atoi(os.Getenv("GOUDA_GID"))
	if err != nil {
		gid = 1000
	}
	viper.SetDefault("user.gid", gid)

	// default dirs
	downloadDir := os.Getenv("GOUDA_DOWNLOAD_DIR")
	if downloadDir == "" {
		downloadDir = fmt.Sprintf("%s/%s", baseDir, "downloads")
	}
	viper.SetDefault("folder.downloads", downloadDir)
	err = os.MkdirAll(downloadDir, DefaultFilePerm)
	if err != nil {
		return err
	}

	defaultDir := os.Getenv("GOUDA_DEFAULT_DIR")
	if defaultDir == "" {
		defaultDir = fmt.Sprintf("%s/%s", baseDir, "complete")
	}
	viper.SetDefault("folder.defaults", defaultDir)
	err = os.MkdirAll(defaultDir, DefaultFilePerm)
	if err != nil {
		return err
	}

	torrentDir := os.Getenv("GOUDA_TORRENT_DIR")
	if torrentDir == "" {
		torrentDir = fmt.Sprintf("%s/%s", baseDir, "torrents")
	}
	viper.SetDefault("folder.torrents", torrentDir)
	err = os.MkdirAll(torrentDir, DefaultFilePerm)
	if err != nil {
		return err
	}

	if err := viper.SafeWriteConfig(); err != nil {
		var configFileAlreadyExistsError viper.ConfigFileAlreadyExistsError
		if !errors.As(err, &configFileAlreadyExistsError) {
			return err
		}
	}

	return viper.ReadInConfig()
}
