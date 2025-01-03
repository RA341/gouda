package api

import (
	"connectrpc.com/connect"
	"context"
	"fmt"
	"github.com/RA341/gouda/download_clients"
	v1 "github.com/RA341/gouda/generated/media_requests/v1"
	models "github.com/RA341/gouda/models"
	"github.com/RA341/gouda/service"
	"github.com/rs/zerolog/log"
	"github.com/spf13/viper"
	"gorm.io/gorm"
	"os"
)

type MediaRequestService struct {
	api *Env
}

func (mrSrv *MediaRequestService) Search(_ context.Context, req *connect.Request[v1.SearchRequest]) (*connect.Response[v1.SearchResponse], error) {
	query := req.Msg.MediaQuery
	log.Debug().Any("query", query).Msg("search request")

	dbQuery := mrSrv.api.Database.
		Order("created_at desc").
		Offset(0).
		Limit(10)

	dbQuery = buildSearchQuery(models.RequestTorrent{
		FileLink:            query.FileLink,
		Author:              query.Author,
		Book:                query.Book,
		Series:              query.Series,
		SeriesNumber:        uint(query.SeriesNumber),
		Category:            query.Category,
		MAMBookID:           query.MamBookId,
		Status:              query.Status,
		TorrentId:           query.TorrentId,
		TimeRunning:         uint(query.TimeRunning),
		TorrentFileLocation: query.TorrentFileLocation,
	}, dbQuery)

	var torrents []*models.RequestTorrent
	res := dbQuery.Find(&torrents)

	if res.Error != nil {
		return nil, fmt.Errorf("unable to query database %v", dbQuery.Error.Error())
	}

	medias := convertToMedias(torrents)
	results := connect.NewResponse(&v1.SearchResponse{Results: medias})
	return results, nil
}

func (mrSrv *MediaRequestService) List(_ context.Context, req *connect.Request[v1.ListRequest]) (*connect.Response[v1.ListResponse], error) {
	limit := req.Msg.Limit
	offset := req.Msg.Offset

	log.Debug().Int("limit", int(limit)).Int("offset", int(offset)).Msg("history setup endpoints")

	var torrents []*models.RequestTorrent

	resp := mrSrv.api.Database.
		Order("created_at desc").
		Offset(int(offset)).
		Limit(int(limit)).
		Find(&torrents)

	if resp.Error != nil {
		return nil, fmt.Errorf("error retrieving torrent history %v", resp.Error.Error())
	}

	count, err := mrSrv.api.countRecords()
	if err != nil {
		return nil, fmt.Errorf("error counting torrent history %v", err.Error())
	}

	results := connect.NewResponse(&v1.ListResponse{
		TotalRecords: uint64(count),
		Results:      convertToMedias(torrents),
	})
	return results, nil
}

func (mrSrv *MediaRequestService) Delete(_ context.Context, req *connect.Request[v1.DeleteRequest]) (*connect.Response[v1.DeleteResponse], error) {
	var torrent models.RequestTorrent
	result := mrSrv.api.Database.First(&torrent, req.Msg.Media.ID)
	if result.Error != nil {
		return nil, fmt.Errorf("error getting item %v", result.Error.Error())
	}

	resp := mrSrv.api.Database.Unscoped().Delete(&models.RequestTorrent{}, req.Msg.Media.ID)
	if resp.Error != nil {
		return nil, fmt.Errorf("error deleting request %v", resp.Error.Error())
	}

	err := os.Remove(torrent.TorrentFileLocation)
	if err != nil {
		return nil, fmt.Errorf("error deleting torrent file %v", resp.Error.Error())
	}

	return connect.NewResponse(&v1.DeleteResponse{}), nil
}

func (mrSrv *MediaRequestService) Edit(_ context.Context, req *connect.Request[v1.EditRequest]) (*connect.Response[v1.EditResponse], error) {
	media := req.Msg.Media

	result := mrSrv.api.Database.Save(convertToTorrentRequest(media))
	if result.Error != nil {
		return nil, fmt.Errorf("error editing torrent %v", result.Error.Error())
	}

	return connect.NewResponse(&v1.EditResponse{}), nil
}

func (mrSrv *MediaRequestService) Exists(_ context.Context, req *connect.Request[v1.ExistsRequest]) (*connect.Response[v1.ExistsResponse], error) {
	mamID := req.Msg.MamId

	var torrent models.RequestTorrent
	resp := mrSrv.api.Database.Where("mam_book_id = ?", mamID).First(&torrent)
	if resp.Error != nil {
		return nil, fmt.Errorf("error retrieving torrent %v", resp.Error.Error())
	}

	return connect.NewResponse(&v1.ExistsResponse{Media: convertToMedia(&torrent)}), nil
}

