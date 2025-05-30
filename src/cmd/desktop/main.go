package main

import (
	"github.com/RA341/gouda/cmd"
	"github.com/RA341/gouda/internal/info"
	"github.com/RA341/gouda/internal/tray"
)

func main() {
	cmd.Setup(info.Desktop)
	go cmd.StartServerWithAddr() // server in background
	tray.Run()
}
