package dockerpackage

import (
	"github.com/RA341/gouda/cmd"
	"github.com/RA341/gouda/internal/info"
)

func main() {
	cmd.Setup(info.Server)
	cmd.StartServer(nil)
}
