package service

import (
	"os"
	"sync"
)

// cache os.getenv('debug') value for perf
var (
	cachedEnvVar string
	envVarOnce   sync.Once
)

const DefaultFilePerm = 0o775

func GetCachedDebugEnv() string {
	envVarOnce.Do(func() {
		cachedEnvVar = os.Getenv("DEBUG")
	})
	return cachedEnvVar
}
