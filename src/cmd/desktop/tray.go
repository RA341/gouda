// do not put this in pkg package, if it will include the systray dependency regardless of it being disabled
package main

import (
	"github.com/RA341/gouda/tray"
	"github.com/getlantern/systray"
)

func InitSystray() {
	systray.Run(tray.OnReady, tray.OnExit)
}
