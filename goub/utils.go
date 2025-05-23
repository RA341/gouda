package main

import (
	"archive/zip"
	"fmt"
	"io"
	"io/fs"
	"log"
	"log/slog"
	"os"
	"os/exec"
	"path/filepath"
	"strings"
)

// resolves the main gouda directory from any working directory inside the project
// e.g: if in gouda/docs, calling this command will resolve to gouda/
// if outside some_dir/ error
func resolveRootDir() error {
	initialWD, err := os.Getwd()
	if err != nil {
		return fmt.Errorf("failed to get current working directory: %w", err)
	}

	currentDir := initialWD
	// Safety limit for directory traversal to prevent infinite loops on unusual filesystems
	// or in case of symlink cycles (though filepath.Dir should handle standard cases).
	maxLevelsToScan := 30

	for range maxLevelsToScan {
		if filepath.Base(currentDir) == "gouda" {
			if currentDir != initialWD {
				slog.Info("Found 'gouda', Changing current directory", "project_root", currentDir)
				if err := os.Chdir(currentDir); err != nil {
					return fmt.Errorf("found 'gouda' root at '%s' but failed to change directory: %w", currentDir, err)
				}
			} else {
				slog.Info("Already in 'gouda' project root", "dir", currentDir)
			}
			return nil
		}
		parentDir := filepath.Dir(currentDir)
		if parentDir == currentDir {
			return fmt.Errorf("could not find 'gouda' project root by traversing up from '%s'", initialWD)
		}
		currentDir = parentDir
	}
	return fmt.Errorf("could not find 'gouda' project root within %d levels by traversing up from '%s'", maxLevelsToScan, initialWD)
}

func zipDir(sourceDir, targetZipFile string) error {
	zipFile, err := os.Create(targetZipFile)
	if err != nil {
		return fmt.Errorf("failed to create target zip file %s: %w", targetZipFile, err)
	}
	defer func() {
		warn(zipFile.Close())
	}()

	archive := zip.NewWriter(zipFile)
	defer func() {
		warn(archive.Close())
	}()

	sourceDir = filepath.Clean(sourceDir)
	info, err := os.Stat(sourceDir)
	if err != nil {
		return fmt.Errorf("failed to stat source directory %s: %w", sourceDir, err)
	}
	if !info.IsDir() {
		return fmt.Errorf("source %s is not a directory", sourceDir)
	}

	err = filepath.WalkDir(sourceDir, func(path string, d fs.DirEntry, walkErr error) error {
		if walkErr != nil {
			return fmt.Errorf("error during directory walk at %s: %w", path, walkErr)
		}

		fileInfo, err := d.Info()
		if err != nil {
			return fmt.Errorf("failed to get info for %s: %w", path, err)
		}

		// Create a proper path for the file within the zip archive
		// This path should be relative to the source directory
		relPath, err := filepath.Rel(sourceDir, path)
		if err != nil {
			return fmt.Errorf("failed to get relative path for %s: %w", path, err)
		}

		// If the sourceDir itself is being added, relPath will be ".", skip it for header name
		if relPath == "." {
			return nil
		}

		// Use forward slashes for zip paths, as is standard
		headerName := filepath.ToSlash(relPath)

		if d.IsDir() {
			// Add a directory entry. It's important to end directory names with a slash.
			if !strings.HasSuffix(headerName, "/") {
				headerName += "/"
			}
			// We only need to create an entry for non-empty directories if we want to preserve them
			// Or, more simply, just create an entry for every directory.
			// The CreateHeader method allows more control if needed.
			_, err = archive.Create(headerName) // For directories, this is often enough
			if err != nil {
				return fmt.Errorf("failed to create directory entry %s in zip: %w", headerName, err)
			}
			return nil // Continue walking
		}

		// If it's a regular file, create a file header
		header, err := zip.FileInfoHeader(fileInfo)
		if err != nil {
			return fmt.Errorf("failed to create zip header for %s: %w", path, err)
		}

		// Set the name for the file in the zip archive
		header.Name = headerName

		// Set compression method (optional, Deflate is common)
		header.Method = zip.Deflate

		writer, err := archive.CreateHeader(header)
		if err != nil {
			return fmt.Errorf("failed to create entry for %s in zip: %w", path, err)
		}

		fileToZip, err := os.Open(path)
		if err != nil {
			return fmt.Errorf("failed to open source file %s: %w", path, err)
		}
		defer func() {
			warn(fileToZip.Close())
		}()

		_, err = io.Copy(writer, fileToZip)
		if err != nil {
			return fmt.Errorf("failed to copy content of %s to zip: %w", path, err)
		}

		return nil
	})

	if err != nil {
		return fmt.Errorf("error walking the path %s: %w", sourceDir, err)
	}

	fmt.Printf("Successfully created zip archive: %s\n", targetZipFile)
	return nil
}

