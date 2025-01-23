package utils

import (
	"github.com/rs/zerolog"
	"github.com/rs/zerolog/log"
	"github.com/spf13/viper"
	"gopkg.in/natefinch/lumberjack.v2"
	"os"
	"path/filepath"
	"sync"
)

// cache os.getenv('debug') value for perf
var (
	cachedEnvVar  string
	envVarOnce    sync.Once
	consoleWriter = zerolog.ConsoleWriter{
		Out:        os.Stderr,
		TimeFormat: "2006-01-02 15:04:05",
	}
	baseLogger = log.With().Caller().Logger()
)

const DefaultFilePerm = 0o775

func IsDebugMode() bool {
	return getCachedDebugEnv() == "true"
}

func IsDocker() bool {
	return os.Getenv("IS_DOCKER") == "true"
}

func getCachedDebugEnv() string {
	envVarOnce.Do(func() {
		cachedEnvVar = os.Getenv("DEBUG")
	})
	return cachedEnvVar
}

// GetConfigDir logfile is set to the main gouda config path,
// we get the base dir from that for desktop mode
func GetConfigDir() string {
	return filepath.Dir(viper.GetString("log_dir"))
}

func FileConsoleLogger() zerolog.Logger {
	logFile := viper.GetString("log_dir")
	return baseLogger.Output(zerolog.MultiLevelWriter(GetFileLogger(logFile), consoleWriter))
}

func ConsoleLogger() zerolog.Logger {
	return baseLogger.Output(consoleWriter)
}

func GetFileLogger(logFile string) *lumberjack.Logger {
	return &lumberjack.Logger{
		Filename:   logFile,
		MaxSize:    10, // MB
		MaxBackups: 5,  // number of backups
		MaxAge:     30, // days
		Compress:   true,
	}
}
