package mam

import (
	"context"
	"encoding/json"
	"fmt"

	"connectrpc.com/connect"
	v1 "github.com/RA341/gouda/generated/mam/v1"
)

type Handler struct {
	srv *Service
}

func NewHandler(srv *Service) *Handler {
	return &Handler{srv: srv}
}

func (h *Handler) Search(_ context.Context, req *connect.Request[v1.Query]) (*connect.Response[v1.SearchResults], error) {
	var searchQuery map[string]any
	err := json.Unmarshal([]byte(req.Msg.Query), &searchQuery)
	if err != nil {
		return nil, fmt.Errorf("error unmarshalling search query: %v", err)
	}

	results, found, onPage, err := h.srv.SearchRaw(searchQuery)
	if err != nil {
		return nil, err
	}

	var response []*v1.SearchBook
	for _, item := range results {
		response = append(response, BookToProto(&item))
	}

	return connect.NewResponse(&v1.SearchResults{
		Results: response,
		Found:   int32(onPage),
		Total:   int32(found),
	}), nil
}

func (h *Handler) GetProfile(_ context.Context, _ *connect.Request[v1.Empty]) (*connect.Response[v1.UserData], error) {
	profile, err := h.srv.GetProfile()
	if err != nil {
		return nil, fmt.Errorf("unable to get profile: %w", err)
	}

	udata := ToProto(profile)
	return connect.NewResponse(udata), nil
}

func (h *Handler) GetBonusHistory(_ context.Context, _ *connect.Request[v1.Empty]) (*connect.Response[v1.UserData], error) {
	profile, err := h.srv.GetProfile()
	if err != nil {
		return nil, fmt.Errorf("unable to get profile: %w", err)
	}

	udata := ToProto(profile)
	return connect.NewResponse(udata), nil
}

func (h *Handler) BuyVip(_ context.Context, req *connect.Request[v1.VipRequest]) (*connect.Response[v1.VipResponse], error) {
	vip, err := h.srv.BuyVIP(uint(req.Msg.AmountInWeeks))
	if err != nil {
		return nil, fmt.Errorf("error buying VIP: %v", err)
	}

	return connect.NewResponse(VipToProto(vip)), nil
}

func (h *Handler) BuyBonus(_ context.Context, req *connect.Request[v1.BonusRequest]) (*connect.Response[v1.BonusResponse], error) {
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

func BookToProto(book *SearchBook) *v1.SearchBook {
	if book == nil {
		return nil
	}

	authors := make([]*v1.Author, len(book.Author))
	for i, author := range book.Author {
		authors[i] = &v1.Author{
			Id:   author.ID,
			Name: author.Name,
		}
	}

	narrators := make([]*v1.Author, len(book.Narrator))
	for i, narrator := range book.Narrator {
		narrators[i] = &v1.Author{
			Id:   narrator.ID,
			Name: narrator.Name,
		}
	}

	series := make([]*v1.Series, len(book.Series))
	for i, s := range book.Series {
		series[i] = &v1.Series{
			Id:             s.ID,
			Name:           s.Name,
			SequenceNumber: s.SequenceNumber,
		}
	}

	return &v1.SearchBook{
		MamId:         int32(book.MamID),
		Title:         book.Title,
		Thumbnail:     book.Thumbnail,
		Author:        authors,
		Description:   book.Description,
		Narrator:      narrators,
		UploaderName:  book.UploaderName,
		Series:        series,
		Tags:          book.Tags,
		DateAddedIso:  book.DateAddedIso,
		Snatched:      book.Snatched,
		LanguageCode:  book.LanguageCode,
		MediaCategory: book.MediaCategory,
		CategoryId:    int32(book.CategoryID),
		CategoryName:  book.CategoryName,
		MediaFormat:   book.MediaFormat,
		MediaSize:     book.MediaSize,
		Seeders:       int32(book.Seeders),
		Leechers:      int32(book.Leechers),
		Completed:     int32(book.Completed),
		TorrentLink:   book.TorrentLink,
	}
}
func ToProto(u *UserData) *v1.UserData {
	return &v1.UserData{
		Classname:       u.Classname,
		CountryCode:     u.CountryCode,
		CountryName:     u.CountryName,
		Downloaded:      u.Downloaded,
		DownloadedBytes: u.DownloadedBytes,
		Ratio:           u.Ratio,
		Seedbonus:       int32(u.Seedbonus),
		Uid:             int32(u.Uid),
		Uploaded:        u.Uploaded,
		UploadedBytes:   u.UploadedBytes,
		Username:        u.Username,
		VipUntil:        u.VipUntil,
	}
}
