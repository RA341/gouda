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

func (d DownloadsDB) GetDownloadingMediaById(id string, media *downloads.Media) error {
	resp := d.db.
		Where("torrent_id = ?", id).
		Where("status = ?", "downloading").
		First(media)

	if resp.Error != nil {
		return resp.Error
	}

	return nil
}

func (d DownloadsDB) GetAllDownloadingMediaIds(results []string) error {
	result := d.db.
		Model(&downloads.Media{}).
		Where("status = ?", "downloading").
		Pluck("torrent_id", &results)

	if result.Error != nil {
		return result.Error
	}

	return nil
}
