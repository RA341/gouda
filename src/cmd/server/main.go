package main

import (
	"github.com/RA341/gouda/cmd"
	"github.com/RA341/gouda/internal/info"
	"github.com/rs/zerolog/log"
)

func main() {
	info.RunInServerMode()
	info.PrintInfo()

	cmd.InitConfigAndLogger()
	log.Info().Msgf("running in server mode")

	cmd.StartServerWithAddr()
}
