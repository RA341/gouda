package service

import (
	"github.com/rs/zerolog"
	"github.com/rs/zerolog/log"
	"github.com/spf13/viper"
	"gopkg.in/natefinch/lumberjack.v2"
	"os"
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

func GetCachedDebugEnv() string {
	envVarOnce.Do(func() {
		cachedEnvVar = os.Getenv("DEBUG")
	})
	return cachedEnvVar
}

func FileConsoleLogger() zerolog.Logger {
	return baseLogger.Output(zerolog.MultiLevelWriter(getFileLogger(), consoleWriter))
}

func ConsoleLogger() zerolog.Logger {
	return baseLogger.Output(consoleWriter)
}

func getFileLogger() *lumberjack.Logger {
	return &lumberjack.Logger{
		Filename:   viper.GetString("log_dir"),
		MaxSize:    10, // MB
		MaxBackups: 5,  // number of backups
		MaxAge:     30, // days
		Compress:   true,
	}
}
