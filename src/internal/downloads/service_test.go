package downloads

import (
	"encoding/hex"
	"fmt"
	"github.com/RA341/gouda/internal/config"
	"github.com/RA341/gouda/internal/downloads/clients"
	"github.com/RA341/gouda/pkg"
	"hash/fnv"
	"math/rand/v2"
	"os"
	"strconv"
	"sync/atomic"
	"testing"
	"time"
)

func TestDownloadService(t *testing.T) {
	err := os.Mkdir("test", os.ModePerm)
	if err != nil {
		t.Fatal(err)
		return
	}

	const torrentFile = "test/testTorrent"
	_, err = os.Create(torrentFile)
	if err != nil {
		t.Fatal(err)
		return
	}

	srv := setupTestService()
	var testCase = Media{
		Author:       "test author",
		Book:         "test book",
		Series:       "test series",
		SeriesNumber: 1,
		Category:     "test",
		MAMBookID:    123123,
	}

	err = srv.DownloadMedia(&testCase, false)
	if err != nil {
		t.Fatal(err)
		return
	}

}

func TestDownloadTorrentFile(t *testing.T) {
	link := "https://webtorrent.io/torrents/big-buck-bunny.torrent"
	_, err := downloadAndConvertToMagnetLink(link)
	if err != nil {
		t.Fatal(err)
		return
	}

	// todo verify magnet link
}

func setupTestService() *DownloadService {
	config.Load()
	var inc uint32 = 1
	tdc := TestDownloadClient{torrentList: pkg.Map[string, tor]{}}
	ts := TestDownloadStore{incrId: &inc, store: pkg.Map[string, *Media]{}}
	srv := NewDownloadService(&ts, &tdc)
	return srv
}

type TestDownloadClient struct {
	torrentList pkg.Map[string, tor]
}

func (t *TestDownloadClient) DownloadTorrentWithFile(torrent, downloadPath, category string) (string, error) {
	hasher := fnv.New32a()
	_, err := hasher.Write([]byte(torrent))
	if err != nil {
		return "", err
	}
	hashBytes := hasher.Sum(nil) // Resets and returns []byte
	hashString := hex.EncodeToString(hashBytes)

	val := tor{
		torrent, downloadPath, category,
		false,
	}
	t.torrentList.Store(hashString, val)

	// complete randomly within 15 seconds
	completeTime := time.Second * time.Duration(rand.IntN(15))
	time.AfterFunc(completeTime, func() {
		val.complete = true
		fmt.Println("torrent complete")
		t.torrentList.Store(hashString, val)
	})

	return hashString, nil
}

func (t *TestDownloadClient) GetTorrentStatus(torrentId []string) ([]clients.TorrentStatus, error) {
	var torrents []clients.TorrentStatus
	for _, torrent := range torrentId {
		value, ok := t.torrentList.Load(torrent)
		if !ok {
			continue
		}

		torrents = append(torrents, clients.TorrentStatus{
			ID:           torrent,
			Name:         value.torrent,
			DownloadPath: value.downloadPath,
			ParsedStatus: value.complete,
			ClientStatus: "no status test client",
		})
	}

	return torrents, nil
}

func (t *TestDownloadClient) Test() (string, string, error) {
	return "test-client", "vtest", nil
}

type TestDownloadStore struct {
	store  pkg.Map[string, *Media]
	incrId *uint32
}

func (t *TestDownloadStore) GetMediaByTorrentId(torrentId string) (*Media, error) {
	tmp, ok := t.store.Load(torrentId)
	if !ok {
		return nil, fmt.Errorf("not found")
	}
	return tmp, nil
}

func (t *TestDownloadStore) GetDownloadingMediaTorrentIdList() ([]string, error) {
	var results []string

	t.store.Range(func(key string, value *Media) bool {
		if value.Status == Downloading {
			results = append(results, strconv.Itoa(int(value.ID)))
		}
		return true
	})

	return results, nil
}

func (t *TestDownloadStore) Save(media *Media) error {
	id := atomic.AddUint32(t.incrId, 1)
	media.ID = uint(id)

	t.store.Store(strconv.Itoa(int(media.ID)), media)
	return nil
}

type tor struct {
	torrent, downloadPath, category string
	complete                        bool
}
