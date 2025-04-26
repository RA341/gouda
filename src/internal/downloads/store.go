package downloads

type Store interface {
	Save(media *Media) error
	GetDownloadingMediaById(id string, media *Media) error
	GetAllDownloadingMediaIds(results []string) error
}
