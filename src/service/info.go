package service

// BinaryType can be of type server or desktop.
// Desktop will enable systray, and native flutter build into its binary
var BinaryType = "server"

var Version = "dev"

func IsDesktopMode() bool {
	if BinaryType == "desktop" {
		return true
	}
	return false
}
