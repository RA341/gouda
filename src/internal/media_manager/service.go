package media_manager

import (
	"fmt"
	"github.com/RA341/gouda/internal/config"
	"github.com/RA341/gouda/internal/downloads"
	"github.com/rs/zerolog/log"
	"os"
)

type MediaManagerService struct {
	db Store
	ds *downloads.DownloadService
}

func NewMediaManagerService(db Store, ds *downloads.DownloadService) *MediaManagerService {
	return &MediaManagerService{db: db, ds: ds}
}

func (srv *MediaManagerService) AddMedia(mediaRequest *downloads.Media) error {
	log.Info().Any("torrent", mediaRequest).Msg("Received a torrent request")

	err := srv.ds.DownloadMedia(mediaRequest, true)
	if err != nil {
		mediaRequest.Status = downloads.Error
		mediaRequest.ErrorMessage = err.Error()
		err = srv.db.Edit(mediaRequest)
		if err != nil {
			log.Error().Err(err).Msgf("Failed to process torrent, and saving info to database")
			return err
		}
	}

	log.Debug().Any("Media", mediaRequest).Msg("Adding media")
	return nil
}

func (srv *MediaManagerService) List(limit, offset int) (int64, []downloads.Media, error) {
	if config.IsDebugMode() {
		log.Debug().Int("limit", limit).Int("offset", offset).Msg("history query limits")
	}

	torrents, err := srv.db.ListMedia(offset, limit)
	if err != nil {
		return 0, nil, err
	}

	count, err := srv.db.CountAllMedia()
	if err != nil {
		return 0, nil, fmt.Errorf("error counting torrent history %v", err.Error())
	}

	return count, torrents, nil
}

func (srv *MediaManagerService) Search(query string) ([]downloads.Media, error) {
	log.Debug().Any("query", query).Msg("search request")

	results, err := srv.db.Search(query)
	if err != nil {
		return nil, err
	}

	log.Debug().Any("query", query).Msg("Searching media request")
	return results, nil
}

func (srv *MediaManagerService) Delete(requestId uint) error {
	media, err := srv.db.Get(requestId)
	if err != nil {
		return err
	}

	err = srv.db.DeleteMedia(requestId)
	if err != nil {
		return err
	}

	err = os.Remove(media.TorrentFileLocation)
	if err != nil {
		return err
	}

	log.Debug().Any("media", media).Msg("Deleted media request")
	return nil
}

func (srv *MediaManagerService) Edit(mediaRequest *downloads.Media) error {
	err := srv.db.Edit(mediaRequest)
	if err != nil {
		return err
	}

	log.Debug().Any("media", mediaRequest).Msg("Editing media request")
	return nil
}

func (srv *MediaManagerService) Exists(mamID uint64) (*downloads.Media, error) {
	torrent, _, err := srv.db.Exists(mamID)
	if err != nil {
		return nil, err
	}

	log.Debug().Msgf("Media Exists %d", mamID)
	return torrent, nil
}

func (srv *MediaManagerService) Retry(mediaId uint64) (*downloads.Media, error) {
	media, err := srv.db.Get(uint(mediaId))
	if err != nil {
		return nil, err
	}

	err = srv.ds.DownloadMedia(media, false)
	if err != nil {
		return nil, fmt.Errorf("error retrying torrent %v", err.Error())
	}

	log.Debug().Any("Media", media).Msg("Retrying media")

	return media, nil
}
