package media_manager

import (
	"fmt"
	"strconv"

	"github.com/RA341/gouda/internal/downloads"
	"github.com/RA341/gouda/internal/info"
	"github.com/RA341/gouda/internal/mam"
	"github.com/rs/zerolog/log"
)

type MediaManagerService struct {
	db  Store
	ds  *downloads.Service
	mam *mam.Service
}

func NewService(
	db Store,
	ds *downloads.Service,
	mam *mam.Service,
) *MediaManagerService {
	return &MediaManagerService{
		db:  db,
		ds:  ds,
		mam: mam,
	}
}

func (srv *MediaManagerService) AddMedia(mediaRequest *downloads.Media, withFreeleech bool) error {
	log.Info().Any("torrent", mediaRequest).Msg("Received a torrent request")

	if withFreeleech {
		freeleech, err := srv.mam.UseFreeleech(strconv.Itoa(int(mediaRequest.MAMBookID)), mam.FreeLeechPersonal)
		if err != nil {
			return fmt.Errorf("failed to buy free leech to media manager: %v", err)
		}

		log.Debug().Any("leech-response", freeleech).Msg("Adding download with free leech to downloader")
	}

	err := srv.ds.DownloadMedia(mediaRequest)
	if err == nil {
		log.Debug().Any("Media", mediaRequest).Msg("Adding media")
		return nil
	}

	mediaRequest.MarkError(err)
	err = srv.db.Edit(mediaRequest)
	if err != nil {
		log.Error().Err(err).Msgf("Failed to process torrent, and saving info to database")
		return err
	}

	return nil
}

func (srv *MediaManagerService) List(limit, offset int) (int64, []downloads.Media, error) {
	if info.IsDev() {
		//log.Debug().Int("limit", limit).Int("offset", offset).Msg("history query limits")
	}

	if limit == 0 {
		limit = 20
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

	err = srv.ds.DownloadMedia(media)
	if err != nil {
		return nil, fmt.Errorf("error retrying torrent %v", err.Error())
	}

	log.Debug().Any("Media", media).Msg("Retrying media")

	return media, nil
}
