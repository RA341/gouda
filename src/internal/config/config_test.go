package config

import (
	"github.com/spf13/viper"
	"github.com/stretchr/testify/assert"
	"os"
	"testing"
)

func TestLoad_FirstTimeSetup(t *testing.T) {
	err := os.RemoveAll("appdata")
	assert.NoError(t, err)
	Load()
	assert.Equal(t, SetupComplete.GetBool(), false)
	viper.Reset()
}

func TestLoad_SecondTimeSetup(t *testing.T) {
	Load()
	assert.Equal(t, SetupComplete.GetBool(), true)
	viper.Reset()
}
