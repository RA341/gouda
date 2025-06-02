package config

import (
	"errors"
	"fmt"
	"github.com/RA341/gouda/internal/info"
	"github.com/RA341/gouda/pkg"
	"github.com/RA341/gouda/pkg/logger"
	"github.com/joho/godotenv"
	"github.com/rs/zerolog/log"
	"github.com/spf13/viper"
	"os"
	"path/filepath"
	"strconv"
)

func Load() {
	if err := godotenv.Load(); err != nil {
		log.Warn().Err(err).Msgf("could not load .env file, if you do not have a \".env\" file you can safely ignore this warning")
	}

	defer func() {
		level := "info" // default
		val, ok := os.LookupEnv("GOUDA_LOG_LEVEL")
		if ok {
			level = val
		}
		// reinitialize logger with log file output, once a log directory has been set by viper
		logger.FileConsoleLogger(LogDir.GetStr(), level)
		log.Info().Str("log_level", level).Msg("setting log level, set GOUDA_LOG_LEVEL env to change")
	}()

	baseDir, err := getBaseDir()
	if err != nil {
		log.Fatal().Err(err).Msgf("could not get base dir")
	}
	configDir := getConfigDir(baseDir)

	viper.SetConfigName("config")
	viper.SetConfigType("json")
	viper.AddConfigPath(configDir)

	err = setupConfigOptions(configDir, baseDir)
	if err != nil {
		log.Fatal().Err(err).Msg("could not setup config options")
	}

	var setupCompleted = true

	err = viper.ReadInConfig()
	if err != nil {
		var notfound viper.ConfigFileNotFoundError
		if !errors.As(err, &notfound) {
			log.Fatal().Err(err).Msg("could not read config file")
		}
		log.Debug().Msg("Config file not found. Setting setupComplete to false.")
		setupCompleted = false
	}

	viper.SetDefault(SetupComplete.s(), setupCompleted)

	if err := viper.SafeWriteConfig(); err != nil {
		var configFileAlreadyExistsError viper.ConfigFileAlreadyExistsError
		if !errors.As(err, &configFileAlreadyExistsError) {
			log.Fatal().Err(err).Msg("viper could not write to config file")
		}
	}

	log.Info().Msg("watching config file")
	viper.WatchConfig()

	if IsDebugMode() {
		log.Warn().Msgf("app is running in debug mode: AUTH IS IGNORED")
	}
	if Username.GetStr() == "admin" || Password.GetStr() == "admin" {
		log.Warn().Msgf("Default username or password detected make sure to change this via the web ui")
	}
	// maybe create viper instance and return from this function
	// future setup in case https://github.com/spf13/viper/issues/1855 is accepted
}

func getConfigDir(baseDir string) string {
	configDir := fmt.Sprintf("%s/%s", baseDir, "config")
	err := os.MkdirAll(configDir, DefaultFilePerm)
	if err != nil {
		log.Fatal().Err(err).Str("Config dir", configDir).Msgf("could not create config directory")
	}
	return configDir
}

func setupConfigOptions(configDir, baseDir string) error {
	// misc application files
	// set database path
	viper.SetDefault(DbPath.s(), fmt.Sprintf("%s/gouda_database.db", configDir))
	// create log directory
	viper.SetDefault(LogDir.s(), fmt.Sprintf("%s/logs/gouda.log", configDir))

	// create apikey
	key, err := pkg.GenerateToken(32)
	if err != nil {
		log.Fatal().Msgf("Failed to create api key")
	}

	// Set general settings
	viper.SetDefault(ApiKey.s(), key)
	viper.SetDefault(ServerPort.s(), "9862")
	viper.SetDefault(DownloadCheckTimeout.s(), 15)
	viper.SetDefault(IgnoreTimeout.s(), false)
	if info.IsDesktopMode() {
		viper.SetDefault(ExitOnClose.s(), false)
	}

	// user section
	viper.SetDefault(Username.s(), getStringEnvOrDefault("GOUDA_USERNAME", "admin"))
	viper.SetDefault(Password.s(), getStringEnvOrDefault("GOUDA_PASS", "admin"))
	viper.SetDefault(UserUid.s(), getIntEnvOrDefault("GOUDA_UID", 1000))
	viper.SetDefault(GroupUid.s(), getIntEnvOrDefault("GOUDA_UID", 1000)) // Note: Using GOUDA_UID for both User and Group UID default

	// directory setup
	defaultDir := getStringEnvOrDefault("GOUDA_COMPLETE_DIR", fmt.Sprintf("%s/%s", baseDir, "complete"))
	viper.SetDefault(CompleteFolder.s(), defaultDir)

	downloadDir := getStringEnvOrDefault("GOUDA_DOWNLOAD_DIR", fmt.Sprintf("%s/%s", baseDir, "downloads"))
	viper.SetDefault(DownloadFolder.s(), downloadDir)

	torrentDir := getStringEnvOrDefault("GOUDA_TORRENT_DIR", fmt.Sprintf("%s/%s", baseDir, "torrents"))
	viper.SetDefault(TorrentsFolder.s(), torrentDir)

	err = makeDirectories([]string{torrentDir, defaultDir, downloadDir})
	if err != nil {
		return fmt.Errorf("failed to create directories: %w", err)
	}

	return nil
}
func makeDirectories(dirs []string) error {
	for _, dir := range dirs {
		err := os.MkdirAll(dir, DefaultFilePerm)
		if err != nil {
			return fmt.Errorf("unable to create directory at %s: %v", dir, err)
		}
	}
	return nil
}

func getBaseDir() (string, error) {
	baseDir := "./appdata"
	if os.Getenv("IS_DOCKER") != "" {
		baseDir = "/appdata"
	}
	return filepath.Abs(baseDir)
}

func getStringEnvOrDefault(key, defaultVal string) string {
	value := os.Getenv(key)
	if value == "" {
		return defaultVal
	}
	return value
}

func getIntEnvOrDefault(key string, defaultVal int) int {
	value := os.Getenv(key)
	if value == "" {
		return defaultVal
	}

	atoi, err := strconv.Atoi(value)
	if err != nil {
		log.Warn().Msgf("Failed to convert %s:%s to int using default: %d", key, value, defaultVal)
		return defaultVal
	}

	return atoi
}

// GetConfigDir logfile is set to the main gouda config path,
// we get the base dir from that for desktop mode
func GetConfigDir() string {
	return filepath.Dir(LogDir.GetStr())
}
