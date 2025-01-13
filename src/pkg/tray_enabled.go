//go:build systray
// +build systray

package pkg

import (
	"github.com/getlantern/systray"
)

func InitSystray() {
	systray.Run(OnReady, OnExit)
}
