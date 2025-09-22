package main

import (
	"github.com/RA341/gouda/cmd"
	"github.com/rs/zerolog/log"
)

func main() {
	fs, err := cmd.WithUIFromFile("web")
	if err != nil {
		log.Fatal().Err(err).Msg("Unable to find web ui")
	}

	cmd.StartServer(fs)
}
