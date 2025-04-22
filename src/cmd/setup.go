package cmd

import (
	"github.com/RA341/gouda/pkg"
)

func InitConfigAndLogger() {
	pkg.InitConsoleLogger()
	pkg.InitConfig()
}
