package main

import (
	"fmt"
	"github.com/getlantern/systray"
	"github.com/rs/zerolog/log"
	"os"
	"os/exec"
	"path/filepath"
	"runtime"
)

var (
	apiExecutable      = "gouda"
	frontendExecutable = "brie"
)

func main() {
	getWorkingDir()
	systray.Run(onReady, onExit)
}

func onReady() {
	systray.SetTitle("Gouda Launcher")
	systray.SetTooltip("Gouda is Running")
	systray.SetIcon(readIconToBytes(fmt.Sprintf("%s/%s", getWorkingDir(), "cheese.ico")))

	// Server control menu items
	_ = systray.AddMenuItem("Gouda", "")
	systray.AddSeparator()
	frontendOption := systray.AddMenuItem("Open Gouda", "Opens the gouda ui")
	systray.AddSeparator()
	mLogs := systray.AddMenuItem("Open Logs Directory", "Open the logs folder")
	systray.AddSeparator()
	mQuit := systray.AddMenuItem("Quit", "Quit the application")

	// Launch the main application logic
	go runMainApp()

	// Handle menu actions
	go func() {
		for {
			select {
			case <-frontendOption.ClickedCh:
				log.Info().Msg("Launching frontend")
				launchFrontend()
			case <-mLogs.ClickedCh:
				log.Info().Msg("opening Logs")
				openLogsDirectory()
			case <-mQuit.ClickedCh:
				// Kill both processes before quitting
				killProcess([]string{frontendExecutable, apiExecutable})
				systray.Quit()
				os.Exit(0)
			}
		}
	}()
}

func onExit() {
	log.Info().Msg("Exiting launcher Goodbye!")
}

func runMainApp() {
	// Get the working directory
	appDir := getWorkingDir()

	log.Logger = log.
		With().
		Caller().
		Logger().
		Output(getFileLogger(fmt.Sprintf("%s/%s", appDir, "launcher.log")))

	log.Info().Str("appDir", appDir).Msg("Path info")

	if runtime.GOOS == "windows" {
		apiExecutable += ".exe"
		frontendExecutable += ".exe"
	}

	launchAPI()
	launchFrontend()
}

func launchFrontend() {
	fullFrontendPath := filepath.Join(getWorkingDir(), "frontend", frontendExecutable)
	log.Info().Str("path", fullFrontendPath).Msg("frontend path")

	if isProcessRunning(frontendExecutable) {
		log.Info().Msgf("%s is already running", frontendExecutable)
	} else {
		log.Info().Msgf("%s is starting", frontendExecutable)

		flutterLogFile := getFileLogger(fmt.Sprintf("%s/%s", getWorkingDir(), "flutter.log"))

		// Flutter frontend
		flutterApp := exec.Command(filepath.Join(fullFrontendPath))
		flutterApp.Stdout = flutterLogFile
		flutterApp.Stderr = flutterLogFile

		err := flutterApp.Start()
		if err != nil {
			log.Error().Err(err).Msg("Unable to start frontend application")
		}
	}
}

func launchAPI() {
	fullApiPath := filepath.Join(getWorkingDir(), "api", apiExecutable)

	// Start the API server with output redirected to the log file
	if isProcessRunning(apiExecutable) {
		log.Info().Msgf("%s is already running", apiExecutable)
	} else {
		log.Info().Msgf("%s is starting", apiExecutable)
		// Create/open a log file
		apiLogFile := getFileLogger(fmt.Sprintf("%s/%s", getWorkingDir(), "api_server.log"))
		// Start the API server with output redirected to the log file
		apiServer := exec.Command(fullApiPath)
		apiServer.Stdout = apiLogFile
		apiServer.Stderr = apiLogFile

		// start exec in background
		applyOSSpecificAttr(apiServer)
		err := apiServer.Start()
		if err != nil {
			log.Fatal().Err(err).Msg("Failed to start api server")
		}
	}
}
