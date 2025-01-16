//go:build !systray

package main

import "github.com/rs/zerolog/log"

// InitSystray empty init if systray tag is not specified
func InitSystray() {
	log.Warn().Msg("Empty systray init")
}
