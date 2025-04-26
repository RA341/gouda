package pkg

import (
	"crypto/rand"
	"encoding/hex"
	"errors"
	"fmt"
	"github.com/joho/godotenv"
	"github.com/rs/zerolog/log"
	"github.com/spf13/viper"
	"os"
	"strconv"
)

// loadEnv load .env file
func loadEnv() {
	err := godotenv.Load()
	if err != nil {
		log.Warn().Err(err).Msgf("could not load .env file, if you do not have a \".env\" file you can safely ignore this warning")
	}
}

func InitConfig() {
	loadEnv()
	baseDir := getBaseDir()
	configDir := getConfigDir(baseDir)
	defer func() {
		// reinitialize logger with log file output, once a log directory has been set by viper
		InitFileLogger()
	}()

	viper.SetConfigName("config")
	viper.SetConfigType("json")
	viper.AddConfigPath(configDir)

	err := setupConfigOptions(configDir, baseDir)
	if err != nil {
		log.Fatal().Err(err).Msg("could not setup config options")
	}

	if err := viper.SafeWriteConfig(); err != nil {
		var configFileAlreadyExistsError viper.ConfigFileAlreadyExistsError
		if !errors.As(err, &configFileAlreadyExistsError) {
			log.Fatal().Err(err).Msg("viper could not write to config file")
		}
	}

	err = viper.ReadInConfig()
	if err != nil {
		log.Fatal().Err(err).Msg("could not read config file")
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
	key, err := GenerateToken(32)
	if err != nil {
		log.Fatal().Msgf("Failed to create api key")
	}

	// Set general settings
	viper.SetDefault(ApiKey.s(), key)
	viper.SetDefault(ServerPort.s(), "9862")
	viper.SetDefault(DownloadCheckTimeout.s(), 15)
	viper.SetDefault(IgnoreTimeout.s(), false)
	if IsDesktopMode() {
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

func getBaseDir() string {
	baseDir := "./appdata"
	if os.Getenv("IS_DOCKER") != "" {
		baseDir = "/appdata"
	}
	return baseDir
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

func GenerateToken(len int) (string, error) {
	b := make([]byte, len)
	_, err := rand.Read(b)
	if err != nil {
		return "", err
	}
	return hex.EncodeToString(b), nil
}
