package media_manager

import (
	"connectrpc.com/connect"
	"context"
	v1 "github.com/RA341/gouda/generated/media_requests/v1"
	"github.com/RA341/gouda/internal/downloads"
	"github.com/rs/zerolog/log"
)

type MediaManagerHandler struct {
	mr *MediaManagerService
}

func NewMediaManagerHandler(mr *MediaManagerService) *MediaManagerHandler {
	return &MediaManagerHandler{mr}
}

func (handler *MediaManagerHandler) AddMedia(_ context.Context, req *connect.Request[v1.AddMediaRequest]) (*connect.Response[v1.AddMediaResponse], error) {
	var mediaRequest downloads.Media
	mediaRequest.FromProto(req.Msg.GetMedia())
	log.Info().Any("torrent", mediaRequest).Msg("Received a torrent request")

	err := handler.mr.AddMedia(&mediaRequest)
	if err != nil {
		return nil, err
	}

	return connect.NewResponse(&v1.AddMediaResponse{}), nil
}

func (handler *MediaManagerHandler) AddMediaWithFreeleech(ctx context.Context, c *connect.Request[v1.AddMediaRequest]) (*connect.Response[v1.AddMediaResponse], error) {
	//TODO implement me
	panic("implement me")
}

func (handler *MediaManagerHandler) Search(_ context.Context, req *connect.Request[v1.SearchRequest]) (*connect.Response[v1.SearchResponse], error) {
	query := req.Msg.MediaQuery
	results, err := handler.mr.Search(query)
	if err != nil {
		return nil, err
	}

	medias := convertToGRPCMedia(results)
	return connect.NewResponse(&v1.SearchResponse{Results: medias}), nil
}

func (handler *MediaManagerHandler) List(_ context.Context, req *connect.Request[v1.ListRequest]) (*connect.Response[v1.ListResponse], error) {
	limit := req.Msg.Limit
	offset := req.Msg.Offset
	totalCount, results, err := handler.mr.List(int(limit), int(offset))
	if err != nil {
		return nil, err
	}

	return connect.NewResponse(&v1.ListResponse{
		TotalRecords: uint64(totalCount),
		Results:      convertToGRPCMedia(results),
	}), nil
}

func (handler *MediaManagerHandler) Delete(_ context.Context, req *connect.Request[v1.DeleteRequest]) (*connect.Response[v1.DeleteResponse], error) {
	err := handler.mr.Delete(uint(req.Msg.RequestId))
	if err != nil {
		return nil, err
	}
	return connect.NewResponse(&v1.DeleteResponse{}), nil
}

func (handler *MediaManagerHandler) Edit(_ context.Context, req *connect.Request[v1.EditRequest]) (*connect.Response[v1.EditResponse], error) {
	media := req.Msg.Media
	var mediaRequest downloads.Media
	mediaRequest.FromProto(media)

	err := handler.mr.Edit(&mediaRequest)
	if err != nil {
		return nil, err
	}

	return connect.NewResponse(&v1.EditResponse{}), nil
}

func (handler *MediaManagerHandler) Exists(_ context.Context, req *connect.Request[v1.ExistsRequest]) (*connect.Response[v1.ExistsResponse], error) {
	mamID := req.Msg.MamId
	exists, err := handler.mr.Exists(mamID)
	if err != nil {
		return nil, err
	}
	return connect.NewResponse(&v1.ExistsResponse{Media: exists.ToProto()}), nil
}

func (handler *MediaManagerHandler) Retry(_ context.Context, req *connect.Request[v1.RetryRequest]) (*connect.Response[v1.RetryResponse], error) {
	mediaId := req.Msg.ID
	retry, err := handler.mr.Retry(mediaId)
	if err != nil {
		return nil, err
	}

	return connect.NewResponse(&v1.RetryResponse{
		Media: retry.ToProto(),
	}), nil
}

func convertToGRPCMedia(requests []downloads.Media) []*v1.Media {
	var medias []*v1.Media

	for _, torrent := range requests {
		medias = append(medias, torrent.ToProto())
	}

	return medias
}
