package main

import (
	"github.com/RA341/gouda/internal/app"
	"github.com/rs/zerolog/log"
)

func main() {
	fs, err := app.WithUIFromFile("web")
	if err != nil {
		log.Fatal().Err(err).Msg("Unable to find web ui")
	}

	app.StartServer(fs)
}
