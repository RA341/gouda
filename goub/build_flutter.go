package main

import (
	"github.com/fatih/color"
	"os"
	"path/filepath"
)

const flutterRoot = "brie"

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

var (
	printBlue = color.New(color.FgBlue).PrintlnFunc()
)

// assumes working dir as gouda root and flutter project is at /brie
func runFlutterBuildRoot(variant string) (string, error) {
	return buildFlutter(variant, flutterRoot)
}

func buildFlutter(variant string, workingDir string) (string, error) {
	printBlue("Starting flutter build", variant, "working dir", workingDir)
	cmd := buildFlutterCmd(variant)
	if err := executeCommand(cmd, workingDir, os.Stdout, os.Stderr); err != nil {
		return "", err
	}

	buildName := flutterVariants[variant]
	result, err := filepath.Abs(buildName)
	if err != nil {
		return "", err
	}

	printBlue("Flutter build complete:", result)
	return result, nil
}

func runFlutterClean() error {
	cmds := []string{"flutter", "clean", "build"}
	return executeCommand(cmds, flutterRoot)
}

func buildFlutterCmd(flutterVariant string) []string {
	return []string{"flutter", "build", flutterVariant, "-v"}
}
