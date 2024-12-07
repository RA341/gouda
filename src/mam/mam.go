package mam

import (
	"fmt"
	"github.com/spf13/viper"
	"io"
	"io/fs"
	"log"
	"mime"
	"net/http"
	"os"
	"path"
	"path/filepath"
)

// anon mouse related functions

func HardlinkAndNameFiles(downloadPath, destinationPath, author, bookName string) error {
	// create folder at destination
	finalDestPath := path.Join(destinationPath, author, bookName)
	finalDestPath, err := filepath.Abs(finalDestPath)
	if err != nil {
		return err
	}

	err = os.MkdirAll(finalDestPath, 0o660)
	if err != nil {
		return err
	}

	err = os.Chown(finalDestPath, viper.GetInt("user.uid"), viper.GetInt("user.gid"))
	if err != nil {
		return err
	}

	// hardlink
	//get all sub folders
	err = HardLinkFolder(downloadPath, finalDestPath)
	if err != nil {
		return err
	}

	return nil
}

// HardLinkFolder creates hard links of all files from source folder to target folder
// and maintains the original UID/GID
func HardLinkFolder(sourceDir, targetDir string) error {
	// Check if source directory exists
	sourceStat, err := os.Stat(sourceDir)
	if err != nil {
		return fmt.Errorf("source directory error: %w", err)
	}
	if !sourceStat.IsDir() {
		return fmt.Errorf("source path is not a directory")
	}

	sourceUID := viper.GetInt("user.uid")
	sourceGID := viper.GetInt("user.gid")

	// Create target directory if it doesn't exist
	err = os.MkdirAll(targetDir, sourceStat.Mode())
	if err != nil {
		return fmt.Errorf("failed to create target directory: %w", err)
	}

	// Set UID/GID for target directory
	if err := os.Chown(targetDir, sourceUID, sourceGID); err != nil {
		return fmt.Errorf("failed to set ownership of target directory: %w", err)
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
			if err := os.MkdirAll(targetPath, info.Mode()); err != nil {
				return fmt.Errorf("failed to create directory %s: %w", targetPath, err)
			}

			// Set directory ownership
			if err := os.Chown(targetPath, viper.GetInt("user.uid"), viper.GetInt("user.gid")); err != nil {
				return fmt.Errorf("failed to set ownership of directory %s: %w", targetPath, err)
			}

			return nil
		}

		// Create hard link for files
		err = createHardLink(path, targetPath, viper.GetInt("user.uid"), viper.GetInt("user.gid"), info.Mode())
		if err != nil {
			return fmt.Errorf("failed to create hard link from %s to %s: %w", path, targetPath, err)
		}

		return nil
	})
}

// createHardLink creates a hard link with proper ownership and permissions
func createHardLink(oldPath, newPath string, uid, gid int, mode fs.FileMode) error {
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

	// Set the ownership and permissions
	if err := os.Chown(newPath, uid, gid); err != nil {
		return fmt.Errorf("failed to set ownership: %w", err)
	}

	if err := os.Chmod(newPath, mode); err != nil {
		return fmt.Errorf("failed to set permissions: %w", err)
	}

	return nil
}

func DownloadTorrentFile(downloadLink string, downloadPath string) (string, error) {
	resp, err := http.Get(downloadLink)
	if err != nil {
		return "", fmt.Errorf("failed to make request: %v", err)
	}
	defer func(Body io.ReadCloser) {
		err := Body.Close()
		if err != nil {
			log.Fatal("failed to close response body")
		}
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

	if err := os.MkdirAll(downloadPath, 0755); err != nil {
		return "", fmt.Errorf("failed to create directories: %v", err)
	}

	fmt.Println("Created dit")

	destPath := fmt.Sprintf("%s/%s", downloadPath, filename)
	file, err := os.Create(destPath)
	if err != nil {
		return "", fmt.Errorf("failed to create file: %v", err)
	}
	defer func(file *os.File) {
		err := file.Close()
		if err != nil {
			log.Fatalf("failed to close response body")
		}
	}(file)

	_, err = io.Copy(file, resp.Body)
	if err != nil {
		return "", fmt.Errorf("failed to copy response body: %v", err)
	}

	// logs !!
	fmt.Println(filename)

	return destPath, nil
}
