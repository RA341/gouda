package database

import (
	"fmt"
	"path/filepath"

	"github.com/RA341/gouda/internal/config"
	"github.com/rs/zerolog/log"
	"gorm.io/driver/sqlite"
	"gorm.io/gorm"
	"gorm.io/gorm/logger"
)

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

func connect(goudaConf *config.GoudaConfig, models ...interface{}) (*gorm.DB, error) {
	dbPath := goudaConf.Dir.ConfigDir
	if dbPath == "" {
		log.Fatal().Msgf("db path is empty")
	}

	db, err := ConnectToDB(dbPath, models...)
	if err != nil {
		return nil, err
	}

	log.Info().Str("path", dbPath).Msg("Connected to database")
	return db, nil
}
