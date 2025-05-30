package file_utils

import (
	"fmt"
	"io"
	"io/fs"
	"os"
	"path/filepath"
	"runtime"
)

var DefaultFilePerm = 0o775

// RecursiveChown chowns the file/folder recursively at path
//
// Chowning is not supported on windows, no action will be taken if called on windows
func RecursiveChown(path string, uid, gid int) error {
	if runtime.GOOS == "windows" {
		return nil
	}
	// Walk the directory tree
	return filepath.Walk(path, func(name string, info os.FileInfo, err error) error {
		if err != nil {
			return err
		}

		// Change ownership of the current file/directory
		err = os.Chown(name, uid, gid)
		if err != nil {
			return fmt.Errorf("failed to chown %s: %v", name, err)
		}

		return nil
	})
}

func CopyFolder(sourceDir, targetDir string) error {
	return walkFolder(sourceDir, targetDir, copyFile)
}

// HardLinkFolder creates hard links of all files from source folder to target folder
// and maintains the original UID/GID
func HardLinkFolder(sourceDir, targetDir string) error {
	return walkFolder(sourceDir, targetDir, hardlinkFile)
}

func walkFolder(sourceDir, targetDir string, actionFunc func(oldPath string, newPath string, mode fs.FileMode) error) error {
	// Check if source directory exists
	sourceStat, err := os.Stat(sourceDir)
	if err != nil {
		return fmt.Errorf("source directory error: %w", err)
	}

	// Create target directory if it doesn't exist
	err = os.MkdirAll(targetDir, os.FileMode(DefaultFilePerm))
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
			if err := os.MkdirAll(targetPath, os.FileMode(DefaultFilePerm)); err != nil {
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

// hardlinkFile creates a hard link with proper ownership and permissions
func hardlinkFile(src, dest string, mode fs.FileMode) error {
	// Ensure the target directory exists
	targetDir := filepath.Dir(dest)
	if err := os.MkdirAll(targetDir, 0755); err != nil {
		return err
	}

	// Remove existing file if it exists
	if err := os.Remove(dest); err != nil && !os.IsNotExist(err) {
		return err
	}

	// Create the hard link
	if err := os.Link(src, dest); err != nil {
		return err
	}

	if err := os.Chmod(dest, mode); err != nil {
		return fmt.Errorf("failed to set permissions: %w", err)
	}

	return nil
}
