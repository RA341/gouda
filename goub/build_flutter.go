package main

import (
	"github.com/fatih/color"
	"path/filepath"
)

const flutterRoot = "brie"

var (
	printBlue = color.New(color.FgBlue).PrintlnFunc()
)

var (
	buildRoot = flutterRoot + "/build"
	// all paths relative to a flutter project dir
	flutterVariants = map[string]string{
		"web":     buildRoot + "/web",
		"windows": buildRoot + "/windows/x64/runner/Release",
		"linux":   buildRoot + "/linux", // todo
		"macos":   buildRoot + "/macos", // todo
	}
)

// assumes working dir as gouda root
func runFlutterBuild(variant string) (string, error) {
	printBlue("Starting flutter build", variant)
	cmd := buildFlutterCmd(variant)
	if err := executeCommand(cmd, flutterRoot); err != nil {
		return "", err
	}

	output := flutterVariants[variant]
	result, err := filepath.Abs(output)
	if err != nil {
		return "", err
	}

	printBlue("Flutter build complete", "destination", result)

	return result, nil
}

func runFlutterClean() error {
	cmds := []string{"flutter", "clean", "build"}
	return executeCommand(cmds, flutterRoot)
}

func buildFlutterCmd(flutterVariant string) []string {
	return []string{"flutter", "build", flutterVariant}
}
