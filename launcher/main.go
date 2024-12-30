package main

import (
	"github.com/rs/zerolog/log"
	"io"
	"os"
	"os/exec"
	"path/filepath"
	"runtime"
)

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

	// Start the API server
	apiServer := exec.Command(fullApiPath)
	if runtime.GOOS == "windows" {
		applyOSSpecificAttr(apiServer)
	}

	err := apiServer.Start()
	if err != nil {
		log.Error().Err(err).Msg("Unable to start API server")
	}

	// If you want to also write raw output to separate files
	stdoutFile, err := os.Create(filepath.Join(".", "api-stdout.log"))
	if err != nil {
		log.Error().Msgf("Error creating stdout file: %v", err)
		os.Exit(1)
	}
	defer func(stdoutFile *os.File) {
		err := stdoutFile.Close()
		if err != nil {
			log.Error().Err(err).Msg("Error closing stdout file")
		}
	}(stdoutFile)

	stderrFile, err := os.Create(filepath.Join(".", "api-stderr.log"))
	if err != nil {
		log.Error().Msgf("Error creating stderr file: %v", err)
		os.Exit(1)
	}
	defer func(stderrFile *os.File) {
		err := stderrFile.Close()
		if err != nil {
			log.Error().Err(err).Msg("Error closing stderr file")
		}
	}(stderrFile)

	apiServer.Stdout = io.MultiWriter(stdoutFile)
	apiServer.Stderr = io.MultiWriter(stderrFile)
	//
	//apiServer.Stdout = os.Stdout
	//apiServer.Stderr = os.Stderr

	// Start Flutter frontend
	flutterApp := exec.Command(filepath.Join(fullFrontendPath))
	flutterApp.Stdout = os.Stdout
	flutterApp.Stderr = os.Stderr

	err = flutterApp.Run()
	if err != nil {
		log.Error().Err(err).Msg("Unable to start frontend application")
	}

	// Cleanup
	if apiServer.Process != nil {
		err := apiServer.Process.Kill()
		if err != nil {
			log.Fatal().Err(err).Msg("Unable to kill API server")
		}
	}
}
