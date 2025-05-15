package downloads

//type Store interface {
//	Save(media *Media) error
//	GetMediaByTorrentId(torrentId string, media *Media) error
//	GetDownloadingMediaTorrentIdList(results *[]string) error
//}

type Store interface {
	Save(media *Media) error
	GetMediaByTorrentId(torrentId string) (*Media, error)
	GetDownloadingMediaTorrentIdList() ([]string, error)
}
