package main

import (
	"crypto/sha256"
	"fmt"
	"github.com/fatih/color"
	"io"
	"log/slog"
	"os"
	"path/filepath"
	"runtime"
	"sort"
	"strings"
	"time"
)

const GoBinWebPath = "src/cmd/web"

var (
	infoPackagePath = "github.com/RA341/gouda/internal/info"
)

type GoBuildConfig struct {
	variant    string
	version    string
	buildDate  time.Time
	branch     string
	commit     string
	sourceHash string
	outputDir  string
	verbose    bool
}

type BuildOpt func(*GoBuildConfig)

// assumes cwd is gouda root
const goRoot = "src"

func runGoBuild(opt ...BuildOpt) (string, error) {
	cmd, binaryPath := generateGoBuildCmd(opt...)
	if err := executeCommand(cmd, goRoot); err != nil {
		return "", err
	}

	abs, err := filepath.Abs(goRoot + "/" + binaryPath)
	if err != nil {
		return "", err
	}

	return abs, nil
}

var (
	printCyan = color.New(color.FgCyan).PrintlnFunc()
)

func generateGoBuildCmd(opt ...BuildOpt) ([]string, string) {
	var config GoBuildConfig
	withDefault()(&config) // start with default struct
	for _, o := range opt {
		o(&config)
	}
	printCyan("Building go with", slog.AnyValue(config).String())

	buildCmd := []string{"go", "build"}
	if config.verbose {
		buildCmd = append(buildCmd, "-v")
	}

	ldflags := []string{
		"-s", "-w",
		addLDVar("Version", config.version),
		addLDVar("Branch", config.branch),
		addLDVar("CommitInfo", config.commit),
		addLDVar("BuildDate", config.buildDate.Format(time.RFC3339)),
		addLDVar("SourceHash", config.sourceHash),
	}

	// quotes are not needed
	finalFlag := fmt.Sprintf(`-ldflags=%s`, strings.Join(ldflags, " "))
	buildCmd = append(buildCmd, finalFlag)

	binPath, packagePath := getBinName(config.variant)
	if config.outputDir != "" {
		binPath = config.outputDir + "/" + binPath
	}

	if config.variant == "desktop" && getOSName() == "windows" {
		printCyan("removing terminal from windows build")
		// remove terminal launch on windows builds
		ldflags = append(ldflags, "-H=windowsgui")
	}

	buildCmd = append(buildCmd, "-o", binPath)
	buildCmd = append(buildCmd, packagePath)

	return buildCmd, binPath
}

func withDefault() BuildOpt {
	return func(config *GoBuildConfig) {
		config.variant = "all"
		config.version = "dev"
		config.buildDate = time.Now()
		config.branch = "unknown"
		config.commit = "unknown"
		config.sourceHash = "unknown"
		config.outputDir = ""
		config.verbose = false
	}
}

func withGitMetadata() {

}

func withVariant(variant string) BuildOpt {
	return func(config *GoBuildConfig) {
		config.variant = variant
	}
}

func addLDVar(key string, variable string) string {
	return fmt.Sprintf("-X %s.%s=%s", infoPackagePath, key, variable)
}

func getBinName(variant string) (baseBin string, packagePath string) {
	osName := getOSName()
	baseBin = "gouda"
	packagePath = "./cmd"

	// add binary type gouda_desktop
	baseBin += "-" + variant + "-" + osName
	// add main.go path cmd/desktop
	packagePath += "/" + variant

	if osName == "windows" {
		baseBin += ".exe"
	}

	return baseBin, packagePath
}

func getOSName() string {
	return runtime.GOOS
}

func calculateGoSourceHash(baseDir string) (string, int, error) {
	searchPath := baseDir
	if searchPath == "" {
		wd, err := os.Getwd()
		if err != nil {
			return "", 0, fmt.Errorf("failed to get current working directory: %w", err)
		}
		searchPath = wd
	}

	// Ensure the search path is absolute for consistent results if baseDir is relative
	absSearchPath, err := filepath.Abs(searchPath)
	if err != nil {
		return "", 0, fmt.Errorf("failed to get absolute path for '%s': %w", searchPath, err)
	}
	searchPath = absSearchPath

	fileInfo, err := os.Stat(searchPath)
	if err != nil {
		if os.IsNotExist(err) {
			return "", 0, fmt.Errorf("directory '%s' does not exist", searchPath)
		}
		return "", 0, fmt.Errorf("failed to stat directory '%s': %w", searchPath, err)
	}
	if !fileInfo.IsDir() {
		return "", 0, fmt.Errorf("path '%s' is not a directory", searchPath)
	}

	var goFiles []string
	err = filepath.WalkDir(searchPath, func(path string, d os.DirEntry, walkErr error) error {
		if walkErr != nil {
			return fmt.Errorf("error accessing path '%s': %w", path, walkErr)
		}
		if !d.IsDir() && strings.HasSuffix(d.Name(), ".go") {
			goFiles = append(goFiles, path)
		}
		return nil
	})
	if err != nil {
		return "", 0, fmt.Errorf("error finding .go files in '%s': %w", searchPath, err)
	}

	if len(goFiles) == 0 {
		return "", 0, fmt.Errorf("no .go files found in '%s' or its subdirectories", searchPath)
	}

	// Sort files by path for consistent hashing.
	sort.Strings(goFiles)

	hasher := sha256.New()
	for _, goFilePath := range goFiles {
		file, openErr := os.Open(goFilePath)
		if openErr != nil {
			return "", 0, fmt.Errorf("failed to open file '%s': %w", goFilePath, openErr)
		}

		if _, copyErr := io.Copy(hasher, file); copyErr != nil {
			if closeErr := file.Close(); closeErr != nil {
				fmt.Printf("error ocurred while closing file '%s': %v\n", goFilePath, err)
			}

			return "", 0, fmt.Errorf("failed to read/hash file '%s': %w", goFilePath, copyErr)
		}

		if closeErr := file.Close(); closeErr != nil {
			fmt.Printf("error ocurred while closing file '%s': %v\n", goFilePath, err)
		}
	}

	finalHash := fmt.Sprintf("%x", hasher.Sum(nil))
	return finalHash, len(goFiles), nil
}
