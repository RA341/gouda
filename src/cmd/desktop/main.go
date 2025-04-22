package main

import (
	"github.com/RA341/gouda/cmd"
	"github.com/RA341/gouda/pkg"
	"github.com/rs/zerolog/log"
)

func main() {
	pkg.RunInDesktopMode()

	cmd.InitConfigAndLogger()
	log.Info().Msgf("running in desktop mode")

	// server as routine
	go cmd.StartServerWithAddr()

	// systray will run indefinitely
	InitSystray()
}
