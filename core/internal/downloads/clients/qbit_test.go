package clients

import (
	"context"
	"fmt"
	"testing"
	"time"

	"github.com/RA341/gouda/internal/server_config"
	"github.com/docker/docker/api/types/container"
	"github.com/docker/go-connections/nat"
	"github.com/stretchr/testify/assert"
	"github.com/testcontainers/testcontainers-go"
	"github.com/testcontainers/testcontainers-go/wait"
)

var (
	qbitWebuiPort = "8722"
	qbitNATPort   = fmt.Sprintf("%s/tcp", qbitWebuiPort)
)

const (
	qbitTestUser = "admin"
	// password is set in qbit_test_config.conf which is expected to be copied to the container
	qbitTestPass = "admin123"
)

func TestQbitClient(t *testing.T) {
	ctx := context.Background()
	req := addAutoRemove(qbitReq())

	qbitCont, err := testcontainers.GenericContainer(ctx, testcontainers.GenericContainerRequest{
		ContainerRequest: req,
		Started:          true, // Start the container immediately
	})
	assert.NoError(t, err)

	qbitUrl := extractExposedPort(t, qbitCont, qbitNATPort)
	t.Log("qbit url: ", "http://"+qbitUrl)

	qbit, err := NewQbitClient(&server_config.TorrentClient{
		Host: qbitUrl, Protocol: protocol, User: qbitTestUser, Password: qbitTestPass,
	})
	assert.NoError(t, err)

	// todo maybe ??
	//_, _, err = qbit.Test()
	//if err != nil {
	//	fmt.Println(err)
	//	return
	//}

	torrentID, err := qbit.DownloadTorrentWithMagnet(testMagnetLink, "/downloads", "test")
	assert.NoError(t, err)

	statuses, err := qbit.GetTorrentStatus(torrentID)
	assert.NoError(t, err)

	for _, status := range statuses {
		assert.Equal(t, torrentID, status.ID)
		assert.Equal(t, "/downloads", status.DownloadPath)
		t.Log(status)
	}

}

func qbitReq() testcontainers.ContainerRequest {
	qbitTestConf := "./qbit_test_config.conf"
	//	container docs https://docs.linuxserver.io/images/docker-qbittorrent
	return testcontainers.ContainerRequest{
		Image: "lscr.io/linuxserver/qbittorrent:latest",
		Env: map[string]string{
			"PUID":            "1000",
			"PGID":            "1000",
			"WEBUI_PORT":      qbitWebuiPort,
			"TORRENTING_PORT": "17693",
		},
		ExposedPorts: []string{
			qbitNATPort,
			"17693/tcp",
			"17693/udp",
		},
		Files: []testcontainers.ContainerFile{
			{
				HostFilePath:      qbitTestConf,
				ContainerFilePath: "/config/qBittorrent/qBittorrent.conf",
				FileMode:          0o640,
			},
		},
		WaitingFor: wait.ForHTTP("/").
			WithPort(nat.Port(qbitNATPort)).
			WithStatusCodeMatcher(func(status int) bool {
				// qBittorrent web UI sometimes redirects 401
				return status == 200 || status == 401
			}).
			WithStartupTimeout(2 * time.Minute),
	}
}

func addAutoRemove(req testcontainers.ContainerRequest) testcontainers.ContainerRequest {
	req.HostConfigModifier = func(config *container.HostConfig) {
		config.AutoRemove = true
	}
	return req
}
