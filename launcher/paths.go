package main

import (
	"github.com/rs/zerolog/log"
	"os"
	"path/filepath"
	"sync"
)

var (
	once    sync.Once
	execDir string
)

func getWorkingDir() string {
	once.Do(func() {
		exePath, err := os.Executable()
		if err != nil {
			log.Fatal().Err(err).Msg("Failed to get executable directory")
		}

		log.Info().Msgf("executable path: %s", exePath)

		execDir = filepath.Dir(exePath)
	})

	return execDir
}
