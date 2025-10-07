package clients

import (
	"context"
	"fmt"
	"testing"

	"github.com/RA341/gouda/internal/server_config"
	"github.com/docker/go-connections/nat"
	"github.com/stretchr/testify/assert"
	"github.com/testcontainers/testcontainers-go"
	"github.com/testcontainers/testcontainers-go/wait"
)

const (
	testTransmissionUser = "admin"
	testTransmissionPass = "admin"
	protocol             = "http"

	// this port is internal to docker, test containers will assign a random port to accessed by container.MappedPort
	transmissionPort = "9091/tcp"
)

const (
	testMagnetLink = "magnet:?xt=urn:btih:dd8255ecdc7ca55fb0bbf81323d87062db1f6d1c&dn=Big+Buck+Bunny&tr=udp%3A%2F%2Fexplodie.org%3A6969&tr=udp%3A%2F%2Ftracker.coppersurfer.tk%3A6969&tr=udp%3A%2F%2Ftracker.empire-js.us%3A1337&tr=udp%3A%2F%2Ftracker.leechers-paradise.org%3A6969&tr=udp%3A%2F%2Ftracker.opentrackr.org%3A1337&tr=wss%3A%2F%2Ftracker.btorrent.xyz&tr=wss%3A%2F%2Ftracker.fastcast.nz&tr=wss%3A%2F%2Ftracker.openwebtorrent.com&ws=https%3A%2F%2Fwebtorrent.io%2Ftorrents%2F&xs=https%3A%2F%2Fwebtorrent.io%2Ftorrents%2Fbig-buck-bunny.torrent"
)

func TestTransmissionClient(t *testing.T) {
	ctx := context.Background()
	req := addAutoRemove(transmissionReq())

	cont, err := testcontainers.GenericContainer(ctx, testcontainers.GenericContainerRequest{
		ContainerRequest: req,
		Started:          true, // Start the container immediately
	})
	assert.NoError(t, err)

	transmissionUrl := extractExposedPort(t, cont, transmissionPort)
	t.Log("transmission url: ", "http://"+transmissionUrl)

	client, err := NewTransmissionClient(&server_config.TorrentClient{
		Host:     transmissionUrl,
		Protocol: protocol,
		User:     testTransmissionUser,
		Password: testTransmissionPass,
	})
	assert.NoError(t, err)

	torrentID, err := client.DownloadTorrentWithMagnet(testMagnetLink, "/downloads", "test")
	assert.NoError(t, err)

	status, err := client.GetTorrentStatus(torrentID)
	assert.NoError(t, err)

	for _, val := range status {
		assert.Equal(t, torrentID, val.ID)
		assert.Equal(t, "/downloads", val.DownloadPath)
	}
}

func extractExposedPort(t *testing.T, cont testcontainers.Container, natPort string) string {
	port, err := cont.MappedPort(context.Background(), nat.Port(natPort))
	assert.NoError(t, err)
	transmissionUrl := fmt.Sprintf("localhost:%s", port.Port())
	return transmissionUrl
}

func transmissionReq() testcontainers.ContainerRequest {
	return testcontainers.ContainerRequest{
		Image: "lscr.io/linuxserver/transmission:latest",
		Env: map[string]string{
			"USER":     testTransmissionUser,
			"PASS":     testTransmissionPass,
			"PEERPORT": "9161",
		},
		ExposedPorts: []string{
			transmissionPort,
			"9161/tcp",
			"9161/udp",
		},
		WaitingFor: wait.ForLog("Connection to localhost (127.0.0.1) 9091 port [tcp/*] succeeded!"),
	}

}