func executeCommand(buildCmd []string, workingDir string) error {
	//fmt.Println("Executing:", strings.Join(buildCmd, "\n"))
	runBuild := exec.Command(buildCmd[0], buildCmd[1:]...)
	runBuild.Stdout = os.Stdout
	runBuild.Stderr = os.Stderr
	runBuild.Dir = workingDir
	return runBuild.Run()
}

func backToParent() {
	if err := os.Chdir(".."); err != nil {
		cmdError(fmt.Errorf("unable to move back to root: %v", err))
	}
}
func cmdError(err error) {
	if err != nil {
		log.Fatal(boldRedF("%s", err.Error()))
	}
}

func warn(err error) {
	if err != nil {
		slog.Warn(err.Error())
	}
}

func CopyFolder(sourceDir, targetDir string) error {
	return walkFolder(sourceDir, targetDir, copyFile)
}

func walkFolder(sourceDir, targetDir string, actionFunc func(oldPath string, newPath string, mode fs.FileMode) error) error {
	// Check if source directory exists
	sourceStat, err := os.Stat(sourceDir)
	if err != nil {
		return fmt.Errorf("source directory error: %w", err)
	}

	// Create target directory if it doesn't exist
	err = os.MkdirAll(targetDir, os.FileMode(0777))
	if err != nil {
		return fmt.Errorf("failed to create target directory: %w", err)
	}

	// Handle based on whether source is file or directory
	if !sourceStat.IsDir() {
		// For single file, create the parent directory if needed
		sourceFile := filepath.Base(sourceDir)
		targetDir = fmt.Sprintf("%s/%s", targetDir, sourceFile)

		// Create hard link for the file
		if err := actionFunc(sourceDir, targetDir, sourceStat.Mode()); err != nil {
			return err
		}

		return nil
	}

	// Walk through the source directory
	return filepath.WalkDir(sourceDir, func(path string, d fs.DirEntry, err error) error {
		if err != nil {
			return err
		}

		// Get file info including system info (UID/GID)
		info, err := d.Info()
		if err != nil {
			return fmt.Errorf("failed to get file info: %w", err)
		}

		// Get relative path
		relPath, err := filepath.Rel(sourceDir, path)
		if err != nil {
			return fmt.Errorf("failed to get relative path: %w", err)
		}

		// Get target path
		targetPath := filepath.Join(targetDir, relPath)

		// If it's a directory, create it in target with proper ownership
		if d.IsDir() {
			if err := os.MkdirAll(targetPath, os.FileMode(0777)); err != nil {
				return fmt.Errorf("failed to create directory %s: %w", targetPath, err)
			}

			return nil
		}

		// Create hard link for files
		err = actionFunc(path, targetPath, info.Mode())
		if err != nil {
			return err
		}

		return nil
	})
}

func copyFile(src, dest string, mode fs.FileMode) error {
	sourceFile, err := os.Open(src)
	if err != nil {
		return fmt.Errorf("failed to open source file %s: %w", src, err)
	}
	defer func(sourceFile *os.File) {
		_ = sourceFile.Close()
	}(sourceFile)

	// Get source file info for permissions
	sourceInfo, err := sourceFile.Stat()
	if err != nil {
		return fmt.Errorf("failed to stat source file %s: %w", src, err)
	}

	// Create the destination file for writing.
	// If it exists, it will be truncated.
	destinationFile, err := os.OpenFile(dest, os.O_RDWR|os.O_CREATE|os.O_TRUNC, sourceInfo.Mode())
	if err != nil {
		return fmt.Errorf("failed to create destination file %s: %w", dest, err)
	}
	defer func(destinationFile *os.File) {
		_ = destinationFile.Close()
	}(destinationFile)

	// Copy the contents from source to destination
	_, err = io.Copy(destinationFile, sourceFile)
	if err != nil {
		return fmt.Errorf("failed to copy data from %s to %s: %w", src, dest, err)
	}

	// Ensure all data is written to stable storage
	err = destinationFile.Sync()
	if err != nil {
		return fmt.Errorf("failed to sync destination file %s: %w", dest, err)
	}

	return nil
}
