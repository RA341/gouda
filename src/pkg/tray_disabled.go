//go:build !systray

package pkg

import "github.com/rs/zerolog/log"

// InitSystray empty init if systray tag is not specified
func InitSystray() {
	log.Warn().Msg("Empty systray init")
}
