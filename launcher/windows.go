//go:build windows
// +build windows

package main

import (
	"os/exec"
	"syscall"
)

// windows specific
// https://stackoverflow.com/questions/62853835/how-to-use-syscall-sysprocattr-struct-fields-for-windows-when-os-is-set-for-linu

// CreationFlags: syscall.CREATE_NEW_PROCESS_GROUP, this is not allows on other os's
func applyOSSpecificAttr(apiServer *exec.Cmd) {
	apiServer.SysProcAttr = &syscall.SysProcAttr{
		CreationFlags: syscall.CREATE_NEW_PROCESS_GROUP,
	}
}
