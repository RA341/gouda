package download_clients

import (
	"context"
	"fmt"
	models "github.com/RA341/gouda/models"
	"github.com/hekmon/transmissionrpc/v3"
	"github.com/rs/zerolog/log"
	"net/url"
	"strconv"
)

type TransmissionClient struct {
	Client *transmissionrpc.Client
}

func InitTransmission(transmissionUrl, protocol, user, pass string) (models.DownloadClient, error) {
	clientStr := ""
	if user != "" && pass != "" {
		clientStr = fmt.Sprintf("%s://%s:%s@%s/transmission/rpc", protocol, user, pass, transmissionUrl)
	} else {
		clientStr = fmt.Sprintf("%s://%s/transmission/rpc", protocol, transmissionUrl)
	}

	endpoint, err := url.Parse(clientStr)
	if err != nil {
		return nil, err
	}

	tbt, err := transmissionrpc.New(endpoint, nil)
	if err != nil {
		panic(err)
	}

	return &TransmissionClient{
		Client: tbt,
	}, nil
}

func (tm *TransmissionClient) DownloadTorrent(torrent, downloadPath, category string) (string, error) {
	torrentResult, err := tm.Client.TorrentAddFileDownloadDir(context.Background(), torrent, downloadPath)
	if err != nil {
		return "", err
	}
	return strconv.FormatInt(*torrentResult.ID, 10), nil
}

func (tm *TransmissionClient) Health() (string, string, error) {
	ok, serverVersion, serverMinimumVersion, err := tm.Client.RPCVersion(context.Background())
	if err != nil {
		return "", "", err
	}

	if !ok {
		return "", "", fmt.Errorf("remote transmission RPC version (v%d) is incompatible with the transmission library (v%d): remote needs at least v%d",
			serverVersion, transmissionrpc.RPCVersion, serverMinimumVersion)
	}

	return "transmission", fmt.Sprintf("Remote transmission RPC version (v%d) is compatible with our transmissionrpc library (v%d)\n",
		serverVersion, transmissionrpc.RPCVersion), nil
}

func (tm *TransmissionClient) CheckTorrentStatus(torrentIds []string) ([]models.TorrentStatus, error) {
	var intIds []int64
	for _, torrentId := range torrentIds {
		finalId, err := strconv.Atoi(torrentId)
		if err != nil {
			log.Error().Err(err).Msgf("Unable to convert torrent id: %s to int64", torrentId)
			return []models.TorrentStatus{}, err
		}
		intIds = append(intIds, int64(finalId))
	}

	infos, err := tm.Client.TorrentGetAllFor(context.TODO(), intIds)
	if err != nil {
		return []models.TorrentStatus{}, err
	}

	var results []models.TorrentStatus

	for _, info := range infos {
		complete := false
		if info.Status.String() == "seeding" {
			complete = true
		}

		results = append(results, models.TorrentStatus{
			ID:               strconv.FormatInt(*info.ID, 10),
			Name:             *info.Name,
			DownloadPath:     *info.DownloadDir,
			DownloadComplete: complete,
			Status:           info.Status.String(),
		})
	}

	return results, nil
}
