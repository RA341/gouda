package main

import (
	"github.com/rs/zerolog/log"
	"os"
	"os/exec"
	"path/filepath"
	"runtime"
)

// todo add logging rollover and limits via lumberjack

func main() {
	// Get the resources directory for macOS bundle
	exePath, _ := os.Executable()
	appDir := filepath.Dir(exePath)

	log.Info().Str("exePath", exePath).Str("appDir", appDir).Msg("paths")

	apiExecutable := "gouda"
	frontendExecutable := "brie"

	if runtime.GOOS == "windows" {
		apiExecutable += ".exe"
		frontendExecutable += ".exe"
	}

	fullApiPath := filepath.Join(appDir, "api", apiExecutable)
	fullFrontendPath := filepath.Join(appDir, "frontend", frontendExecutable)
	log.Info().Str("fullApiPath", fullApiPath).Str("full frontend path", fullFrontendPath).Msg("fullApiPath")

	///////////////////////////////////////////////////////////////////////////////////////
	// Start the API server with output redirected to the log file
	// Create/open a log file
	apiLogFile, err := os.OpenFile("api_server.log", os.O_CREATE|os.O_WRONLY|os.O_APPEND, 0644)
	if err != nil {
		log.Fatal().Err(err).Msg("Failed to open log file")
	}
	defer func(logFile *os.File) {
		err := logFile.Close()
		if err != nil {
			log.Fatal().Err(err).Msg("Failed to close log file")
		}
	}(apiLogFile)

	// Start the API server with output redirected to the log file
	apiServer := exec.Command(fullApiPath)
	apiServer.Stdout = apiLogFile
	apiServer.Stderr = apiLogFile
	applyOSSpecificAttr(apiServer)
	err = apiServer.Start()
	if err != nil {
		log.Fatal().Err(err).Msg("Failed to start api server")
	}

	///////////////////////////////////////////////////////////////////////////////////////
	flutterLogFile, err := os.OpenFile("flutter.log", os.O_CREATE|os.O_WRONLY|os.O_APPEND, 0644)
	if err != nil {
		log.Fatal().Err(err).Msg("Failed to open log file")
	}
	defer func(logFile *os.File) {
		err := logFile.Close()
		if err != nil {
			log.Fatal().Err(err).Msg("Failed to close log file")
		}
	}(flutterLogFile)

	// Flutter frontend
	flutterApp := exec.Command(filepath.Join(fullFrontendPath))
	flutterApp.Stdout = flutterLogFile
	flutterApp.Stderr = flutterLogFile

	err = flutterApp.Run()
	if err != nil {
		log.Error().Err(err).Msg("Unable to start frontend application")
	}
	///////////////////////////////////////////////////////////////////////////////////////

	// Cleanup
	if apiServer.Process != nil {
		err := apiServer.Process.Kill()
		if err != nil {
			log.Fatal().Err(err).Msg("Unable to kill API server")
		}
	}
}
