//go:build systray

// do not put this in pkg package, if it will include the systray dependency regardless of it being disabled
package main

import (
	"github.com/RA341/gouda/pkg"
	"github.com/getlantern/systray"
)

func InitSystray() {
	systray.Run(pkg.OnReady, pkg.OnExit)
}
