//go:build systray

package main

import (
	"github.com/RA341/gouda/pkg"
	"github.com/getlantern/systray"
)

func InitSystray() {
	systray.Run(pkg.OnReady, pkg.OnReady)
}
