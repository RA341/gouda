package database

import (
	"github.com/RA341/gouda/internal/downloads"
	"gorm.io/gorm"
)

type DownloadsDB struct {
	db *gorm.DB
}

func (d DownloadsDB) Save(media *downloads.Media) error {
	res := d.db.Save(&media)
	if res.Error != nil {
		return res.Error
	}

	return nil
}

func (d DownloadsDB) GetMediaByTorrentId(torrentId string) (*downloads.Media, error) {
	var media downloads.Media
	resp := d.db.
		Where("torrent_id = ?", torrentId).
		Where("status = ?", "downloading").
		First(media)

	if resp.Error != nil {
		return nil, resp.Error
	}

	return &media, nil
}

func (d DownloadsDB) GetDownloadingMediaTorrentIdList() ([]string, error) {
	var results []string
	result := d.db.
		Model(&downloads.Media{}).
		Where("status = ?", "downloading").
		Pluck("torrent_id", &results)

	if result.Error != nil {
		return results, result.Error
	}

	return results, nil
}
