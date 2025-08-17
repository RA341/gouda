package clients

import (
	"fmt"
)

type DownloadClient interface {
	DownloadTorrentWithFile(torrent, downloadPath, category string) (string, error)

	DownloadTorrentWithMagnet(magnet, downloadPath, category string) (string, error)

	GetTorrentStatus(torrentIds ...string) ([]TorrentStatus, error)

	Test() (string, string, error)
}

type TorrentStatus struct {
	ID           string
	Name         string
	DownloadPath string
	// this is the status defined by the client, may be different for different clients
	ClientStatus string
	// this is defined by gouda intended to be independent of any torrent client
	ParsedStatus TorrentState
}

// TorrentState defines the state of a torrent
//
// intended to be independent of any torrent client
type TorrentState int

const (
	Complete TorrentState = iota
	Error
	Downloading
)

// String method for TorrentState (implements fmt.Stringer)
func (l TorrentState) String() string {
	switch l {
	case Downloading:
		return "DOWNLOADING"
	case Error:
		return "ERROR"
	case Complete:
		return "COMPLETE"
	default:
		return fmt.Sprintf("TorrentState(%d)", l) // Handle unknown values
	}
}
