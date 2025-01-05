package types

import (
	v1 "github.com/RA341/gouda/generated/media_requests/v1"
	"gorm.io/gorm"
	"time"
)

type TorrentClient struct {
	User     string `json:"user"`
	Password string `json:"password"`
	Protocol string `json:"protocol"`
	Host     string `json:"host"`
	Type     string `json:"type"`
}

type RequestTorrent struct {
	gorm.Model
	FileLink            string `json:"file_link" gorm:"-"`
	Author              string `json:"author"`
	Book                string `json:"book"`
	Series              string `json:"series"`
	SeriesNumber        uint   `json:"series_number"`
	Category            string `json:"category"`
	MAMBookID           uint64 `json:"mam_book_id" gorm:"uniqueIndex;check:mam_book_id > 0"`
	Status              string `json:"status,omitempty"`
	TorrentId           string `json:"torrent_id,omitempty"`
	TimeRunning         uint   `json:"time_running,omitempty"`
	TorrentFileLocation string `json:"torrent_file_loc,omitempty"`
}

func (r *RequestTorrent) ToProto() *v1.Media {
	return &v1.Media{
		ID:                  uint64(r.ID),
		Author:              r.Author,
		Book:                r.Book,
		Series:              r.Series,
		SeriesNumber:        uint32(r.SeriesNumber),
		Category:            r.Category,
		MamBookId:           r.MAMBookID,
		FileLink:            r.FileLink,
		Status:              r.Status,
		TorrentId:           r.TorrentId,
		TimeRunning:         uint32(r.TimeRunning),
		TorrentFileLocation: r.TorrentFileLocation,
		CreatedAt:           r.UpdatedAt.Format(time.RFC3339),
	}
}

func (r *RequestTorrent) FromProto(proto *v1.Media) *RequestTorrent {
	return &RequestTorrent{
		Model:               gorm.Model{ID: r.ID},
		FileLink:            proto.FileLink,
		Author:              proto.Author,
		Book:                proto.Book,
		Series:              proto.Series,
		SeriesNumber:        uint(proto.SeriesNumber),
		Category:            proto.Category,
		MAMBookID:           proto.MamBookId,
		Status:              proto.Status,
		TorrentId:           proto.TorrentId,
		TimeRunning:         uint(proto.TimeRunning),
		TorrentFileLocation: proto.TorrentFileLocation,
	}
}
