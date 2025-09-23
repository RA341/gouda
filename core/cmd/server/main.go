package main

import (
	"embed"

	"github.com/RA341/gouda/internal/app"
)

//go:embed web
var frontendDir embed.FS

func main() {
	app.StartServer(
		app.WithUIFromEmbed(frontendDir),
	)
}
