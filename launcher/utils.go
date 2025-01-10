package main

import (
	"github.com/rs/zerolog/log"
	"gopkg.in/natefinch/lumberjack.v2"
	"os"
	"os/exec"
	"path/filepath"
	"runtime"
)

func getFileLogger(logPath string) *lumberjack.Logger {
	return &lumberjack.Logger{
		Filename:   logPath,
		MaxSize:    10, // MB
		MaxBackups: 5,  // number of backups
		MaxAge:     30, // days
		Compress:   true,
	}
}

func readIconToBytes(iconPath string) []byte {
	// Read the file
	bytes, err := os.ReadFile(iconPath)
	if err != nil {
		log.Error().Err(err).Str("iconPath", iconPath).Msg("Unable to read icon")
	}

	log.Info().Str("iconPath", iconPath).Msg("Read icon")

	return bytes
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
