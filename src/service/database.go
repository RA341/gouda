package service

import (
	types "github.com/RA341/gouda/models"
	"github.com/rs/zerolog/log"
	"gorm.io/driver/sqlite" // Sqlite driver based on CGO
	"gorm.io/gorm"
	"gorm.io/gorm/logger"
	"os"
)

func InitDB(dbPath string) (*gorm.DB, error) {
	// Configure SQLite to use WAL mode
	connectionStr := sqlite.Open(dbPath + "?_journal_mode=WAL&_busy_timeout=5000")

	config := &gorm.Config{
		PrepareStmt: true,
	}
	if os.Getenv("DEBUG") == "true" {
		config = &gorm.Config{
			Logger:      logger.Default.LogMode(logger.Info),
			PrepareStmt: true,
		}
	}

	db, err := gorm.Open(connectionStr, config)
	if err != nil {
		return nil, err
	}

	_, err = db.DB()
	if err != nil {
		return nil, err
	}

	log.Info().Msgf("Connected to database at: %s", dbPath)

	// migrations
	err = migrate(db)
	if err != nil {
		return nil, err
	}
	log.Info().Msgf("Migration complete")

	return db, nil
}

func migrate(db *gorm.DB) error {
	err := db.AutoMigrate(&types.Categories{}, &types.RequestTorrent{})
	if err != nil {
		return err
	}
	return nil
}
