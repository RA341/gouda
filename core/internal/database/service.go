package database

import (
	"fmt"
	"path/filepath"

	"github.com/RA341/gouda/internal/auth"
	"github.com/RA341/gouda/internal/category"
	"github.com/RA341/gouda/internal/downloads"
	"gorm.io/driver/sqlite"
	"gorm.io/gorm"
	"gorm.io/gorm/logger"
)

type Service struct {
	*CategoryStore
	*DownloadsStore
	*MediaManagerStore
	*AuthStore
	*AuthSessionStore
}

func NewDBService(databaseDir string) (*Service, error) {
	models := []interface{}{
		&category.Categories{},
		&downloads.Media{},
		&auth.User{},
		&auth.Session{},
	}

	db, err := ConnectToDB(databaseDir, models...)
	if err != nil {
		return nil, err
	}

	return &Service{
		CategoryStore:     &CategoryStore{db: db},
		DownloadsStore:    &DownloadsStore{db: db},
		MediaManagerStore: &MediaManagerStore{db: db},
		AuthSessionStore:  &AuthSessionStore{db: db},
		AuthStore:         &AuthStore{db: db},
	}, nil
}

// ConnectToDB gouda.db is appended to the path
func ConnectToDB(dbPath string, models ...interface{}) (*gorm.DB, error) {
	dbPath = filepath.Join(dbPath, "gouda.db")

	// Configure SQLite to use WAL mode
	connectionStr := sqlite.Open(dbPath + "?_journal_mode=WAL&_busy_timeout=5000")

	// todo
	//if info.IsDev() {
	//}
	conf := &gorm.Config{
		Logger:      logger.Default.LogMode(logger.Silent),
		PrepareStmt: true,
	}

	db, err := gorm.Open(connectionStr, conf)
	if err != nil {
		return nil, err
	}

	err = db.AutoMigrate(models...)
	if err != nil {
		return nil, fmt.Errorf("unable to migrate db: %v", err)
	}

	return db, nil
}
