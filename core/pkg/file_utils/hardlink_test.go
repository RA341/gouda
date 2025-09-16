package file_utils

import (
	"io/fs"
	"os"
	"path/filepath"
	"testing"
)

// Helper function to create a test file with specific content and mode.
func createTestFile(t *testing.T, path string, content string, mode fs.FileMode) {
	t.Helper()
	dir := filepath.Dir(path)
	if err := os.MkdirAll(dir, os.FileMode(DefaultFilePerm)); err != nil {
		t.Fatalf("Failed to create directory %s: %v", dir, err)
	}
	err := os.WriteFile(path, []byte(content), mode)
	if err != nil {
		t.Fatalf("Failed to write file %s: %v", path, err)
	}
}

// Helper function to check file content.
func checkFileContent(t *testing.T, path string, expectedContent string) {
	t.Helper()
	content, err := os.ReadFile(path)
	if err != nil {
		t.Fatalf("Failed to read file %s: %v", path, err)
	}
	if string(content) != expectedContent {
		t.Errorf("File content mismatch for %s. Got %q, want %q", path, string(content), expectedContent)
	}
}

func TestCopyFile(t *testing.T) {
	sourceDir := t.TempDir()
	targetDir := t.TempDir()

	srcFilePath := filepath.Join(sourceDir, "source.txt")
	destFilePath := filepath.Join(targetDir, "dest.txt")
	fileContent := "Hello, copyFile!"
	fileMode := fs.FileMode(0644)

	createTestFile(t, srcFilePath, fileContent, fileMode)

	t.Run("successful copy", func(t *testing.T) {
		err := copyFile(srcFilePath, destFilePath, fileMode) // mode arg in copyFile is a bit redundant as it re-stats
		if err != nil {
			t.Fatalf("copyFile failed: %v", err)
		}
		checkFileContent(t, destFilePath, fileContent)
	})

	t.Run("source does not exist", func(t *testing.T) {
		err := copyFile(filepath.Join(sourceDir, "nonexistent.txt"), destFilePath, fileMode)
		if err == nil {
			t.Errorf("copyFile should have failed for non-existent source, but got nil error")
		}
	})

	t.Run("destination not writable", func(t *testing.T) {
		// Create a read-only directory for destination
		readOnlyDir := filepath.Join(t.TempDir(), "readonly")
		if err := os.Mkdir(readOnlyDir, 0555); err != nil { // Read and execute only
			t.Fatalf("Failed to create read-only dir: %v", err)
		}
		// On some OS, root can still write. This test is more effective if run as non-root.
		destInReadOnlyDir := filepath.Join(readOnlyDir, "cantwrite.txt")
		err := copyFile(srcFilePath, destInReadOnlyDir, fileMode)
		if err == nil {
			// Clean up the created file if the test fails
			_ = os.Remove(destInReadOnlyDir)
			// Attempt to make dir writable to remove it
			_ = os.Chmod(readOnlyDir, 0755)
			t.Errorf("copyFile should have failed for non-writable destination, but got nil error")
		}
	})
}

func TestHardlinkFile(t *testing.T) {
	sourceDir := t.TempDir()
	targetDir := t.TempDir()

	srcFilePath := filepath.Join(sourceDir, "source_hl.txt")
	destFilePath := filepath.Join(targetDir, "dest_hl.txt")
	fileContent := "Hello, hardlinkFile!"
	fileMode := fs.FileMode(0664) // Use a different mode to test chmod

	createTestFile(t, srcFilePath, fileContent, fileMode)

	t.Run("successful hardlink", func(t *testing.T) {
		err := hardlinkFile(srcFilePath, destFilePath, fileMode)
		if err != nil {
			t.Fatalf("hardlinkFile failed: %v", err)
		}
		checkFileContent(t, destFilePath, fileContent) // Content should be same
	})

	t.Run("source does not exist", func(t *testing.T) {
		err := hardlinkFile(filepath.Join(sourceDir, "nonexistent_hl.txt"), destFilePath, fileMode)
		if err == nil {
			t.Errorf("hardlinkFile should have failed for non-existent source, but got nil error")
		}
	})
}

