package pkg

// BinaryType can be of type server or desktop.
type BinaryType string

const (
	// Desktop will enable systray, and expects a native flutter build into its binary
	Desktop BinaryType = "desktop"
	Server  BinaryType = "server"
)

var Flavour = Server

var Version = "dev"

func RunInServerMode() {
	Flavour = Server
}

func RunInDesktopMode() {
	Flavour = Desktop
}

func IsDesktopMode() bool {
	if Flavour == Desktop {
		return true
	}
	return false
}
