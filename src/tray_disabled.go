//go:build !systray

// do not put this in pkg package, if it will include the systray dependency regardless of it being disabled
package main

import "github.com/rs/zerolog/log"

// InitSystray empty init if systray tag is not specified
func InitSystray() {
	log.Warn().Msg("Empty systray init")
}
