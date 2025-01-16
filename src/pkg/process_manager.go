package pkg

import (
	"github.com/rs/zerolog/log"
	"github.com/shirou/gopsutil/v3/process"
	"runtime"
	"slices"
	"strings"
)

func isProcessRunning(processName string) bool {
	ps, err := process.Processes()
	if err != nil {
		log.Warn().Err(err).Msgf("Failed to get process: %s", ps)
		return false
	}

	processName = strings.ToLower(processName)
	for _, p := range ps {
		n, err := p.Name()
		if err != nil {
			continue
		}
		if strings.ToLower(n) == processName {
			return true
		}
	}
	return false
}

func killProcess(processNames []string) {
	if runtime.GOOS == "windows" {
		for ind, processName := range processNames {
			processNames[ind] = strings.ToLower(processName)
		}
	}

	ps, err := process.Processes()
	if err != nil {
		log.Error().Err(err).Msg("Failed to get processes")
		return
	}

	killProcessCount := 0

	for _, p := range ps {
		n, err := p.Name()
		if err != nil {
			continue
		}

		if killProcessCount == len(processNames) {
			log.Info().Msgf("All  process Killed: %d", killProcessCount)
			return
		}

		if slices.Index(processNames, n) != -1 {
			err = p.Kill()
			if err != nil {
				log.Error().Err(err).Msgf("Failed to kill process %s", processNames)
			} else {
				log.Info().Msgf("Successfully killed process %s", processNames)
			}

			killProcessCount += 1
		}
	}
}
