package downloads

import (
	v1 "github.com/RA341/gouda/generated/media_requests/v1"
	"gorm.io/gorm"
	"time"
)

type MediaStatus string

const (
	Downloading = "downloading"
	Complete    = "completed"
	Error       = "error"
)

type Media struct {
	gorm.Model
	FileLink            string `gorm:"-"`
	Author              string
	Book                string
	Series              string
	SeriesNumber        uint
	Category            string
	MAMBookID           uint64 `gorm:"uniqueIndex;check:mam_book_id > 0"`
	Status              MediaStatus
	ErrorMessage        string
	TorrentId           string
	TorrentFileLocation string
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
		Status:              string(r.Status),
		TorrentId:           r.TorrentId,
		TorrentFileLocation: r.TorrentFileLocation,
		CreatedAt:           r.CreatedAt.Format(time.RFC3339),
		UpdatedAt:           r.UpdatedAt.Format(time.RFC3339),
	}
}

// FromProto loads media from v1.Media message
//
// Status cannot be modified
func (r *Media) FromProto(proto *v1.Media) {
	r.FileLink = proto.FileLink
	r.Author = proto.Author
	r.Book = proto.Book
	r.Series = proto.Series
	r.SeriesNumber = uint(proto.SeriesNumber)
	r.Category = proto.Category
	r.MAMBookID = proto.MamBookId
	r.TorrentId = proto.TorrentId
	r.TorrentFileLocation = proto.TorrentFileLocation
}
