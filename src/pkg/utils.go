package pkg

import (
	"github.com/rs/zerolog"
	"github.com/rs/zerolog/log"
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

// InitConsoleLogger configures zerolog logger with some custom settings
func InitConsoleLogger() {
	log.Logger = consoleLogger()
}

func InitFileLogger() {
	log.Logger = fileConsoleLogger()
}

// GetConfigDir logfile is set to the main gouda config path,
// we get the base dir from that for desktop mode
func GetConfigDir() string {
	return filepath.Dir(LogDir.GetStr())
}

func fileConsoleLogger() zerolog.Logger {
	logFile := LogDir.GetStr()
	return baseLogger.Output(zerolog.MultiLevelWriter(GetFileLogger(logFile), consoleWriter))
}

func consoleLogger() zerolog.Logger {
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
