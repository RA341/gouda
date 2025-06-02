package main

import (
	"context"
	"errors"
	"fmt"
	"github.com/fatih/color"
	"io"
	"io/fs"
	"log"
	"os"
	"os/exec"
	"path/filepath"
	"strings"
)

var (
	printMagenta = color.New(color.FgMagenta).PrintlnFunc()
)

var (
	buildMap = map[string]func(destinationDir string, flutterWebReady context.Context, opt ...BuildOpt) error{
		"all":     buildAll,
		"desktop": buildDesktop,
		"server":  buildServer,
	}
)

func build(variant string, destinationDir string, opt ...BuildOpt) error {
	destinationDir, err := filepath.Abs(destinationDir)
	if err != nil {
		return err
	}

	if err = os.MkdirAll(destinationDir, os.ModePerm); err != nil {
		return err
	}

	err = verifyDir()
	if err != nil {
		printGreen("Directory verification failed: %s\n", err.Error())
		printGreen("Listing directories:\n")
		err = ls()
		return err
	}

	//err = resolveRootDir()
	//if err != nil {
	//	must(err)
	//}

	info, err := getGitInfo()
	if err != nil {
		return err
	}
	opt = append(opt, withGitMetadata(info), withSourceHash(goRoot), withGoudaRoot())

	buildFn, ok := buildMap[variant]
	if !ok {
		return fmt.Errorf("Unknown variant " + variant)
	}

	flutterWebCtx, cancelCause := context.WithCancelCause(context.Background())
	go func() {
		// all go binaries need flutter web
		cancelCause(buildAndCopyFlutterWeb())
	}()

	if err = buildFn(destinationDir, flutterWebCtx, opt...); err != nil {
		return err
	}

	return nil
}

func ls() error {
	dirPath := "."
	entries, err := os.ReadDir(dirPath)
	if err != nil {
		log.Fatalf("Failed to read directory %s: %v", dirPath, err)
	}

	fmt.Printf("Contents of directory '%s':\n", dirPath)
	for _, entry := range entries {
		fmt.Print(entry.Name())

		// You can also get more information about the entry
		if entry.IsDir() {
			fmt.Print("/") // Indicate it's a directory
		} else if entry.Type()&fs.ModeSymlink != 0 {
			// Resolve symlink to see where it points, similar to `ls -l`
			symlinkPath := filepath.Join(dirPath, entry.Name())
			target, err := os.Readlink(symlinkPath)
			if err != nil {
				fmt.Printf(" -> [broken symlink] (%v)", err)
			} else {
				fmt.Printf(" -> %s", target)
			}
		}
		fmt.Println()
	}
	return err
}

func verifyDir() error {
	_, err := os.Stat("brie/pubspec.yaml")
	if errors.Is(err, fs.ErrNotExist) {
		return fmt.Errorf("brie dir with pubspec not found")
	}
	if err != nil {
		return err
	}

	_, err = os.Stat("src/go.mod")
	if errors.Is(err, fs.ErrNotExist) {
		return fmt.Errorf("go dir with go.mod not found")
	}
	if err != nil {
		return err
	}

	return nil
}

func buildAll(destinationDir string, flutterWebReady context.Context, opt ...BuildOpt) error {
	errCh := make(chan error, 2)

	go func() {
		if err := waitForWebBuild(flutterWebReady); err != nil {
			errCh <- err
			return
		}

		opt = append(opt, withVariant("server"))
		err := buildAndCopyGoBinary(destinationDir, opt...)
		if err != nil {
			errCh <- err
			return
		}
		errCh <- nil
	}()

	go func() {
		err := buildDesktop(destinationDir, flutterWebReady, opt...)
		if err != nil {
			errCh <- err
			return
		}
		errCh <- nil
	}()

	if err := waitForChan(errCh, 2); err != nil {
		return err
	}

	printMagenta("All builds complete")
	return nil
}

func buildServer(destinationDir string, flutterWebReady context.Context, opt ...BuildOpt) error {
	if err := waitForWebBuild(flutterWebReady); err != nil {
		return err
	}

	opt = append(opt, withVariant("server"))
	if err := buildAndCopyGoBinary(destinationDir, opt...); err != nil {
		return err
	}
	printMagenta("Server build complete")
	return nil
}

