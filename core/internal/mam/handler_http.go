package mam

import (
	"net/http"
	"path/filepath"

	"github.com/rs/zerolog/log"
)

type HandlerHttp struct {
	srv *Service
}

func NewHttpHandler(service *Service) http.Handler {
	hand := &HandlerHttp{srv: service}
	return hand.register()
}

func (h *HandlerHttp) register() http.Handler {
	subMux := http.NewServeMux()
	subMux.HandleFunc("GET /thumb/{rawthumb}", h.GetThumbnail)
	return subMux
}

func (h *HandlerHttp) GetThumbnail(w http.ResponseWriter, r *http.Request) {
	fileName := r.PathValue("rawthumb")
	if fileName == "" {
		http.Error(w, "thumbnail not provided", http.StatusNotFound)
		return
	}
	cleanPath := filepath.Clean(fileName)

	imgData, err := h.srv.getThumbnail(cleanPath)
	if err != nil {
		log.Error().Err(err).Str("path", cleanPath).Msg("Error loading file")
		http.Error(w, "Filename not found", http.StatusBadRequest)
		return
	}

	_, err = w.Write(imgData)
	if err != nil {
		log.Warn().Err(err).Str("path", cleanPath).Msg("Error writing thumbnail response")
		http.Error(w, "Error writing image", http.StatusInternalServerError)
		return
	}
}
