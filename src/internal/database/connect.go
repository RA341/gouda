package database

import (
	"github.com/RA341/gouda/internal/category"
	"github.com/RA341/gouda/internal/config"
	"github.com/RA341/gouda/internal/downloads"
	"github.com/RA341/gouda/internal/info"
	"github.com/rs/zerolog/log"
	"gorm.io/driver/sqlite"
	"gorm.io/gorm"
	"path/filepath"
)

func connect(goudaConf *config.GoudaConfig) (*gorm.DB, error) {
	dbPath := filepath.Join(goudaConf.Dir.ConfigDir, "gouda.db")
	if dbPath == "" {
		log.Fatal().Msgf("db path is empty")
	}

	// Configure SQLite to use WAL mode
	connectionStr := sqlite.Open(dbPath + "?_journal_mode=WAL&_busy_timeout=5000")
	conf := &gorm.Config{
		PrepareStmt: true,
	}

	if info.IsDev() {
		conf = &gorm.Config{
			//Logger:      logger.Default.LogMode(logger.Info),
			PrepareStmt: true,
		}
	}

	db, err := gorm.Open(connectionStr, conf)
	if err != nil {
		return nil, err
	}

	if err = db.AutoMigrate(&category.Categories{}, &downloads.Media{}); err != nil {
		log.Fatal().Err(err).Msg("Failed migrate tables")
	}

	log.Info().Str("path", dbPath).Msg("Connected to database")
	return db, nil
}
