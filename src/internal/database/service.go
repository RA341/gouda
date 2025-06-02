package database

type Service struct {
	*CategoryDB
	*DownloadsDB
	*MediaManagerDB
}

func NewDBService() (*Service, error) {
	db, err := connect()
	if err != nil {
		return nil, err
	}

	return &Service{
		CategoryDB:     &CategoryDB{db: db},
		DownloadsDB:    &DownloadsDB{db: db},
		MediaManagerDB: &MediaManagerDB{db: db},
	}, nil
}
