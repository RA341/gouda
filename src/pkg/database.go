package pkg

import (
	"github.com/rs/zerolog/log"
	"gorm.io/driver/sqlite" // Sqlite driver based on CGO
	"gorm.io/gorm"
	"gorm.io/gorm/logger"
)

func InitDB() (*gorm.DB, error) {
	dbPath := DbPath.GetStr()
	if dbPath == "" {
		log.Fatal().Msgf("db_path is empty")
	}

	// Configure SQLite to use WAL mode
	connectionStr := sqlite.Open(dbPath + "?_journal_mode=WAL&_busy_timeout=5000")

	config := &gorm.Config{
		PrepareStmt: true,
	}
	if IsDebugMode() {
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

	return db, nil
}
