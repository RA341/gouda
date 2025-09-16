package main

import (
	"embed"
	"github.com/RA341/gouda/cmd"
	"github.com/RA341/gouda/internal/info"
	"github.com/RA341/gouda/internal/tray"
)

//go:embed web
var frontendDir embed.FS

func main() {
	cmd.Setup(info.Desktop)
	// server in background
	go cmd.StartServer(cmd.WithUIFromEmbed(frontendDir))
	tray.Run()
}
