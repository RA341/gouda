package service

import (
	"fmt"
	models "github.com/RA341/gouda/models"
	"github.com/RA341/gouda/utils"
	"github.com/rs/zerolog/log"
	"gorm.io/gorm"
	"os"
	"strconv"
)

type MediaRequestService struct {
	db *gorm.DB
	ds *DownloadService
}

func NewMediaRequestService(db *gorm.DB, ds *DownloadService) *MediaRequestService {
	return &MediaRequestService{db: db, ds: ds}
}

func (srv *MediaRequestService) Search(query string) ([]*models.RequestTorrent, error) {
	log.Debug().Any("query", query).Msg("search request")

	dbQuery := srv.db.
		Order("updated_at desc").
		Offset(0).
		Limit(10)

	dbQuery = buildSearchQuery(query, dbQuery)

	var torrents []*models.RequestTorrent
	res := dbQuery.Find(&torrents)

	if res.Error != nil {
		return nil, fmt.Errorf("unable to query database %v", dbQuery.Error.Error())
	}

	log.Debug().Any("query", query).Msg("Searching media request")
	return torrents, nil
}

func (srv *MediaRequestService) List(limit, offset int) (int64, []*models.RequestTorrent, error) {
	if utils.IsDebugMode() {
		log.Debug().Int("limit", limit).Int("offset", offset).Msg("history query limits")
	}

	var torrents []*models.RequestTorrent

	resp := srv.db.
		Order("updated_at desc").
		Offset(offset).
		Limit(limit).
		Find(&torrents)
	if resp.Error != nil {
		return 0, nil, fmt.Errorf("error retrieving torrent history %v", resp.Error.Error())
	}

	count, err := srv.countRecords()
	if err != nil {
		return 0, nil, fmt.Errorf("error counting torrent history %v", err.Error())
	}

	return count, torrents, nil
}

func (srv *MediaRequestService) Delete(requestId uint) error {
	var torrent models.RequestTorrent
	result := srv.db.First(&torrent, requestId)
	if result.Error != nil {
		return result.Error
	}

	resp := srv.db.Unscoped().Delete(&torrent, torrent.ID)
	if resp.Error != nil {
		return resp.Error
	}

	err := os.Remove(torrent.TorrentFileLocation)
	if err != nil {
		return err
	}

	log.Debug().Any("media", torrent).Msg("Deleted media request")
	return nil
}

func (srv *MediaRequestService) Edit(mediaRequest *models.RequestTorrent) error {
	result := srv.db.Save(mediaRequest)
	if result.Error != nil {
		return fmt.Errorf("error editing torrent %v", result.Error.Error())
	}

	log.Debug().Any("media", mediaRequest).Msg("Editing media request")
	return nil
}

func (srv *MediaRequestService) Exists(mamID uint64) (*models.RequestTorrent, error) {
	var torrent models.RequestTorrent
	resp := srv.db.Where("mam_book_id = ?", mamID).First(&torrent)
	if resp.Error != nil {
		return nil, fmt.Errorf("error retrieving torrent %v", resp.Error.Error())
	}

	log.Debug().Msgf("Media Exists %d", mamID)
	return &torrent, nil
}

func (srv *MediaRequestService) Retry(mediaId uint64) (*models.RequestTorrent, error) {
	var torrRequest models.RequestTorrent
	resp := srv.db.First(&torrRequest, mediaId)
	if resp.Error != nil {
		return nil, fmt.Errorf("error retrieving torrent %v", resp.Error.Error())
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

func (srv *MediaRequestService) AddMedia(mediaRequest *models.RequestTorrent) error {
	log.Info().Any("torrent", mediaRequest).Msg("Received a torrent request")

	err := srv.ds.SaveTorrentReq(mediaRequest)
	if err != nil {
		log.Error().Err(err).Msg("unable to save torrent")
		return err
	}

	file, err := srv.ds.GetTorrentFileLocation(mediaRequest, true)
	if err != nil {
		return err
	}

	err = srv.ds.AddTorrent(mediaRequest, file)
	if err != nil {
		mediaRequest.Status = fmt.Sprintf("failed %s", err.Error())
		res := srv.db.Save(&mediaRequest)
		if res.Error != nil {
			log.Error().Err(err).Msgf("Failed to process torrent, and saving info to database")
		}
		return nil
	}

	log.Debug().Any("Media", mediaRequest).Msg("Adding media")
	return nil
}

func (srv *MediaRequestService) countRecords() (int64, error) {
	var count int64 = 0
	resp := srv.db.Model(&models.RequestTorrent{}).Count(&count)
	if resp.Error != nil {
		// Handle error - record not found or other DB error
		return count, resp.Error
	}
	return count, nil
}

func buildSearchQuery(search string, query *gorm.DB) *gorm.DB {
	// String fields use LIKE for partial matches
	query = query.Where("LOWER(author) LIKE LOWER(?)", "%"+search+"%").
		Or("LOWER(book) LIKE LOWER(?)", "%"+search+"%").
		Or("LOWER(series) LIKE LOWER(?)", "%"+search+"%").
		Or("LOWER(category) LIKE LOWER(?)", "%"+search+"%").
		Or("LOWER(status) LIKE LOWER(?)", "%"+search+"%").
		Or("LOWER(torrent_id) LIKE LOWER(?)", "%"+search+"%")

	// Numeric fields use exact matches
	if _, err := strconv.ParseInt(search, 10, 64); err == nil {
		query = query.
			Or("series_number = ?", search).
			Or("mam_book_id = ?", search)
	}

	return query
}
