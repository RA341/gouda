package main

import (
	"io"
	"io/fs"
	"log"
	"os"
	"os/exec"
	"os/signal"
	"path/filepath"
	"sync"
	"syscall"
	"time"

	"github.com/fsnotify/fsnotify"
)

func main() {
	if len(os.Args) < 2 {
		log.Fatal("Path to watch must be provided as an argument.")
	}
	path := os.Args[1]
	log.Println("Using path to watch:", path)

	watcher, err := fsnotify.NewWatcher()
	if err != nil {
		log.Fatal("Error creating watcher:", err)
	}
	defer func() {
		log.Println("Closing file watcher.")
		watcher.Close()
	}()

	err = watcher.Add(path)
	if err != nil {
		log.Fatal("Error adding path to watcher:", err)
		return
	}

	err = filepath.WalkDir(path, func(path string, d fs.DirEntry, err error) error {
		if d.IsDir() {
			watcher.Add(path)
		}
		return nil
	})

	cmd := exec.Command("flutter", "run", "-d", "windows")

	stdin, err := cmd.StdinPipe()
	if err != nil {
		log.Fatalf("Error getting StdinPipe for flutter run: %v", err)
	}
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr

	if err := cmd.Start(); err != nil {
		log.Fatalf("Error starting flutter run command: %v", err)
	}
	log.Println("Flutter run started. PID:", cmd.Process.Pid)

	var wg sync.WaitGroup
	wg.Add(1) // For the command's wait goroutine

	// Goroutine to wait for the flutter command to finish.
	// This prevents the main program from blocking and ensures cleanup.
	go func() {
		defer wg.Done()
		err := cmd.Wait()
		if err != nil {
			log.Printf("Flutter run command exited with error: %v", err)
		} else {
			log.Println("Flutter run command exited successfully.")
		}
		// Explicitly close stdin here if the command exits for any reason.
		// This ensures resources are released and prevents further writes.
		if stdin != nil {
			stdin.Close()
			stdin = nil // Mark as closed
			log.Println("Stdin pipe closed after command exited.")
		}
	}()

	// Channel to signal the file watcher goroutine to stop.
	stopWatcher := make(chan struct{})
	wg.Add(1) // For the file watcher goroutine
	go func() {
		defer wg.Done()
		defer log.Println("File watcher goroutine stopped.")
		for {
			select {
			case event, ok := <-watcher.Events:
				if !ok {
					return // Watcher channel closed
				}
				log.Println("event:", event)
				// Check for relevant file modification events.
				if event.Has(fsnotify.Write) || event.Has(fsnotify.Create) || event.Has(fsnotify.Remove) || event.Has(fsnotify.Rename) {
					log.Printf("Detected change in file: %s (%s)", event.Name, event.Op.String())
					if stdin != nil { // Check if stdin pipe is still open before writing.
						_, writeErr := io.WriteString(stdin, "r") // Send 'r' followed by a newline.
						if writeErr != nil {
							log.Printf("Error writing 'r' to flutter run stdin: %v. Flutter process might have terminated.", writeErr)
						} else {
							log.Println("Sent 'r' for hot reload.")
						}
					} else {
						log.Println("Stdin pipe is closed, cannot send 'r'.")
					}
				}
			case err, ok := <-watcher.Errors:
				if !ok {
					return // Watcher error channel closed
				}
				log.Println("Watcher error:", err)
			case <-stopWatcher:
				log.Println("Received stop signal for watcher.")
				return // Stop the goroutine.
			}
		}
	}()

	// Set up signal handling for graceful shutdown (e.g., Ctrl+C).
	sigCh := make(chan os.Signal, 1)
	signal.Notify(sigCh, os.Interrupt, syscall.SIGTERM) // Listen for Ctrl+C and termination signals.

	log.Println("Monitoring for file changes. Press Ctrl+C to stop.")
	<-sigCh // Block until a signal is received.
	log.Println("Received termination signal. Shutting down...")

	// Graceful shutdown sequence.
	close(stopWatcher) // Signal the watcher goroutine to stop.
	signal.Stop(sigCh) // Stop listening for signals.

	// Attempt to send a graceful shutdown signal to Flutter (SIGINT/Ctrl+C).
	// Flutter typically handles SIGINT for a clean exit.
	if cmd.Process != nil {
		log.Println("Attempting to send Ctrl+C (SIGINT) to flutter run process...")
		// On Windows, os.Interrupt is equivalent to Ctrl+C. On Unix, it's SIGINT.
		if err := cmd.Process.Signal(os.Interrupt); err != nil {
			log.Printf("Error sending interrupt signal to flutter run: %v", err)
			// If sending interrupt failed, try to kill the process.
			log.Println("Attempting to kill flutter run process...")
			cmd.Process.Kill()
		}
	}

	// Explicitly close stdin pipe here if it hasn't been closed by the cmd.Wait() goroutine yet.
	// This ensures that the flutter process receives an EOF on stdin if it's still alive.
	if stdin != nil {
		stdin.Close()
		log.Println("Explicitly closed stdin pipe during shutdown.")
	}

	// Wait for all goroutines to finish gracefully.
	done := make(chan struct{})
	go func() {
		wg.Wait()
		close(done)
	}()

	select {
	case <-done:
		log.Println("All goroutines finished.")
	case <-time.After(5 * time.Second): // Give a timeout for graceful shutdown.
		log.Println("Timeout waiting for goroutines to finish. Forcibly exiting.")
	}

	log.Println("Application stopped.")
}
