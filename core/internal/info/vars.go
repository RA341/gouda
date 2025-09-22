package info

import (
	"runtime"
)

// BinaryType can be of type server or desktop.
type BinaryType string

const (
	// Desktop will enable systray, and expects a native flutter build in its working directory
	Desktop BinaryType = "desktop"
	Server  BinaryType = "server"
	Docker  BinaryType = "docker"
	Develop BinaryType = "develop"
)

const Unknown = "unknown"

var (
	Flavour    = string(Develop)
	Version    = "dev"
	CommitInfo = Unknown
	BuildDate  = Unknown
	Branch     = Unknown
	GoVersion  = runtime.Version()
)

func IsDev() bool {
	return Flavour == string(Develop)
}

func IsDocker() bool {
	return Flavour == string(Docker)
}

func IsDesktopMode() bool {
	return Flavour == string(Desktop)
}

func SetMode(mode BinaryType) {
	Flavour = string(mode)
	//log.Info().Str("mode", string(Flavour)).Msgf("setting mode...")
}

func IsKnown(value string) bool {
	return value != Unknown
}
