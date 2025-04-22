package desktop

import (
	"github.com/rs/zerolog/log"
	"os"
	"os/exec"
	"path/filepath"
	"runtime"
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

func openLogsDirectory() {
	exePath, _ := os.Executable()
	appDir := filepath.Dir(exePath)

	var cmd *exec.Cmd
	switch runtime.GOOS {
	case "windows":
		cmd = exec.Command("explorer", appDir)
	case "darwin":
		cmd = exec.Command("open", appDir)
	default: // Linux and others
		cmd = exec.Command("xdg-open", appDir)
	}

	err := cmd.Start()
	if err != nil {
		log.Error().Err(err).Msg("Failed to open logs directory")
	}
}
