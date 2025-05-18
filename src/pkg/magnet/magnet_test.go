package magnet

import (
	"github.com/stretchr/testify/assert"
	"os"
	"testing"
)

type testCase struct {
	torrentFile string
	magnet      string
}

var testCases = map[string]testCase{
	"big-buck": {
		torrentFile: "./torrent_files/big-buck-bunny.torrent",
		magnet:      "magnet:?xt=urn:btih:dd8255ecdc7ca55fb0bbf81323d87062db1f6d1c&dn=Big+Buck+Bunny&tr=udp%3A%2F%2Fexplodie.org%3A6969&tr=udp%3A%2F%2Ftracker.coppersurfer.tk%3A6969&tr=udp%3A%2F%2Ftracker.empire-js.us%3A1337&tr=udp%3A%2F%2Ftracker.leechers-paradise.org%3A6969&tr=udp%3A%2F%2Ftracker.opentrackr.org%3A1337&tr=wss%3A%2F%2Ftracker.btorrent.xyz&tr=wss%3A%2F%2Ftracker.fastcast.nz&tr=wss%3A%2F%2Ftracker.openwebtorrent.com&ws=https%3A%2F%2Fwebtorrent.io%2Ftorrents%2F&xs=https%3A%2F%2Fwebtorrent.io%2Ftorrents%2Fbig-buck-bunny.torrent",
	},
	"cosmos": {
		torrentFile: "./torrent_files/cosmos-laundromat.torrent",
		magnet:      "magnet:?xt=urn:btih:c9e15763f722f23e98a29decdfae341b98d53056&dn=Cosmos+Laundromat&tr=udp%3A%2F%2Fexplodie.org%3A6969&tr=udp%3A%2F%2Ftracker.coppersurfer.tk%3A6969&tr=udp%3A%2F%2Ftracker.empire-js.us%3A1337&tr=udp%3A%2F%2Ftracker.leechers-paradise.org%3A6969&tr=udp%3A%2F%2Ftracker.opentrackr.org%3A1337&tr=wss%3A%2F%2Ftracker.btorrent.xyz&tr=wss%3A%2F%2Ftracker.fastcast.nz&tr=wss%3A%2F%2Ftracker.openwebtorrent.com&ws=https%3A%2F%2Fwebtorrent.io%2Ftorrents%2F&xs=https%3A%2F%2Fwebtorrent.io%2Ftorrents%2Fcosmos-laundromat.torrent",
	},
}

func TestTorrentFileToMagnet(t *testing.T) {
	for _, test := range testCases {
		runTestTorrentFileToMagnet(t, test)
	}
}

func TestAdd(t *testing.T) {
	runTestTorrentFileToMagnet(t, testCase{
		torrentFile: "./torrent_files/absolution.torrent",
		magnet:      "",
	})
}

func runTestTorrentFileToMagnet(t *testing.T, testcase testCase) {
	open, err := os.Open(testcase.torrentFile)
	if err != nil {
		t.Fatal("failed to open torrent file:", err)
		return
	}

	magnet, err := TorrentFileToMagnet(open)
	if err != nil {
		t.Fatal(err)
		return
	}

	actual, err := DecodeMagnetURL(magnet)
	if err != nil {
		t.Fatal(err)
		return
	}

	expected, err := DecodeMagnetURL(testcase.magnet)
	if err != nil {
		t.Fatal(err)
		return
	}

	assert.Equal(t, expected.InfoHash, actual.InfoHash, "InfoHash should match")
	assert.Equal(t, expected.DisplayName, actual.DisplayName, "DisplayName should match")
	// Compare slice fields where order doesn't matter
	assert.ElementsMatch(t, expected.Trackers, actual.Trackers, "Trackers should contain the same elements")
	assert.ElementsMatch(t, expected.ExactTopics, actual.ExactTopics, "ExactTopics should contain the same elements")
}
