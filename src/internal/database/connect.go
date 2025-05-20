package database

import (
	"github.com/RA341/gouda/internal/category"
	"github.com/RA341/gouda/internal/config"
	"github.com/RA341/gouda/internal/downloads"
	"github.com/rs/zerolog/log"
	"gorm.io/driver/sqlite"
	"gorm.io/gorm"
	"gorm.io/gorm/logger"
)

func connect() (*gorm.DB, error) {
	dbPath := config.DbPath.GetStr()
	if dbPath == "" {
		log.Fatal().Msgf("db_path is empty")
	}

	// Configure SQLite to use WAL mode
	connectionStr := sqlite.Open(dbPath + "?_journal_mode=WAL&_busy_timeout=5000")

	conf := &gorm.Config{
		PrepareStmt: true,
	}
	if config.IsDebugMode() {
		conf = &gorm.Config{
			Logger:      logger.Default.LogMode(logger.Info),
			PrepareStmt: true,
		}
	}

	db, err := gorm.Open(connectionStr, conf)
	if err != nil {
		return nil, err
	}

	err = db.AutoMigrate(&category.Categories{}, &downloads.Media{})
	if err != nil {
		log.Fatal().Err(err).Msgf("Failed migrate tables")
	}

	_, err = db.DB()
	if err != nil {
		return nil, err
	}

	log.Info().Str("path", dbPath).Msg("Connected to database")
	return db, nil
}
