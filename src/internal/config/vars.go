package config

import (
	"os"
	"sync"
)

var (
	cachedEnvVar string
	envVarOnce   sync.Once
)

const DefaultFilePerm = 0o775

func getCachedDebugEnv() string {
	envVarOnce.Do(func() {
		cachedEnvVar = os.Getenv("DEBUG")
	})
	return cachedEnvVar
}

func IsDebugMode() bool {
	return getCachedDebugEnv() == "true"
}

func IsDocker() bool {
	return os.Getenv("IS_DOCKER") == "true"
}
