package clients

import (
	"context"
	"fmt"
	"github.com/stretchr/testify/assert"
	"github.com/testcontainers/testcontainers-go"
	"github.com/testcontainers/testcontainers-go/wait"
	"testing"
)

const (
	delugeTestUser     = "admin"
	delugeTestPassword = "deluge"
)

var (
	delugeWebuiPort = "8112"
	delugeNATPort   = fmt.Sprintf("%s/tcp", delugeWebuiPort)
)

func TestDelugeClient(t *testing.T) {
	ctx := context.Background()
	req := delugeClient()
	container, err := testcontainers.GenericContainer(ctx, testcontainers.GenericContainerRequest{
		ContainerRequest: req,
		Started:          true,
	})
	assert.NoError(t, err)
	delugeUrl := extractExposedPort(t, container, delugeNATPort)
	//delugeUrl = "localhost:" + delugeWebuiPort
	t.Log("delugeUrl: ", delugeUrl)

	client, err := NewDelugeClient(&TorrentClient{
		Host:     delugeUrl,
		Protocol: protocol,
		User:     delugeTestUser,
		Password: delugeTestPassword,
	})
	assert.NoError(t, err)

	//torrentID, err := client.DownloadTorrentWithMagnet(testMagnetLink, "/downloads", "test")
	//assert.NoError(t, err)

	torrentID, err := client.DownloadTorrentWithFile("./test_torrents/big-buck-bunny.torrent", "/downloads", "test")
	assert.NoError(t, err)

	status, err := client.GetTorrentStatus(torrentID)
	assert.NoError(t, err)

	for _, st := range status {
		t.Log(st)
	}
}

func delugeClient() testcontainers.ContainerRequest {
	return testcontainers.ContainerRequest{
		Image: "linuxserver/deluge:latest",
		ExposedPorts: []string{
			delugeNATPort,
			"17693/tcp",
			"17693/udp",
			"58846/tcp",
		},
		//WaitingFor: wait.ForHTTP("/").
		//	WithPort(nat.Port(delugeNATPort)).
		//	WithStatusCodeMatcher(func(status int) bool {
		//		time.Sleep(5 * time.Second)
		//
		//		return status == 200
		//	}).
		//	WithStartupTimeout(3 * time.Minute),
		WaitingFor: wait.ForLog("[ls.io-init] done."),
	}
}
