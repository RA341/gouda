package downloads

import (
	v1 "github.com/RA341/gouda/generated/media_requests/v1"
	"gorm.io/gorm"
	"time"
)

type Media struct {
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
	TorrentFileLocation string `json:"torrent_file_loc,omitempty"`
}

func (r *Media) ToProto() *v1.Media {
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
		TorrentFileLocation: r.TorrentFileLocation,
		CreatedAt:           r.CreatedAt.Format(time.RFC3339),
		UpdatedAt:           r.UpdatedAt.Format(time.RFC3339),
	}
}

func (r *Media) FromProto(proto *v1.Media) {
	r.FileLink = proto.FileLink
	r.Author = proto.Author
	r.Book = proto.Book
	r.Series = proto.Series
	r.SeriesNumber = uint(proto.SeriesNumber)
	r.Category = proto.Category
	r.MAMBookID = proto.MamBookId
	r.Status = proto.Status
	r.TorrentId = proto.TorrentId
	r.TorrentFileLocation = proto.TorrentFileLocation
}
