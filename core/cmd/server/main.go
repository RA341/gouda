package main

import (
	"embed"

	"github.com/RA341/gouda/cmd"
)

//go:embed web
var frontendDir embed.FS

func main() {
	cmd.StartServer(
		cmd.WithUIFromEmbed(frontendDir),
	)
}
