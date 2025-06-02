package main

import (
	"bytes"
	"crypto/sha256"
	"fmt"
	"github.com/fatih/color"
	"io"
	"os"
	"path/filepath"
	"runtime"
	"slices"
	"strings"
	"time"
)

const GoBinWebPath = "src/cmd/web"

var (
	infoPackagePath = "github.com/RA341/gouda/internal/info"
)

type GoBuildConfig struct {
	Variant    string
	Version    string
	BuildDate  time.Time
	Branch     string
	Commit     string
	SourceHash string
	OutputDir  string
	Verbose    bool
	WorkingDir string
}

type BuildOpt func(*GoBuildConfig)

// assumes cwd is gouda root
const goRoot = "src"

func runGoBuild(opt ...BuildOpt) (string, error) {
	config := loadConfig(opt)
	cmd, binaryPath := generateGoBuildCmd(config)
	printCyan(cmd)

	if err := executeCommand(cmd, config.WorkingDir, os.Stdout, os.Stderr); err != nil {
		return "", err
	}

	abs, err := filepath.Abs(config.WorkingDir + "/" + binaryPath)
	if err != nil {
		return "", err
	}

	return abs, nil
}

func loadConfig(opt []BuildOpt) GoBuildConfig {
	var config GoBuildConfig
	withDefault()(&config) // start with default struct
	for _, o := range opt {
		o(&config)
	}
	printCyan("Building go with", fmt.Sprintf("%+v", config))
	return config
}

var (
	printCyan = color.New(color.FgCyan).PrintlnFunc()
)

func generateGoBuildCmd(config GoBuildConfig) ([]string, string) {
	buildCmd := []string{"go", "build"}
	if config.Verbose {
		buildCmd = append(buildCmd, "-v")
	}

	ldflags := []string{
		"-s", "-w",
		addLDVar("Version", config.Version),
		addLDVar("Branch", config.Branch),
		addLDVar("CommitInfo", config.Commit),
		addLDVar("BuildDate", config.BuildDate.Format(time.RFC3339)),
		addLDVar("SourceHash", config.SourceHash),
	}
	if config.Variant == "desktop" && getOSName() == "windows" {
		printCyan("removing terminal from windows build")
		// remove terminal launch on windows builds
		ldflags = append(ldflags, "-H=windowsgui")
	}
	finalLDFlags := fmt.Sprintf(`-ldflags=%s`, strings.Join(ldflags, " "))

	binPath, packagePath := getBinName(config.Variant)
	if config.OutputDir != "" {
		binPath = config.OutputDir + "/" + binPath
	}

	buildCmd = append(buildCmd, finalLDFlags)
	buildCmd = append(buildCmd, "-o", binPath)
	buildCmd = append(buildCmd, packagePath)

	return buildCmd, binPath
}

func withDefault() BuildOpt {
	return func(config *GoBuildConfig) {
		config.Variant = "all"
		config.Version = "dev"
		config.BuildDate = time.Now()
		config.Branch = "unknown"
		config.Commit = "unknown"
		config.SourceHash = "unknown"
		config.OutputDir = ""
		config.Verbose = false
	}
}

func withGoudaRoot() BuildOpt {
	return withWorkingDir(goRoot)
}

func withWorkingDir(dir string) BuildOpt {
	abs, err := filepath.Abs(dir)
	must(err)
	return func(config *GoBuildConfig) {
		config.WorkingDir = abs
	}
}

func withGitMetadata(info GitInfo) BuildOpt {
	return func(config *GoBuildConfig) {
		config.Branch = info.Branch
		config.Commit = info.Commit
		config.Version = info.Tag
	}
}

func withSourceHash(workingDir string) BuildOpt {
	hash, files, err := calculateGoSourceHash(workingDir)
	must(err)
	printCyan("gouda hash:", hash, "files:", files)

	return func(config *GoBuildConfig) {
		config.SourceHash = hash
	}
}

func withVariant(variant string) BuildOpt {
	return func(config *GoBuildConfig) {
		config.Variant = variant
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
	name := runtime.GOOS
	if name == "darwin" {
		return "macos"
	} else if name == "linux" {
		return name
	} else if name == "windows" {
		return name
	}

	must(fmt.Errorf("unsupported  OS: %s", name))
	return ""
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
	slices.SortStableFunc(goFiles, func(a, b string) int {
		// remove ".../Dev/Go/gouda/src" compare only the subdir and files
		a, _ = strings.CutPrefix(a, searchPath)
		b, _ = strings.CutPrefix(b, searchPath)
		a = filepath.ToSlash(a)
		b = filepath.ToSlash(b)
		return strings.Compare(a, b)
	})

	hasher := sha256.New()
	for _, goFilePath := range goFiles {
		file, openErr := os.Open(goFilePath)
		if openErr != nil {
			return "", 0, fmt.Errorf("failed to open file '%s': %w", goFilePath, openErr)
		}

		if _, copyErr := io.Copy(hasher, file); copyErr != nil {
			warn(file.Close())
			return "", 0, fmt.Errorf("failed to read/hash file '%s': %w", goFilePath, copyErr)
		}

		warn(file.Close())
	}

	finalHash := fmt.Sprintf("%x", hasher.Sum(nil))
	return finalHash, len(goFiles), nil
}

type GitInfo struct {
	Commit string
	Branch string
	Tag    string
}

// getGitInfo retrieves the latest commit hash, current branch, and latest tag
// from the Git repository in the current working directory.
// It assumes '.git' directory exists and 'git' command is available.
func getGitInfo() (GitInfo, error) {
	info := GitInfo{}
	var err error
	var out bytes.Buffer
	var stderr bytes.Buffer

	commitCmd := []string{"git", "rev-parse", "HEAD"}
	if err = executeCommand(commitCmd, "", &out, &stderr); err != nil {
		return info, fmt.Errorf("failed to get commit hash: %w. Stderr: %s", err, stderr.String())
	}
	info.Commit = strings.TrimSpace(out.String())
	out.Reset()
	stderr.Reset()

	branchCmd := []string{"git", "rev-parse", "--abbrev-ref", "HEAD"}
	if err = executeCommand(branchCmd, "", &out, &stderr); err != nil {
		return info, fmt.Errorf("failed to get branch name: %w. Stderr: %s", err, stderr.String())
	}
	info.Branch = strings.TrimSpace(out.String())
	out.Reset()
	stderr.Reset()

	tagCmd := []string{"git", "describe", "--tags", "--abbrev=0", "HEAD"}
	err = executeCommand(tagCmd, "", &out, &stderr)
	if err != nil {
		warn(fmt.Errorf("no tag retrived"))
		info.Tag = ""
	} else {
		info.Tag = strings.TrimSpace(out.String())
	}

	printGreen("Git:", info)
	return info, nil
}