func (mrSrv *MediaRequestService) Retry(_ context.Context, req *connect.Request[v1.RetryRequest]) (*connect.Response[v1.RetryResponse], error) {
	mediaId := req.Msg.ID

	var torrRequest models.RequestTorrent
	resp := mrSrv.api.Database.First(&torrRequest, mediaId)
	if resp.Error != nil {
		return nil, fmt.Errorf("error retrieving torrent %v", resp.Error.Error())
	}

	err := service.AddTorrent((*models.Env)(mrSrv.api), &torrRequest, false)
	if err != nil {
		return nil, fmt.Errorf("error retrying torrent %v", err.Error())
	}

	return connect.NewResponse(&v1.RetryResponse{
		Media: convertToMedia(&torrRequest),
	}), nil
}

func (mrSrv *MediaRequestService) AddMedia(_ context.Context, req *connect.Request[v1.AddMediaRequest]) (*connect.Response[v1.AddMediaResponse], error) {
	if mrSrv.api.DownloadClient == nil {
		client, err := download_clients.InitializeTorrentClient(models.TorrentClient{
			User:     viper.GetString("torrent_client.user"),
			Password: viper.GetString("torrent_client.password"),
			Protocol: viper.GetString("torrent_client.protocol"),
			Host:     viper.GetString("torrent_client.host"),
			Type:     viper.GetString("torrent_client.name"),
		})
		if err != nil {
			return nil, fmt.Errorf("unable to connect to download client %v", err.Error())
		}
		mrSrv.api.DownloadClient = client
	}

	var torrent models.RequestTorrent
	err := service.SaveTorrentReq(mrSrv.api.Database, &torrent)
	if err != nil {
		return nil, fmt.Errorf("unable to save torrent to DB %v", err.Error())
	}

	err = service.AddTorrent((*models.Env)(mrSrv.api), &torrent, true)
	if err != nil {
		torrent.Status = fmt.Sprintf("failed %s", err.Error())
		res := mrSrv.api.Database.Save(&req)
		if res.Error != nil {
			log.Error().Err(err).Msgf("Failed to process torrent, and saving info to database")
		}

		return nil, fmt.Errorf("error adding torrent to DB %v", err.Error())
	}

	return connect.NewResponse(&v1.AddMediaResponse{}), nil
}

func buildSearchQuery(search models.RequestTorrent, query *gorm.DB) *gorm.DB {
	// String fields use LIKE for partial matches
	if search.Author != "" {
		query = query.Where("LOWER(author) LIKE LOWER(?)", "%"+search.Author+"%")
	}
	if search.Book != "" {
		query = query.Where("LOWER(book) LIKE LOWER(?)", "%"+search.Book+"%")
	}
	if search.Series != "" {
		query = query.Where("LOWER(series) LIKE LOWER(?)", "%"+search.Series+"%")
	}
	if search.Category != "" {
		query = query.Where("LOWER(category) LIKE LOWER(?)", "%"+search.Category+"%")
	}
	if search.Status != "" {
		query = query.Where("LOWER(status) LIKE LOWER(?)", "%"+search.Status+"%")
	}
	if search.TorrentId != "" {
		query = query.Where("LOWER(torrent_id) LIKE LOWER(?)", "%"+search.TorrentId+"%")
	}

	// Numeric fields use exact matches
	if search.SeriesNumber != 0 {
		query = query.Where("series_number = ?", search.SeriesNumber)
	}
	if search.MAMBookID != 0 {
		query = query.Where("mam_book_id = ?", search.MAMBookID)
	}

	return query
}

func (api *Env) countRecords() (int64, error) {
	var count int64 = 0
	resp := api.Database.Model(&models.RequestTorrent{}).Count(&count)
	if resp.Error != nil {
		// Handle error - record not found or other DB error
		return count, resp.Error
	}
	return count, nil
}

func convertToMedias(requests []*models.RequestTorrent) []*v1.Media {
	var medias []*v1.Media

	for _, torrent := range requests {
		medias = append(medias, convertToMedia(torrent))
	}

	return medias
}

func convertToMedia(torrent *models.RequestTorrent) *v1.Media {
	return &v1.Media{
		ID:                  uint64(torrent.ID),
		Author:              torrent.Author,
		Book:                torrent.Book,
		Series:              torrent.Series,
		SeriesNumber:        uint32(torrent.SeriesNumber),
		Category:            torrent.Category,
		MamBookId:           torrent.MAMBookID,
		FileLink:            torrent.FileLink,
		Status:              torrent.Status,
		TorrentId:           torrent.TorrentId,
		TimeRunning:         uint32(torrent.TimeRunning),
		TorrentFileLocation: torrent.TorrentFileLocation,
	}
}

func convertToTorrentRequest(media *v1.Media) *models.RequestTorrent {
	return &models.RequestTorrent{
		Model:               gorm.Model{ID: uint(media.ID)},
		FileLink:            media.FileLink,
		Author:              media.Author,
		Book:                media.Book,
		Series:              media.Series,
		SeriesNumber:        uint(media.SeriesNumber),
		Category:            media.Category,
		MAMBookID:           media.MamBookId,
		Status:              media.Status,
		TorrentId:           media.TorrentId,
		TimeRunning:         uint(media.TimeRunning),
		TorrentFileLocation: media.TorrentFileLocation,
	}
}
