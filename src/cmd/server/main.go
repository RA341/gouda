package main

import (
	"embed"
	"github.com/RA341/gouda/cmd"
	"github.com/RA341/gouda/internal/info"
)

//go:embed web
var frontendDir embed.FS

func main() {
	cmd.Setup(info.Server)
	cmd.StartServer(cmd.WithUIFromEmbed(frontendDir))
}
