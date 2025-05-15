package logger

import (
	"github.com/rs/zerolog"
	"github.com/rs/zerolog/log"
	"gopkg.in/natefinch/lumberjack.v2"
	"os"
)

var showCaller = true

func getConsoleWriter() zerolog.ConsoleWriter {
	return zerolog.ConsoleWriter{
		Out:        os.Stderr,
		TimeFormat: "2006-01-02 15:04:05",
	}
}

func getBaseLogger() zerolog.Logger {
	env, ok := os.LookupEnv("GOUDA_LOG_SHOW_CALLER_FILE")
	if !showCaller && (!ok || env == "false") {
		return log.With().Logger().Output(getConsoleWriter())
	}

	return log.With().Caller().Logger().Output(getConsoleWriter())
}

func FileConsoleLogger(logDir, logLevel string) {
	level, err := zerolog.ParseLevel(logLevel)
	if err != nil {
		log.Fatal().Err(err).Msg("unable to parse log level")
	}

	log.Logger = getBaseLogger().Output(
		zerolog.MultiLevelWriter(
			GetFileLogger(logDir),
			getConsoleWriter(),
		),
	).Level(level)
}

func ConsoleLogger() {
	log.Logger = getBaseLogger()
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
