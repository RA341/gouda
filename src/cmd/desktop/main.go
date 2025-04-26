package main

import (
	"github.com/RA341/gouda/cmd"
	"github.com/RA341/gouda/internal/info"
	"github.com/RA341/gouda/internal/tray"
	"github.com/getlantern/systray"
)

func main() {
	info.RunInDesktopMode()
	info.PrintInfo()
	cmd.Setup()
	go cmd.StartServerWithAddr() // server in background
	InitSystray()
}

// InitSystray systray will run indefinitely
func InitSystray() {
	systray.Run(tray.OnReady, tray.OnExit)
}
