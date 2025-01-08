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
	"gorm.io/gorm"
	"os"
	"strconv"
)

type MediaRequestService struct {
	api *Env
}

func (mrSrv *MediaRequestService) Search(_ context.Context, req *connect.Request[v1.SearchRequest]) (*connect.Response[v1.SearchResponse], error) {
	query := req.Msg.MediaQuery
	log.Debug().Any("query", query).Msg("search request")

	dbQuery := mrSrv.api.Database.
		Order("updated_at desc").
		Offset(0).
		Limit(10)

	dbQuery = buildSearchQuery(query, dbQuery)

	var torrents []*models.RequestTorrent
	res := dbQuery.Find(&torrents)

	if res.Error != nil {
		return nil, fmt.Errorf("unable to query database %v", dbQuery.Error.Error())
	}

	medias := convertToMedias(torrents)

	log.Debug().Any("query", query).Msg("Searching media request")

	return connect.NewResponse(&v1.SearchResponse{Results: medias}), nil
}

func (mrSrv *MediaRequestService) List(_ context.Context, req *connect.Request[v1.ListRequest]) (*connect.Response[v1.ListResponse], error) {
	limit := req.Msg.Limit
	offset := req.Msg.Offset

	if service.GetCachedDebugEnv() == "true" {
		log.Debug().Int("limit", int(limit)).Int("offset", int(offset)).Msg("history query limits")
	}

	var torrents []*models.RequestTorrent

	resp := mrSrv.api.Database.
		Order("updated_at desc").
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
	result := mrSrv.api.Database.First(&torrent, req.Msg.RequestId)
	if result.Error != nil {
		return nil, fmt.Errorf("error getting item %v", result.Error.Error())
	}

	resp := mrSrv.api.Database.Unscoped().Delete(&torrent, torrent.ID)
	if resp.Error != nil {
		return nil, fmt.Errorf("error deleting request %v", resp.Error.Error())
	}

	err := os.Remove(torrent.TorrentFileLocation)
	if err != nil {
		return nil, fmt.Errorf("error deleting torrent file %v", resp.Error.Error())
	}

	log.Debug().Any("media", torrent).Msg("Deleted media request")

	return connect.NewResponse(&v1.DeleteResponse{}), nil
}

func (mrSrv *MediaRequestService) Edit(_ context.Context, req *connect.Request[v1.EditRequest]) (*connect.Response[v1.EditResponse], error) {
	media := req.Msg.Media
	mediaRequest := (&models.RequestTorrent{}).FromProto(media)

	result := mrSrv.api.Database.Save(mediaRequest)
	if result.Error != nil {
		return nil, fmt.Errorf("error editing torrent %v", result.Error.Error())
	}

	log.Debug().Any("media", mediaRequest).Msg("Editing media request")

	return connect.NewResponse(&v1.EditResponse{}), nil
}

func (mrSrv *MediaRequestService) Exists(_ context.Context, req *connect.Request[v1.ExistsRequest]) (*connect.Response[v1.ExistsResponse], error) {
	mamID := req.Msg.MamId

	var torrent models.RequestTorrent
	resp := mrSrv.api.Database.Where("mam_book_id = ?", mamID).First(&torrent)
	if resp.Error != nil {
		return nil, fmt.Errorf("error retrieving torrent %v", resp.Error.Error())
	}

	log.Debug().Msgf("Media Exists %d", mamID)

	return connect.NewResponse(&v1.ExistsResponse{Media: torrent.ToProto()}), nil
}

func (mrSrv *MediaRequestService) Retry(_ context.Context, req *connect.Request[v1.RetryRequest]) (*connect.Response[v1.RetryResponse], error) {
	mediaId := req.Msg.ID

	var torrRequest models.RequestTorrent
	resp := mrSrv.api.Database.First(&torrRequest, mediaId)
	if resp.Error != nil {
		return nil, fmt.Errorf("error retrieving torrent %v", resp.Error.Error())
	}

	file, err := service.GetTorrentFileLocation(&torrRequest, false)
	if err != nil {
		return nil, fmt.Errorf("unable to get torrent file location\n\n%v", err.Error())
	}

	err = service.AddTorrent((*models.Env)(mrSrv.api), &torrRequest, file)
	if err != nil {
		return nil, fmt.Errorf("error retrying torrent %v", err.Error())
	}

	log.Debug().Any("Media", torrRequest).Msg("Retrying message")

	return connect.NewResponse(&v1.RetryResponse{
		Media: torrRequest.ToProto(),
	}), nil
}

func (mrSrv *MediaRequestService) AddMedia(_ context.Context, req *connect.Request[v1.AddMediaRequest]) (*connect.Response[v1.AddMediaResponse], error) {
	if mrSrv.api.DownloadClient == nil {
		client, err := download_clients.InitializeTorrentClient()
		log.Error().Err(err).Msg("torrent client is uninitialized")
		if err != nil {
			return nil, fmt.Errorf("unable to connect to download client\n\n%v", err.Error())
		}
		mrSrv.api.DownloadClient = client
	}

	mediaRequest := (&models.RequestTorrent{}).FromProto(req.Msg.GetMedia())
	log.Info().Any("torrent", mediaRequest).Msg("Received a torrent request")

	err := service.SaveTorrentReq(mrSrv.api.Database, mediaRequest)
	if err != nil {
		log.Error().Err(err).Msg("unable to save torrent")
		return nil, fmt.Errorf("unable to save torrent to DB\n\n%v", err.Error())
	}

	file, err := service.GetTorrentFileLocation(mediaRequest, true)
	if err != nil {
		return nil, fmt.Errorf("unable to get torrent file location\n\n%v", err.Error())
	}

	err = service.AddTorrent((*models.Env)(mrSrv.api), mediaRequest, file)
	if err != nil {
		mediaRequest.Status = fmt.Sprintf("failed %s", err.Error())
		res := mrSrv.api.Database.Save(&req)
		if res.Error != nil {
			log.Error().Err(err).Msgf("Failed to process torrent, and saving info to database")
		}

		return nil, fmt.Errorf("error adding torrent to DB %v", err.Error())
	}

	log.Debug().Any("Media", mediaRequest).Msg("Adding media")

	return connect.NewResponse(&v1.AddMediaResponse{}), nil
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
		medias = append(medias, torrent.ToProto())
	}

	return medias
}
