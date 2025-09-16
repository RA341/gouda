package clients

import (
	"context"
	"fmt"
	"github.com/RA341/gouda/internal/config"
	"github.com/hekmon/transmissionrpc/v3"
	"github.com/rs/zerolog/log"
	"net/url"
	"strconv"
)

type TransmissionClient struct {
	Client *transmissionrpc.Client
}

func NewTransmissionClient(client *config.TorrentClient) (DownloadClient, error) {
	clientStr := ""
	if client.User != "" && client.Password != "" {
		clientStr = fmt.Sprintf("%s://%s:%s@%s/transmission/rpc", client.Protocol, client.User, client.Password, client.Host)
	} else {
		clientStr = fmt.Sprintf("%s://%s/transmission/rpc", client.Protocol, client.Host)
	}

	endpoint, err := url.Parse(clientStr)
	if err != nil {
		return nil, err
	}

	tbt, err := transmissionrpc.New(endpoint, nil)
	if err != nil {
		panic(err)
	}

	transmission := &TransmissionClient{Client: tbt}

	_, _, err = transmission.Test()
	if err != nil {
		log.Error().Err(err).Msg("Transmission client check failed")
		return nil, fmt.Errorf("transmission client health check failed: %s", err)
	}

	return transmission, nil
}

// DownloadTorrentWithFile should not be use magnet links func: DownloadTorrentWithMagnet
func (tm *TransmissionClient) DownloadTorrentWithFile(torrent, downloadPath, _ string) (string, error) {
	torrentResult, err := tm.Client.TorrentAddFileDownloadDir(context.Background(), torrent, downloadPath)
	if err != nil {
		return "", err
	}
	return strconv.FormatInt(*torrentResult.ID, 10), nil
}

func (tm *TransmissionClient) DownloadTorrentWithMagnet(magnet, downloadPath, category string) (string, error) {
	torrentResult, err := tm.Client.TorrentAdd(context.Background(), transmissionrpc.TorrentAddPayload{
		Filename:    &magnet,
		DownloadDir: &downloadPath,
		Labels:      []string{category},
	})
	if err != nil {
		return "", err
	}
	return strconv.FormatInt(*torrentResult.ID, 10), nil
}

func (tm *TransmissionClient) Test() (string, string, error) {
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

func (tm *TransmissionClient) GetTorrentStatus(torrentIds ...string) ([]TorrentStatus, error) {
	var intIds []int64
	for _, torrentId := range torrentIds {
		finalId, err := strconv.Atoi(torrentId)
		if err != nil {
			log.Error().Err(err).Msgf("Unable to convert torrent id: %s to int64", torrentId)
			return nil, err
		}
		intIds = append(intIds, int64(finalId))
	}

	infos, err := tm.Client.TorrentGetAllFor(context.Background(), intIds)
	if err != nil {
		return nil, err
	}

	var results []TorrentStatus

	for _, info := range infos {
		status := Downloading
		if info.Status.String() == "seeding" {
			status = Complete
		} else if info.Status.String() == "error" {
			status = Error
		}

		results = append(results, TorrentStatus{
			ID:           strconv.FormatInt(*info.ID, 10),
			Name:         *info.Name,
			DownloadPath: *info.DownloadDir,
			ParsedStatus: status,
			ClientStatus: info.Status.String(),
		})
	}

	return results, nil
}
