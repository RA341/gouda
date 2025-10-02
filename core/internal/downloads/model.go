package downloads

import (
	"time"

	v1 "github.com/RA341/gouda/generated/media_requests/v1"
	"gorm.io/gorm"
)

type MediaStatus string

const (
	Downloading = "Downloading"
	Complete    = "Completed"
	Error       = "Error"
)

type Media struct {
	gorm.Model

	// path to final downloaded path
	FinalFilePath      string
	TorrentFilePath    string
	TorrentDownloadUrl string

	Title        string
	Author       string
	Series       string
	SeriesNumber uint
	Category     string
	MAMBookID    uint64 `gorm:"uniqueIndex;check:mam_book_id > 0"`

	Status          MediaStatus
	ErrorMessage    string
	TorrentClientId string

	// todo support magent links
	//TorrentMagentLink string
}

func (r *Media) TableName() string {
	return "media_requests"
}

func (r *Media) MarkError(msg error) {
	r.Status = Error
	r.ErrorMessage = msg.Error()
}

func (r *Media) MarkComplete() {
	r.Status = Complete
}

func (r *Media) MarkDownloading() {
	r.Status = Downloading
}

func (r *Media) ToProto() *v1.Media {
	return &v1.Media{
		ID:                  uint64(r.ID),
		Author:              r.Author,
		Book:                r.Title,
		Series:              r.Series,
		SeriesNumber:        uint32(r.SeriesNumber),
		Category:            r.Category,
		MamBookId:           r.MAMBookID,
		FileLink:            r.FinalFilePath,
		Status:              string(r.Status),
		TorrentId:           r.TorrentClientId,
		TorrentFileLocation: r.TorrentFilePath,
		CreatedAt:           r.CreatedAt.Format(time.RFC3339),
		UpdatedAt:           r.UpdatedAt.Format(time.RFC3339),
	}
}

// FromProto loads media from v1.Media message
//
// Status cannot be modified
func (r *Media) FromProto(proto *v1.Media) {
	//r.FinalFilePath = proto.FileLink
	r.TorrentDownloadUrl = proto.FileLink
	r.Author = proto.Author
	r.Title = proto.Book
	r.Series = proto.Series
	r.SeriesNumber = uint(proto.SeriesNumber)
	r.Category = proto.Category
	r.MAMBookID = proto.MamBookId
	r.TorrentClientId = proto.TorrentId
	// todo
	//r.TorrentMagentLink = proto.TorrentFileLocation
}
