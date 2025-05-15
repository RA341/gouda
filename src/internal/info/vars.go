package info

import (
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

func SetMode(mode BinaryType) {
	Flavour = mode
	//log.Info().Str("mode", string(Flavour)).Msgf("setting mode...")
}

func IsDesktopMode() bool {
	return Flavour == Desktop
}
