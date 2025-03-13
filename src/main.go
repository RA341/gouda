package main

import (
	connectcors "connectrpc.com/cors"
	"embed"
	"fmt"
	grpc "github.com/RA341/gouda/grpc"
	"github.com/RA341/gouda/utils"
	"github.com/rs/cors"
	"github.com/rs/zerolog/log"
	"golang.org/x/net/http2"
	"golang.org/x/net/http2/h2c"
	"io/fs"
	"net/http"
	"os"
	"path/filepath"
)

//go:embed web
var frontendDir embed.FS

func main() {
	utils.InitConsoleLogger()
	utils.InitConfig()

	log.Info().
		Str("flavour", utils.BinaryType).
		Str("version", utils.Version).
		Str("binary_path", filepath.Base(os.Args[0])).
		Msgf("gouda initialized successfully")

	if utils.IsDesktopMode() {
		log.Info().Msgf("running in desktop mode")
		// server as routine
		go func() {
			if err := startServer(); err != nil {
				log.Fatal().Err(err).Msgf("Failed to start server")
			}
		}()
		// systray will run indefinitely
		InitSystray()
	} else {
		log.Info().Msgf("running in server mode")
		if err := startServer(); err != nil {
			log.Fatal().Err(err).Msgf("Failed to start server")
		}
	}
}

func startServer() error {
	grpcRouter := grpc.SetupGRPCEndpoints()
	// serve frontend dir
	log.Info().Msgf("Setting up ui files")
	grpcRouter.Handle("/", getFrontendDir())

	baseUrl := fmt.Sprintf(":%s", utils.ServerPort.GetStr())
	log.Info().Str("Listening on:", baseUrl).Msg("")

	middleware := cors.New(cors.Options{
		AllowedOrigins:      []string{"*"},
		AllowPrivateNetwork: true,
		AllowedMethods:      connectcors.AllowedMethods(),
		AllowedHeaders:      append(connectcors.AllowedHeaders(), "Authorization"),
		ExposedHeaders:      connectcors.ExposedHeaders(),
	})

	// Use h2c to serve HTTP/2 without TLS
	return http.ListenAndServe(
		baseUrl,
		middleware.Handler(h2c.NewHandler(grpcRouter, &http2.Server{})),
	)
}

func getFrontendDir() http.Handler {
	subFS, err := fs.Sub(frontendDir, "web")
	if err != nil {
		log.Fatal().Err(err).Msgf("Failed to load frontend directory")
	}
	return http.FileServer(http.FS(subFS))
}
