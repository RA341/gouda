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

// DirExists checks if a directory exists and is actually a directory
func DirExists(path string) (bool, error) {
	info, err := os.Stat(path)
	if err != nil {
		if os.IsNotExist(err) {
			return false, nil // Directory doesn't exist
		}
		return false, err // Other error occurred
	}

	return info.IsDir(), nil
}

func setupConfigOptions(configDir, baseDir string) error {
	// misc application files
	// set database path
	viper.SetDefault("db_path", fmt.Sprintf("%s/gouda_database.db", configDir))
	// create log directory
	viper.SetDefault("log_dir", fmt.Sprintf("%s/logs/gouda.log", configDir))

	// create apikey
	key, err := GenerateToken(32)
	if err != nil {
		log.Fatal().Msgf("Failed to create api key")
	}

	// Set general settings
	viper.SetDefault("apikey", key)
	viper.SetDefault("server.port", "9862")
	viper.SetDefault("download.timeout", 15)

	// user section
	viper.SetDefault("user.name", getStringEnvOrDefault("GOUDA_USERNAME", "admin"))
	viper.SetDefault("user.password", getStringEnvOrDefault("GOUDA_PASS", "admin"))
	viper.SetDefault("user.uid", getIntEnvOrDefault("GOUDA_UID", 1000))
	viper.SetDefault("user.gid", getIntEnvOrDefault("GOUDA_UID", 1000))

	// directory setup
	defaultDir := getStringEnvOrDefault("GOUDA_COMPLETE_DIR", fmt.Sprintf("%s/%s", baseDir, "complete"))
	viper.SetDefault("folder.defaults", defaultDir)

	downloadDir := getStringEnvOrDefault("GOUDA_DOWNLOAD_DIR", fmt.Sprintf("%s/%s", baseDir, "downloads"))
	viper.SetDefault("folder.downloads", downloadDir)

	torrentDir := getStringEnvOrDefault("GOUDA_TORRENT_DIR", fmt.Sprintf("%s/%s", baseDir, "torrents"))
	viper.SetDefault("folder.torrents", torrentDir)

	err = makeDirectories([]string{torrentDir, defaultDir, downloadDir})
	if err != nil {
		return err
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
