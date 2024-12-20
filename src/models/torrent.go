package types

import (
	"gorm.io/gorm"
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
	FileLink    string `json:"file_link" gorm:"-"`
	Author      string `json:"author"`
	Book        string `json:"book"`
	Category    string `json:"category"`
	MAMBookID   uint64 `json:"mam_book_id" gorm:"uniqueIndex;check:mam_book_id > 0"`
	Status      string `json:"status,omitempty"`
	TorrentId   string `json:"torrent_id,omitempty"`
	TimeRunning uint   `json:"time_running,omitempty"`
}
