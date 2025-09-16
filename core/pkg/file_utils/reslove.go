package file_utils

import (
	"fmt"
	"os"
	"path/filepath"
)

func ResolvePaths(pathsToResolve []*string) error {
	for _, p := range pathsToResolve {
		absPath, err := filepath.Abs(*p)
		if err != nil {
			return fmt.Errorf("failed to get abs path for %s: %w", *p, err)
		}
		*p = absPath

		if err = os.MkdirAll(absPath, 0777); err != nil {
			return err
		}
	}
	return nil
}

func FileExists(filename string) bool {
	_, err := os.Stat(filename)
	return !os.IsNotExist(err)
}
