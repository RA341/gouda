package mam

import (
	"connectrpc.com/connect"
	"context"
	"fmt"
	v1 "github.com/RA341/gouda/generated/mam/v1"
)

type Handler struct {
	srv *Service
}

func NewHandler(srv *Service) *Handler {
	return &Handler{srv: srv}
}

func (h Handler) Search(_ context.Context, req *connect.Request[v1.Query]) (*connect.Response[v1.SearchResults], error) {
	search, found, total, err := h.srv.SearchRaw([]byte(req.Msg.Query))
	if err != nil {
		return nil, err
	}

	var results []*v1.Book
	for _, se := range search {
		results = append(results, BookToProto(&se))
	}

	return connect.NewResponse(&v1.SearchResults{
		Results: results,
		Found:   int32(found),
		Total:   int32(total),
	}), nil
}

func (h Handler) BuyVip(_ context.Context, req *connect.Request[v1.VipRequest]) (*connect.Response[v1.VipResponse], error) {
	vip, err := h.srv.BuyVIP(uint(req.Msg.AmountInWeeks))
	if err != nil {
		return nil, fmt.Errorf("error buying VIP: %v", err)
	}

	return connect.NewResponse(VipToProto(vip)), nil
}

func (h Handler) BuyBonus(_ context.Context, req *connect.Request[v1.BonusRequest]) (*connect.Response[v1.BonusResponse], error) {
	bonus, err := h.srv.BuyBonus(uint(req.Msg.AmountInGB))
	if err != nil {
		return nil, fmt.Errorf("error buying bonus: %v", err)
	}

	return connect.NewResponse(BonusToProto(bonus)), nil
}

func VipToProto(vip *BuyVIPResponse) *v1.VipResponse {
	return &v1.VipResponse{
		Success:   vip.Success,
		Type:      vip.Type,
		Amount:    float32(vip.Amount),
		SeedBonus: float32(vip.SeedBonus),
	}
}

func BonusToProto(bonus *BuyBonusResponse) *v1.BonusResponse {
	return &v1.BonusResponse{
		Success:       bonus.Success,
		Type:          bonus.Type,
		Amount:        float32(bonus.Amount),
		Seedbonus:     float32(bonus.Seedbonus),
		Uploaded:      bonus.Uploaded,
		Downloaded:    bonus.Downloaded,
		UploadFancy:   bonus.UploadFancy,
		DownloadFancy: bonus.DownloadFancy,
		Ratio:         float32(bonus.Ratio),
	}
}

func BookToProto(b *Book) *v1.Book {
	return &v1.Book{
		Id:          b.ID,
		Title:       b.Title,
		Author:      b.Author,
		Format:      b.Format,
		Length:      b.Length,
		TorrentLink: b.TorrentLink,
		Category:    int32(b.Category),
		Thumbnail:   b.Thumbnail,
		Size:        b.Size,
		Seeders:     int32(b.Seeders),
		Leechers:    int32(b.Leechers),
		Added:       b.Added,
		Tags:        b.Tags,
		Completed:   int32(b.Completed),
	}
}
