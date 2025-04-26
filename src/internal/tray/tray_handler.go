package tray

import (
	_ "embed"
	"fmt"
	"github.com/RA341/gouda/internal/config"
	"github.com/RA341/gouda/pkg/logger"
	"github.com/getlantern/systray"
	"github.com/pkg/browser"
	"github.com/rs/zerolog/log"
	"os"
	"os/exec"
	"path/filepath"
	"runtime"
)

var (
	frontendExecutable = "brie"
)

//go:embed assets/cheese.ico
var systrayIcon []byte

func OnReady() {
	systray.SetTitle("Gouda Launcher")
	systray.SetTooltip("Gouda is Running")
	systray.SetIcon(systrayIcon)

	// Server control menu items
	_ = systray.AddMenuItem("Gouda", "")
	systray.AddSeparator()
	frontendOption := systray.AddMenuItem("Open Gouda", "Opens the gouda ui")
	webUi := systray.AddMenuItem("Open Web UI", "Opens the webui")
	systray.AddSeparator()
	mLogs := systray.AddMenuItem("Open Logs Directory", "Open the logs folder")
	systray.AddSeparator()
	mQuit := systray.AddMenuItem("Quit", "Quit the application")

	// Launch the main application logic
	runMainApp()

	// Handle menu actions
	go func() {
		for {
			select {
			case <-frontendOption.ClickedCh:
				log.Info().Msg("Launching frontend")
				launchFrontend()
			case <-webUi.ClickedCh:
				err := browser.OpenURL("http://localhost:9862")
				if err != nil {
					log.Error().Err(err).Msg("Failed to launch browser")
				}
			case <-mLogs.ClickedCh:
				log.Info().Msg("opening Logs")
				openLogsDirectory()
			case <-mQuit.ClickedCh:
				// Kill both processes before quitting
				killProcess([]string{frontendExecutable})
				systray.Quit()
				os.Exit(0)
			}
		}
	}()
}

func OnExit() {
	log.Info().Msg("Exiting gouda goodbye!")
}

func runMainApp() {
	// Get the working directory
	appDir := getWorkingDir()
	log.Info().Str("appDir", appDir).Msg("Path info")

	if runtime.GOOS == "windows" {
		frontendExecutable += ".exe"
	}

	launchFrontend()
}

func launchFrontend() {
	fullFrontendPath := filepath.Join(getWorkingDir(), "frontend", frontendExecutable)
	log.Info().Str("path", fullFrontendPath).Msg("frontend path")

	if isProcessRunning(frontendExecutable) {
		log.Info().Msgf("%s is already running", frontendExecutable)
	} else {
		log.Info().Msgf("%s is starting", frontendExecutable)

		flutterLogFile := logger.GetFileLogger(fmt.Sprintf("%s/flutter.log", config.GetConfigDir()))

		// Flutter frontend
		flutterApp := exec.Command(filepath.Join(fullFrontendPath))
		flutterApp.Stdout = flutterLogFile
		flutterApp.Stderr = flutterLogFile

		go func() {
			err := flutterApp.Run()
			if err != nil {
				log.Error().Err(err).Msg("Unable frontend exited with error")
			}
			log.Info().Msg("Frontend exited normally")

			// close main app if set by user
			if config.ExitOnClose.GetBool() == true {
				log.Info().Msg("exiting main gouda process since exit_on_close is set")
				os.Exit(0)
			}

			log.Info().Msg("Exiting frontend process only")
		}()
	}
}
