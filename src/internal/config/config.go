package config

import (
	"flag"
	"fmt"
	"github.com/RA341/gouda/pkg/argos"
	fu "github.com/RA341/gouda/pkg/file_utils"
	"github.com/joho/godotenv"
	"github.com/rs/zerolog/log"
)

const (
	GoudaEnv  = "GOUDA"
	GoudaJSON = "gouda.json"
)

func LoadConf() (*GoudaConfig, error) {
	if err := godotenv.Load(); err != nil {
		log.Debug().Err(err).Msgf("Error loading .env file")
	}

	var conf GoudaConfig
	err := conf.LoadFromJSON()
	if err != nil {
		log.Warn().Err(err).Msgf("Error loading gouda.json file previously saved config will be not loaded")
	}

	err = argos.Scan(&conf, GoudaEnv)
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

	err = conf.DumpToJSON()
	if err != nil {
		log.Warn().Err(err).Msgf("Error loading gouda.json file")
	}

	argos.PrettyPrint(conf, GoudaEnv)
	return &conf, nil
}
