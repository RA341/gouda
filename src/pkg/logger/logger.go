package logger

import (
	"github.com/rs/zerolog"
	"github.com/rs/zerolog/log"
	"gopkg.in/natefinch/lumberjack.v2"
	"os"
)

var (
	consoleWriter = zerolog.ConsoleWriter{
		Out:        os.Stderr,
		TimeFormat: "2006-01-02 15:04:05",
	}
	baseLogger = log.With().Caller().Logger()
)

// InitConsoleLogger configures zerolog logger with some custom settings
func InitConsoleLogger() {
	log.Logger = consoleLogger()
}

func InitFileLogger(logDir string) {
	log.Logger = fileConsoleLogger(logDir)
}

func fileConsoleLogger(logDir string) zerolog.Logger {
	return baseLogger.Output(zerolog.MultiLevelWriter(GetFileLogger(logDir), consoleWriter))
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
