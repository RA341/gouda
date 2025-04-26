package main

import (
	"github.com/RA341/gouda/cmd"
	"github.com/RA341/gouda/internal/info"
)

func main() {
	info.RunInServerMode()
	info.PrintInfo()
	cmd.Setup()
	cmd.StartServerWithAddr()
}
