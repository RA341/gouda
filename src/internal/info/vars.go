package info

import (
	"github.com/rs/zerolog/log"
	"runtime"
)

var (
	Flavour    = Server
	Version    = "dev"
	CommitInfo = "unknown"
	BuildDate  = "unknown"
	Branch     = "unknown"
	SourceHash = "unknown"
	GoVersion  = runtime.Version()
)

func RunInServerMode() {
	Flavour = Server
	log.Info().Msgf("running in server mode")
}

func RunInDesktopMode() {
	Flavour = Desktop
	log.Info().Msgf("running in desktop mode")
}

func IsDesktopMode() bool {
	return Flavour == Desktop
}
