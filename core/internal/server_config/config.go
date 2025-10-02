package server_config

import (
	"flag"
	"fmt"
	"os"

	"github.com/RA341/gouda/pkg/argos"
	fu "github.com/RA341/gouda/pkg/file_utils"
	"github.com/goccy/go-yaml"
	"github.com/joho/godotenv"
	"github.com/rs/zerolog/log"
)

const (
	GoudaEnvPrefix  = "GOUDA"
	GoudaConfigDir  = "config"
	GoudaConfigFile = GoudaConfigDir + "/gouda.yml"
)

func LoadConf() (*GoudaConfig, error) {
	err := os.MkdirAll(GoudaConfigDir, os.ModePerm)
	if err != nil {
		return nil, fmt.Errorf("unale to create config dir: %w", err)
	}

	if err = godotenv.Load(); err != nil {
		log.Debug().Err(err).Msgf("Error loading .env file")
	}

	var conf GoudaConfig
	err = conf.LoadFromYaml()
	if err != nil {
		log.Warn().Err(err).Msgf("unable to load previous config file, creating new config file")
	}

	err = argos.Scan(&conf, GoudaEnvPrefix)
	if err != nil {
		return nil, fmt.Errorf("unable to setup config: %w", err)
	}
	flag.Parse()

	err = fu.ResolvePaths([]*string{
		&conf.Dir.TorrentDir,
		&conf.Dir.CompleteDir,
		&conf.Dir.DownloadDir,
	})
	if err != nil {
		return nil, fmt.Errorf("unable to resolve path: %w", err)
	}

	err = conf.DumpToYaml()
	if err != nil {
		log.Warn().Err(err).Msgf("Error loading gouda.json file")
	}

	argos.PrettyPrint(&conf, GoudaEnvPrefix)
	return &conf, nil
}

// DumpToYaml writes the GoudaConfig to a yml file
func (cfg *GoudaConfig) DumpToYaml() error {
	filename := GoudaConfigFile

	file, err := os.Create(filename)
	if err != nil {
		return fmt.Errorf("failed to create config file: %w", err)
	}
	defer fu.Close(file)

	yamlData, err := GenerateYAMLWithComments(cfg)
	if err != nil {
		return err
	}

	err = os.WriteFile(filename, []byte(yamlData), 0644)
	if err != nil {
		return fmt.Errorf("failed write config to file: %s\nerr%w", filename, err)
	}

	return nil
}

// LoadFromYaml reads the GoudaConfig from a yml file
func (cfg *GoudaConfig) LoadFromYaml() error {
	filename := GoudaConfigFile

	contents, err := os.ReadFile(filename)
	if err != nil {
		return fmt.Errorf("failed to open config file: %w", err)
	}

	err = yaml.Unmarshal(contents, cfg)
	if err != nil {
		return fmt.Errorf("failed load config from file: %s\nerr%w", filename, err)
	}

	return nil
}
