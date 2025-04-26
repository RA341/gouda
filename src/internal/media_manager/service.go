package media_manager

import (
	"fmt"
	"github.com/RA341/gouda/internal/downloads"
	"github.com/RA341/gouda/pkg"
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

func (srv *MediaManagerService) Search(query string) ([]*downloads.Media, error) {
	log.Debug().Any("query", query).Msg("search request")

	var torrents []*downloads.Media
	err := srv.db.Search(query, torrents)
	if err != nil {
		return nil, err
	}

	log.Debug().Any("query", query).Msg("Searching media request")
	return torrents, nil
}

func (srv *MediaManagerService) List(limit, offset int) (int64, []*downloads.Media, error) {
	if pkg.IsDebugMode() {
		log.Debug().Int("limit", limit).Int("offset", offset).Msg("history query limits")
	}

	var torrents []*downloads.Media
	err := srv.db.ListMedia(offset, limit, torrents)
	if err != nil {
		return 0, nil, err
	}

	count, err := srv.db.CountAllMedia()
	if err != nil {
		return 0, nil, fmt.Errorf("error counting torrent history %v", err.Error())
	}

	return count, torrents, nil
}

func (srv *MediaManagerService) Delete(requestId uint) error {
	var media downloads.Media
	err := srv.db.Get(requestId, &media)
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
	var torrent downloads.Media
	_, err := srv.db.Exists(mamID, &torrent)
	if err != nil {
		return nil, err
	}

	log.Debug().Msgf("Media Exists %d", mamID)
	return &torrent, nil
}

func (srv *MediaManagerService) Retry(mediaId uint64) (*downloads.Media, error) {
	var torrRequest downloads.Media
	err := srv.db.Retry(mediaId, &torrRequest)
	if err != nil {
		return nil, err
	}

	file, err := srv.ds.GetTorrentFileLocation(&torrRequest, false)
	if err != nil {
		return nil, fmt.Errorf("unable to get torrent file location\n\n%v", err.Error())
	}

	err = srv.ds.AddTorrent(&torrRequest, file)
	if err != nil {
		return nil, fmt.Errorf("error retrying torrent %v", err.Error())
	}

	log.Debug().Any("Media", torrRequest).Msg("Retrying message")

	return &torrRequest, nil
}

func (srv *MediaManagerService) AddMedia(mediaRequest *downloads.Media) error {
	log.Info().Any("torrent", mediaRequest).Msg("Received a torrent request")

	file, err := srv.ds.GetTorrentFileLocation(mediaRequest, true)
	if err != nil {
		return err
	}

	err = srv.ds.AddTorrent(mediaRequest, file)
	if err != nil {
		mediaRequest.Status = fmt.Sprintf("failed %s", err.Error())
		err = srv.db.Edit(mediaRequest)
		if err != nil {
			log.Error().Err(err).Msgf("Failed to process torrent, and saving info to database")
			return err
		}
	}

	log.Debug().Any("Media", mediaRequest).Msg("Adding media")
	return nil
}
