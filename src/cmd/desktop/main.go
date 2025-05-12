package main

import (
	"github.com/RA341/gouda/cmd"
	"github.com/RA341/gouda/internal/info"
	"github.com/RA341/gouda/internal/tray"
	"github.com/getlantern/systray"
)

func main() {
	cmd.Setup(info.Desktop)
	go cmd.StartServerWithAddr() // server in background
	// systray will block
	systray.Run(tray.OnReady, tray.OnExit)
}
