package downloads

import (
	"testing"

	sc "github.com/RA341/gouda/internal/server_config"
)

func Test_downloadTorrentFile(t *testing.T) {
	srv := Service{
		dirs: func() *sc.Directories {
			return &sc.Directories{
				TorrentDir: "torren",
			}
		},
	}

	link := "https://www.myanonamouse.net/tor/download.php/RwAfE1wyLo6,UON5AKHAhRg+KsG9xLRDBynv7D1TkwhOMLWu,74dV+ip53WoNFRZVAg6q9nwW2ufzBQPOmJXEALIZeB6VaFAf,5uCfmzGHZ2A7WqUo2DxsT3G,CFLQ7HdSCfLwzpoHWXK,P0CpqVsaieBe6wNLOweSccPr,lHghsMUfdPg=="

	file, err := srv.downloadTorrentFile(link)
	if err != nil {
		t.Fatal(err)
	}

	t.Log(file)
}

//
//func TestDownloadService(t *testing.T) {
//	server_config.Load()
//	tdc := TestDownloadClient{torrentList: pkg.Map[string, tor]{}}
//	ts := TestDownloadStore{store: pkg.Map[string, *Media]{}}
//	srv := NewService(&ts, &con, &tdc)
//	srv.checkInterval = 10 * time.Second
//
//	numMedia := 100
//	var testCases []*Media
//
//	for i := 0; i < numMedia; i++ {
//		testCases = append(testCases, &Media{
//			Author:            fmt.Sprintf("Test Author %d", i+1),
//			title:              fmt.Sprintf("Test title %d", i+1),
//			Series:            "Test Series",
//			SeriesNumber:      uint(i + 1),
//			Category:          "test-category",
//			MAMBookID:         uint64(123123 + i),
//			TorrentMagentLink: fmt.Sprintf("magnet:?xt=urn:btih:TESTHASH%d", i+1),
//			Status:            Downloading,
//		})
//	}
//
//	for _, testCase := range testCases {
//		err := srv.DownloadMedia(testCase)
//		assert.NoError(t, err)
//
//	}
//
//	checkInterval := time.NewTicker(5 * time.Second)
//	defer checkInterval.Stop()
//
//	for {
//		count := 0
//		for _, testCase := range testCases {
//			med, ok := ts.store.Load(testCase.TorrentClientId)
//			if !ok {
//				t.Fatal("Torrent not found", testCase.TorrentClientId)
//			}
//
//			if med.Status != Downloading {
//				count++
//			}
//		}
//
//		if count == numMedia {
//			t.Log("all downloads completed: ", count)
//			break
//		}
//
//		<-checkInterval.C
//	}
//}
//
//type TestDownloadClient struct {
//	torrentList pkg.Map[string, tor]
//}
//
//func (t *TestDownloadClient) DownloadTorrentWithMagnet(magnet, downloadPath, category string) (string, error) {
//	return t.addTorrent(magnet, downloadPath, category)
//}
//
//func (t *TestDownloadClient) GetTorrentStatus(torrentIds ...string) ([]clients.TorrentStatus, error) {
//	var torrents []clients.TorrentStatus
//	for _, torrent := range torrentIds {
//		value, ok := t.torrentList.Load(torrent)
//		if !ok {
//			continue
//		}
//
//		torrents = append(torrents, clients.TorrentStatus{
//			ID:           torrent,
//			Name:         value.torrent,
//			DownloadPath: value.downloadPath,
//			ParsedStatus: clients.Complete,
//			ClientStatus: "no status test torrentClient",
//		})
//	}
//
//	return torrents, nil
//}
//
//func (t *TestDownloadClient) DownloadTorrentWithFile(torrent, downloadPath, category string) (string, error) {
//	return t.addTorrent(torrent, downloadPath, category)
//}
//
//func (t *TestDownloadClient) addTorrent(torrent string, downloadPath string, category string) (string, error) {
//	hasher := fnv.New32a()
//	_, err := hasher.Write([]byte(torrent))
//	if err != nil {
//		return "", err
//	}
//	hashBytes := hasher.Sum(nil) // Resets and returns []byte
//	hashString := hex.EncodeToString(hashBytes)
//
//	val := tor{
//		torrent, downloadPath, category,
//		false,
//	}
//	t.torrentList.Store(hashString, val)
//
//	// complete randomly within 15 seconds
//	completeTime := time.Second * time.Duration(rand.IntN(15))
//	time.AfterFunc(completeTime, func() {
//		val.complete = true
//		//fmt.Println("torrent complete")
//		t.torrentList.Store(hashString, val)
//	})
//
//	return hashString, nil
//}
//
//func (t *TestDownloadClient) Test() (string, string, error) {
//	return "test-torrentClient", "vtest", nil
//}
//
//type TestDownloadStore struct {
//	store pkg.Map[string, *Media]
//}
//
//func (t *TestDownloadStore) GetMediaByTorrentId(torrentId string) (*Media, error) {
//	tmp, ok := t.store.Load(torrentId)
//	if !ok {
//		return nil, fmt.Errorf("not found")
//	}
//	return tmp, nil
//}
//
//func (t *TestDownloadStore) GetDownloadingMedia() ([]Media, error) {
//	var results []Media
//
//	t.store.Range(func(key string, value *Media) bool {
//		if value.Status == Downloading {
//			results = append(results, *value)
//		}
//		return true
//	})
//
//	return results, nil
//}
//
//func (t *TestDownloadStore) Save(media *Media) error {
//	t.store.Store(media.TorrentClientId, media)
//	return nil
//}
//
//type tor struct {
//	torrent, downloadPath, category string
//	complete                        bool
//}
