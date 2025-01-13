package main

// BinaryType can be of type server or desktop.
// Desktop will enable systray, and native flutter build into its binary
var BinaryType = "server"

var Version = "dev"

func isDesktopMode() bool {
	if BinaryType == "desktop" {
		return true
	}
	return false
}
