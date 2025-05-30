package main

import (
	"github.com/RA341/gouda/cmd"
	"github.com/RA341/gouda/internal/info"
	"log"
	"os"
)

// for development enables extra stuff via env,
func main() {
	Must(os.Setenv("GOUDA_LOG_SHOW_CALLER_FILE", "true"))
	Must(os.Setenv("GOUDA_LOG_LEVEL", "debug"))

	cmd.Setup(info.Server)
	cmd.StartServerWithAddr()
}

func Must(err error) {
	if err != nil {
		log.Fatal(err)
	}
}