func buildDesktop(destinationDir string, flutterWebReady context.Context, opt ...BuildOpt) error {
	tmpBuildFolder, err := os.MkdirTemp("", "gouda_build_tmp_*")
	if err != nil {
		return err
	}
	defer func() {
		warn(os.RemoveAll(tmpBuildFolder))
	}()

	// the binary will expect the desktop files in 'frontend' dir in its working dir
	tmpBuildDesktopDir := filepath.Join(tmpBuildFolder, "frontend")
	if err := os.MkdirAll(tmpBuildDesktopDir, 0777); err != nil {
		return err
	}

	errCh := make(chan error, 2)
	go func() {
		if err = waitForWebBuild(flutterWebReady); err != nil {
			errCh <- err
			return
		}

		// build binary and place it in tmp folder
		opt = append(opt, withVariant("desktop"))
		if err = buildAndCopyGoBinary(tmpBuildFolder, opt...); err != nil {
			errCh <- err
		}
		errCh <- nil
	}()

	go func() {
		if err = buildAndCopyFlutterDesktop(tmpBuildDesktopDir); err != nil {
			errCh <- err
			return
		}
		errCh <- nil
	}()

	if err = waitForChan(errCh, 2); err != nil {
		return err
	}

	zipName := fmt.Sprintf("gouda-desktop-%s.zip", getOSName())
	zipName = filepath.Join(destinationDir, zipName)
	if err = zipDir(tmpBuildFolder, zipName); err != nil {
		return err
	}

	printMagenta("Desktop build complete")
	return nil
}

func waitForWebBuild(flutterWebReady context.Context) error {
	//printCyan("Waiting for web build to complete...")
	<-flutterWebReady.Done()
	err := context.Cause(flutterWebReady)
	if errors.Is(err, context.Canceled) {
		return nil
	}
	return err
}

func buildAndCopyGoBinary(destinationDir string, opt ...BuildOpt) error {
	output, err := runGoBuild(opt...)
	if err != nil {
		return err
	}
	defer func() {
		warn(os.Remove(output))
	}()

	destPath := filepath.Join(destinationDir, filepath.Base(output))
	destFile, err := os.OpenFile(destPath, os.O_CREATE|os.O_RDWR, 0777)
	if err != nil {
		return err
	}
	defer func() { // use an anonymous function so that destFile.Close is not called immediately
		warn(destFile.Close())
	}()

	srcFile, err := os.Open(output)
	if err != nil {
		return err
	}
	defer func() {
		warn(srcFile.Close())
	}()

	_, err = io.Copy(destFile, srcFile)
	if err != nil {
		return err
	}
	return nil
}

func buildAndCopyFlutterWeb() error {
	buildPath, err := runFlutterBuildRoot("web")
	if err != nil {
		return fmt.Errorf("flutter web build failed: %v", err)
	}
	// remove prev files if any
	if err = os.RemoveAll(GoBinWebPath); err != nil {
		return fmt.Errorf("failed to remove %s: %v", GoBinWebPath, err)
	}
	err = CopyFolder(buildPath, GoBinWebPath)
	if err != nil {
		return fmt.Errorf("failed to copy %s: %v", buildPath, err)
	}
	return err
}

func buildAndCopyFlutterDesktop(outputDir string) (err error) {
	name := getOSName()
	flutterBuildDir, err := runFlutterBuildRoot(name)
	if err != nil {
		return err
	}

	if err = os.RemoveAll(outputDir); err != nil {
		return err
	}

	if err = CopyFolder(flutterBuildDir, outputDir); err != nil {
		return err
	}
	return err
}

func waitForChan(errCh chan error, workerCount int) error {
	count := 0
	for err := range errCh {
		if err != nil {
			return err
		}
		count++
		if count == workerCount {
			break
		}
	}
	return nil
}

const goudaModuleName = "github.com/RA341/gouda"

func GetCurrentModulePath() (string, error) {
	cmdList := []string{"go", "list", "-m", "-f", "{{.Path}}"}
	cmd := exec.Command(cmdList[0], cmdList[1:]...)
	output, err := cmd.Output()
	if err != nil {
		// Handle cases where `go list` fails (e.g., not in a module, Go tool not found)
		// or if there's an ExitError (e.g. not a module).
		var exitErr *exec.ExitError
		if errors.As(err, &exitErr) {
			return "", fmt.Errorf("go list command failed: %s\nStderr: %s", err, string(exitErr.Stderr))
		}
		return "", fmt.Errorf("failed to execute go list: %w", err)
	}
	return strings.TrimSpace(string(output)), nil
}
