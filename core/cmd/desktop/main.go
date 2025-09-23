package main

import (
	"embed"

	"github.com/RA341/gouda/internal/app"
	"github.com/RA341/gouda/internal/tray"
)

//go:embed web
var frontendDir embed.FS

func main() {
	// server in background
	go app.StartServer(app.WithUIFromEmbed(frontendDir))
	tray.Run()
}
