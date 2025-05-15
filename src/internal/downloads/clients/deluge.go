package clients

import (
	"encoding/json"
	"fmt"
	"github.com/go-resty/resty/v2"
	"github.com/rs/zerolog/log"
	"strings"
	"time"
)

// LoginResponse represents the Deluge JSON-RPC response
type LoginResponse struct {
	Result bool `json:"result"`
	Error  any  `json:"error"`
	ID     int  `json:"id"`
}

type TorrentInfoResponse struct {
	Result map[string]interface{} `json:"result"`
	Error  any                    `json:"error"`
	ID     int                    `json:"id"`
}

type AddTorrentResponse struct {
	Result [][]interface{} `json:"result"` // torrent_id
	Error  any             `json:"error"`
	ID     int             `json:"id"`
}

type DelugeClient struct {
	client    *resty.Client
	jsonURL   string
	uploadURL string
	id        int
}

func NewDelugeClient(delugeUrl, protocol, _, pass string) (DownloadClient, error) {
	client := DelugeClient{
		client:    resty.New().SetTimeout(time.Second * 5),
		jsonURL:   fmt.Sprintf("%s://%s/json", protocol, delugeUrl),
		uploadURL: fmt.Sprintf("%s://%s/upload", protocol, delugeUrl),
		id:        1,
	}

	err := client.loginDeluge(pass)
	if err != nil {
		return nil, fmt.Errorf("unable to login: %v", err)
	}

	return client, nil
}

func (d DelugeClient) DownloadTorrent(torrent, downloadPath, category string) (string, error) {
	uploadedFilePath, err := d.uploadFile(torrent)
	if err != nil {
		log.Error().Err(err).Msg("upload file error")
		return "", err
	}

	// Prepare the add torrent request
	payload := map[string]interface{}{
		"method": "web.add_torrents",
		"params": []interface{}{
			[]map[string]interface{}{
				{
					"path": uploadedFilePath,
					"options": map[string]interface{}{ // Additional options
						"download_location": downloadPath,
						"category":          category,
					},
				},
			},
		},
		"id": d.id,
	}

	resp, err := d.client.R().
		SetDebug(true).
		SetHeader("Content-Type", "application/json").
		SetBody(payload).
		Post(d.jsonURL)

	if err != nil {
		return "", fmt.Errorf("failed to send add torrent request: %w", err)
	}

	var addResp AddTorrentResponse
	if err := json.Unmarshal(resp.Body(), &addResp); err != nil {
		return "", fmt.Errorf("failed to parse add torrent response: %w", err)
	}

	if addResp.Error != nil {
		return "", fmt.Errorf("failed to add torrent: %v", addResp.Error)
	}

	torrentId := addResp.Result[0][1]
	if torrentId == "" {
		return "", fmt.Errorf("failed to get torrent id: %v", addResp.Error)
	}

	return torrentId.(string), nil
}

func (d DelugeClient) GetTorrentStatus(torrentId []string) ([]TorrentStatus, error) {
	payload := map[string]interface{}{
		"method": "core.get_torrents_status",
		"params": []interface{}{
			map[string][]string{"id": torrentId},
			[]string{
				"name",
				"state",
				"progress",
				"download_payload_rate",
				"upload_payload_rate",
				"total_size",
				"save_path",
			},
		},
		"id": d.id,
	}

	var infoResp TorrentInfoResponse
	resp, err := d.client.R().
		SetHeader("Content-Type", "application/json").
		SetBody(payload).
		SetResult(&infoResp).
		Post(d.jsonURL)
	if err != nil {
		return nil, fmt.Errorf("failed to send get torrents request: %w", err)
	}
	if resp.IsError() {
		log.Error().Int("status_code", resp.StatusCode()).Msg("invalid code, torrent status error")
	}

	if infoResp.Error != nil {
		return nil, fmt.Errorf("failed to get torrents info: %v", infoResp.Error)
	}

	var result []TorrentStatus
	for key, value := range infoResp.Result {
		info := value.(map[string]interface{})
		complete := false

		state := strings.ToLower(info["state"].(string))
		if state == "seeding" || state == "complete" {
			complete = true
		}

		result = append(result, TorrentStatus{
			Name:             info["name"].(string),
			DownloadPath:     info["save_path"].(string),
			DownloadComplete: complete,
			Status:           state,
			ID:               key,
		})
	}

	return result, nil
}

func (d DelugeClient) Test() (string, string, error) {
	// Prepare daemon.info request payload
	payload := map[string]interface{}{
		"method": "daemon.info",
		"params": []interface{}{},
		"id":     d.id,
	}

	// Send connection check request
	resp, err := d.client.R().
		SetHeader("Content-Type", "application/json").
		SetBody(payload).
		Post(d.jsonURL)

	if err != nil || resp.IsError() {
		return "", "", fmt.Errorf("failed to send connection check request: %w", err)
	}

	return "", "", nil
}

func (d DelugeClient) loginDeluge(password string) error {
	payload := map[string]interface{}{
		"method": "auth.login",
		"params": []string{password},
		"id":     d.id,
	}

	var loginResp LoginResponse
	// Send login request
	resp, err := d.client.R().
		SetHeader("Content-Type", "application/json").
		SetBody(payload).
		SetResult(&loginResp).
		Post(d.jsonURL)

	if err != nil {
		return fmt.Errorf("failed to send login request: %w", err)
	}
	if !loginResp.Result || resp.IsError() {
		return fmt.Errorf("login failed: %v", loginResp.Error)
	}

	return nil
}

func (d DelugeClient) uploadFile(torrentPath string) (string, error) {
	type Response struct {
		Success bool     `json:"success"`
		Files   []string `json:"files"`
	}

	var loginResp Response
	resp, err := d.client.R().
		SetFile("file", torrentPath).
		SetResult(&loginResp).
		Post(d.uploadURL)
	if err != nil {
		return "", fmt.Errorf("unable to upload torrent file")
	}

	if !loginResp.Success || resp.IsError() {
		return "", fmt.Errorf("unable to upload file, api returned false")
	}

	uploadedFilePath := loginResp.Files[0]
	if uploadedFilePath == "" {
		return "", fmt.Errorf("file path is empty")
	}

	return uploadedFilePath, nil
}
