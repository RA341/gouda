package file_utils

import (
	"fmt"
	"io"
	"io/fs"
	"mime"
	"net/http"
	"os"
	"path"
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

// HardLinkFolder creates hard links of all files from source folder to target folder
// and maintains the original UID/GID
func HardLinkFolder(sourceDir, targetDir string) error {
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
		if err := createHardLink(sourceDir, targetDir, sourceStat.Mode()); err != nil {
			return fmt.Errorf("failed to create hard link from %s to %s: %w", sourceDir, targetDir, err)
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
		err = createHardLink(path, targetPath, info.Mode())
		if err != nil {
			return fmt.Errorf("failed to create hard link from %s to %s: %w", path, targetPath, err)
		}

		return nil
	})
}

func DownloadTorrentFile(downloadLink, downloadPath string) (string, error) {
	resp, err := http.Get(downloadLink)
	if err != nil {
		return "", fmt.Errorf("failed to make request: %v", err)
	}
	if resp.StatusCode != 200 {
		return "", fmt.Errorf("invalid http code: %d, reason: %s", resp.StatusCode, resp.Status)
	}

	defer func(Body io.ReadCloser) {
		_ = Body.Close()
	}(resp.Body)

	// Get filename from Content-Disposition header
	_, params, err := mime.ParseMediaType(resp.Header.Get("Content-Disposition"))
	filename := ""
	if err == nil && params["filename"] != "" {
		filename = params["filename"]
	} else {
		// Fallback to URL path if header not available
		filename = path.Base(downloadLink)
	}

	if err := os.MkdirAll(downloadPath, 0775); err != nil {
		return "", fmt.Errorf("failed to create directories: %v", err)
	}

	destPath := fmt.Sprintf("%s/%s", downloadPath, filename)
	file, err := os.Create(destPath)
	if err != nil {
		return "", fmt.Errorf("failed to create file: %v", err)
	}
	defer func(file *os.File) {
		_ = file.Close()
	}(file)

	_, err = io.Copy(file, resp.Body)
	if err != nil {
		return "", fmt.Errorf("failed to copy response body: %v", err)
	}

	return destPath, nil
}

// createHardLink creates a hard link with proper ownership and permissions
func createHardLink(oldPath, newPath string, mode fs.FileMode) error {
	// Ensure the target directory exists
	targetDir := filepath.Dir(newPath)
	if err := os.MkdirAll(targetDir, 0755); err != nil {
		return err
	}

	// Remove existing file if it exists
	if err := os.Remove(newPath); err != nil && !os.IsNotExist(err) {
		return err
	}

	// Create the hard link
	if err := os.Link(oldPath, newPath); err != nil {
		return err
	}

	if err := os.Chmod(newPath, mode); err != nil {
		return fmt.Errorf("failed to set permissions: %w", err)
	}

	return nil
}
