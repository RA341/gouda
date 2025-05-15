package logger

import (
	"github.com/rs/zerolog"
	"github.com/rs/zerolog/log"
	"gopkg.in/natefinch/lumberjack.v2"
	"os"
)

func getConsoleWriter() zerolog.ConsoleWriter {
	return zerolog.ConsoleWriter{
		Out:        os.Stderr,
		TimeFormat: "2006-01-02 15:04:05",
	}
}

func getBaseLogger() zerolog.Logger {
	env, ok := os.LookupEnv("GOUDA_LOG_SHOW_CALLER_FILE")
	if !ok || env == "false" {
		return log.With().Logger().Output(getConsoleWriter())
	}

	return log.With().Caller().Logger().Output(getConsoleWriter())
}

func FileConsoleLogger(logDir, logLevel string) zerolog.Logger {
	level, err := zerolog.ParseLevel(logLevel)
	if err != nil {
		log.Fatal().Err(err).Msg("unable to parse log level")
	}
	log.Info().Str("level", logLevel).Msg("log level is now set, this can be changed by using the GOUDA_LOG_LEVEL env")

	return getBaseLogger().Output(
		zerolog.MultiLevelWriter(
			GetFileLogger(logDir),
			getConsoleWriter(),
		),
	).Level(level)
}

func ConsoleLogger() zerolog.Logger {
	return getBaseLogger()
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