func TestCopyFolder(t *testing.T) {
	t.Run("copy complex directory structure", func(t *testing.T) {
		sourceDir := t.TempDir()
		targetDir := t.TempDir()

		// Create source structure
		// Source
		// |- file1.txt (content1, 0644)
		// |- subdir1 (0755)
		//    |- file2.txt (content2, 0600)
		//    |- subsubdir (0700)
		//       |- file3.txt (content3, 0666)
		// |- empty_subdir (0711)
		createTestFile(t, filepath.Join(sourceDir, "file1.txt"), "content1", 0644)
		if err := os.Mkdir(filepath.Join(sourceDir, "subdir1"), 0755); err != nil {
			t.Fatal(err)
		}
		createTestFile(t, filepath.Join(sourceDir, "subdir1", "file2.txt"), "content2", 0600)
		if err := os.Mkdir(filepath.Join(sourceDir, "subdir1", "subsubdir"), 0700); err != nil {
			t.Fatal(err)
		}
		createTestFile(t, filepath.Join(sourceDir, "subdir1", "subsubdir", "file3.txt"), "content3", 0666)
		if err := os.Mkdir(filepath.Join(sourceDir, "empty_subdir"), 0711); err != nil {
			t.Fatal(err)
		}

		err := CopyFolder(sourceDir, targetDir)
		if err != nil {
			t.Fatalf("CopyFolder failed: %v", err)
		}

		// Verify target structure and content
		checkFileContent(t, filepath.Join(targetDir, "file1.txt"), "content1")

		checkFileContent(t, filepath.Join(targetDir, "subdir1", "file2.txt"), "content2")

		checkFileContent(t, filepath.Join(targetDir, "subdir1", "subsubdir", "file3.txt"), "content3")

		if _, err := os.Stat(filepath.Join(targetDir, "empty_subdir")); os.IsNotExist(err) {
			t.Errorf("empty_subdir was not created in target")
		}
	})

	t.Run("copy single file as source", func(t *testing.T) {
		sourceFileDir := t.TempDir()
		targetRootDir := t.TempDir()

		srcFilePath := filepath.Join(sourceFileDir, "standalone.txt")
		fileContent := "standalone content"
		fileMode := fs.FileMode(0644)
		createTestFile(t, srcFilePath, fileContent, fileMode)

		// Target should be a directory where the file will be placed
		err := CopyFolder(srcFilePath, targetRootDir)
		if err != nil {
			t.Fatalf("CopyFolder with single file source failed: %v", err)
		}

		expectedTargetPath := filepath.Join(targetRootDir, "standalone.txt")
		checkFileContent(t, expectedTargetPath, fileContent)
	})
}

func TestHardLinkFolder(t *testing.T) {
	t.Run("hardlink complex directory structure", func(t *testing.T) {
		sourceDir := t.TempDir()
		targetDir := t.TempDir()

		// Create source structure (similar to CopyFolder test)
		createTestFile(t, filepath.Join(sourceDir, "hl_file1.txt"), "hl_content1", 0644)
		if err := os.Mkdir(filepath.Join(sourceDir, "hl_subdir1"), 0755); err != nil {
			t.Fatal(err)
		}
		createTestFile(t, filepath.Join(sourceDir, "hl_subdir1", "hl_file2.txt"), "hl_content2", 0600)

		err := HardLinkFolder(sourceDir, targetDir)
		if err != nil {
			t.Fatalf("HardLinkFolder failed: %v", err)
		}

		// Verify target structure, content, mode, and hardlink status
		targetFile1 := filepath.Join(targetDir, "hl_file1.txt")
		checkFileContent(t, targetFile1, "hl_content1")

		targetFile2 := filepath.Join(targetDir, "hl_subdir1", "hl_file2.txt")
		checkFileContent(t, targetFile2, "hl_content2")
	})

	t.Run("hardlink single file as source", func(t *testing.T) {
		sourceFileDir := t.TempDir()
		targetRootDir := t.TempDir()

		srcFilePath := filepath.Join(sourceFileDir, "standalone_hl.txt")
		fileContent := "standalone hardlink content"
		fileMode := fs.FileMode(0660)
		createTestFile(t, srcFilePath, fileContent, fileMode)

		err := HardLinkFolder(srcFilePath, targetRootDir)
		if err != nil {
			t.Fatalf("HardLinkFolder with single file source failed: %v", err)
		}

		expectedTargetPath := filepath.Join(targetRootDir, "standalone_hl.txt")
		checkFileContent(t, expectedTargetPath, fileContent)
	})
}
