package main

import (
	"log"
	"os"

	"github.com/RA341/gouda/cmd"
)

// for development enables extra stuff via env,
func main() {
	Must(os.Setenv("GOUDA_LOG_SHOW_CALLER_FILE", "true"))
	Must(os.Setenv("GOUDA_LOG_LEVEL", "debug"))
	Must(os.Setenv("GOUDA_AUTH_ENABLE", "false"))

	cmd.StartServer(nil)
}

func Must(err error) {
	if err != nil {
		log.Fatal(err)
	}
}
