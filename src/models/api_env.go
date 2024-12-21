package types

import (
	"gorm.io/gorm"
)

type Env struct {
	DownloadClient DownloadClient
	Database       *gorm.DB
}
