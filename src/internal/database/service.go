package database

type Service struct {
	*CategoryDB
	*DownloadsDB
	*MediaManagerDB
}

func NewDBService() (*Service, error) {
	db, err := connectDB()
	if err != nil {
		return nil, err
	}

	return &Service{
		CategoryDB:     &CategoryDB{db: db},
		DownloadsDB:    &DownloadsDB{db: db},
		MediaManagerDB: &MediaManagerDB{db: db},
	}, nil
}
