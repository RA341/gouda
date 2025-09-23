package database

import (
	"fmt"
	"strconv"

	"github.com/RA341/gouda/internal/downloads"
	"gorm.io/gorm"
)

type MediaManagerStore struct {
	db *gorm.DB
}

func (m *MediaManagerStore) Get(id uint) (*downloads.Media, error) {
	var media downloads.Media
	result := m.db.First(&media, id)
	if result.Error != nil {
		return nil, result.Error
	}
	return &media, nil
}

func (m *MediaManagerStore) Search(query string) ([]downloads.Media, error) {
	var results []downloads.Media
	dbQuery := m.db.
		Order("updated_at desc").
		Offset(0).
		Limit(10)
	dbQuery = buildSearchQuery(query, dbQuery)

	res := dbQuery.Find(&results)
	if res.Error != nil {
		return nil, fmt.Errorf("unable to query database %v", dbQuery.Error.Error())
	}

	return results, nil
}

func (m *MediaManagerStore) ListMedia(offset int, limit int) ([]downloads.Media, error) {
	var results []downloads.Media

	resp := m.db.
		Order("updated_at desc").
		Offset(offset).
		Limit(limit).
		Find(&results)
	if resp.Error != nil {
		return nil, resp.Error
	}

	return results, nil
}

func (m *MediaManagerStore) Exists(mamId uint64) (*downloads.Media, bool, error) {
	var media downloads.Media
	resp := m.db.Where("mam_book_id = ?", mamId).First(&media)
	if resp.Error != nil {
		return nil, false, resp.Error
	}
	return &media, true, nil
}

func (m *MediaManagerStore) DeleteMedia(id uint) error {
	resp := m.db.Unscoped().Delete(downloads.Media{}, id)
	if resp.Error != nil {
		return resp.Error
	}

	return nil
}

func (m *MediaManagerStore) Edit(media *downloads.Media) error {
	result := m.db.Save(media)
	if result.Error != nil {
		return fmt.Errorf("error editing torrent %v", result.Error.Error())
	}
	return nil
}

func (m *MediaManagerStore) Add(media *downloads.Media) error {
	panic("unused method")
}

func (m *MediaManagerStore) CountAllMedia() (int64, error) {
	var count int64 = 0
	resp := m.db.Model(&downloads.Media{}).Count(&count)
	if resp.Error != nil {
		return count, resp.Error
	}
	return count, nil
}

func buildSearchQuery(search string, query *gorm.DB) *gorm.DB {
	// String fields use LIKE for partial matches
	query = query.Where("LOWER(author) LIKE LOWER(?)", "%"+search+"%").
		Or("LOWER(book) LIKE LOWER(?)", "%"+search+"%").
		Or("LOWER(series) LIKE LOWER(?)", "%"+search+"%").
		Or("LOWER(category) LIKE LOWER(?)", "%"+search+"%").
		Or("LOWER(status) LIKE LOWER(?)", "%"+search+"%").
		Or("LOWER(torrent_id) LIKE LOWER(?)", "%"+search+"%")

	// Numeric fields use exact matches
	if _, err := strconv.ParseInt(search, 10, 64); err == nil {
		query = query.
			Or("series_number = ?", search).
			Or("mam_book_id = ?", search)
	}

	return query
}
