package download_clients

// todo logger

import (
	"context"
	"errors"
	"fmt"
	"github.com/hekmon/transmissionrpc/v3"
	"net/url"
)

type TransmissionClient struct {
	Client *transmissionrpc.Client
}

func InitTransmission(transmissionUrl, protocol, user, pass string) (DownloadClient, error) {
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

func (tm *TransmissionClient) DownloadTorrent(torrent string, downloadPath string) (int64, error) {
	torrentResult, err := tm.Client.TorrentAddFileDownloadDir(context.Background(), torrent, downloadPath)
	if err != nil {
		return 0, err
	}
	return *torrentResult.ID, nil
}

func (tm *TransmissionClient) Health() (string, string, error) {
	ok, serverVersion, serverMinimumVersion, err := tm.Client.RPCVersion(context.Background())
	if err != nil {
		return "", "", err
	}

	if !ok {
		return "", "", errors.New(fmt.Sprintf("Remote transmission RPC version (v%d) is incompatible with the transmission library (v%d): remote needs at least v%d",
			serverVersion, transmissionrpc.RPCVersion, serverMinimumVersion))
	}

	return "transmission", fmt.Sprintf("Remote transmission RPC version (v%d) is compatible with our transmissionrpc library (v%d)\n",
		serverVersion, transmissionrpc.RPCVersion), nil
}

func (tm *TransmissionClient) CheckTorrentStatus(torrentIds int64) (TorrentStatus, error) {
	info, err := tm.Client.TorrentGetAllFor(context.TODO(), []int64{torrentIds})
	if err != nil {
		return TorrentStatus{}, err
	}

	return TorrentStatus{
		Name:         *info[0].Name,
		DownloadPath: *info[0].DownloadDir,
		Status:       info[0].Status.String(),
	}, nil
}
