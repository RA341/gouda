package main

import (
	"github.com/RA341/gouda/cmd"
	"github.com/RA341/gouda/pkg"
	"github.com/rs/zerolog/log"
)

func main() {
	pkg.RunInServerMode()

	cmd.InitConfigAndLogger()
	log.Info().Msgf("running in server mode")

	cmd.StartServerWithAddr()
}
