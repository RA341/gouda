package main

import (
	"fmt"
	"io"
	"log/slog"
	"os"
	"path/filepath"
)

var (
	variants = map[string]interface{}{
		"all":     struct{}{},
		"desktop": struct{}{},
		"server":  struct{}{},
	}
)

func build(variant string, destinationDir string, opt ...BuildOpt) error {
	if variant == "all" {
		// todo
		//err := buildServer(destinationDir, opt...)
		//if err != nil {
		//	return err
		//}
		//
		//err = buildDesktop(destinationDir, opt...)
		//if err != nil {
		//	return err
		//}
	} else if variant == "desktop" {
		err := buildDesktop(destinationDir, opt...)
		if err != nil {
			return err
		}
	} else if variant == "server" {
		err := buildServer(destinationDir, opt...)
		if err != nil {
			return err
		}
	}

	return nil
}

func buildServer(destinationDir string, opt ...BuildOpt) error {
	destinationDir, err := filepath.Abs(destinationDir)
	if err != nil {
		return err
	}

	buildPath, err := runFlutterBuild("web")
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

func buildDesktop(destinationDir string, opt ...BuildOpt) error {
	destinationDir = getAbs(destinationDir)

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
		// build binary and place it in tmp folder
		opt := append(opt, withVariant("desktop"))
		if err := buildServer(tmpBuildFolder, opt...); err != nil {
			errCh <- err
		}
		errCh <- nil
	}()

	go func() {
		name := getOSName()
		flutterBuildDir, err := runFlutterBuild(name)
		if err != nil {
			errCh <- err
			return
		}

		slog.Info("Desktop built", "build_dir", tmpBuildDesktopDir, "flutter_build_dir", flutterBuildDir)
		err = os.RemoveAll(tmpBuildDesktopDir)
		if err != nil {
			errCh <- err
			return
		}
		err = CopyFolder(flutterBuildDir, tmpBuildDesktopDir)
		if err != nil {
			errCh <- err
			return
		}

		errCh <- nil
	}()

	count := 0
	for err := range errCh {
		if err != nil {
			return err
		}
		count++
		if count == 2 {
			break
		}
	}

	zipName := fmt.Sprintf("gouda-desktop-%s.zip", getOSName())
	zipName = filepath.Join(destinationDir, zipName)
	if err = zipDir(tmpBuildFolder, zipName); err != nil {
		return err
	}

	fmt.Println(tmpBuildFolder)
	return nil
}

func getAbs(destinationDir string) string {
	destinationDir, err := filepath.Abs(destinationDir)
	cmdError(err)

	slog.Info("output", "dest", destinationDir)
	return destinationDir
}
