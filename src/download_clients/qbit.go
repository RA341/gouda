package download_clients

import (
	"bytes"
	"encoding/json"
	"fmt"
	"github.com/hekmon/transmissionrpc/v3"
	"github.com/rs/zerolog/log"
	"io"
	"mime/multipart"
	"net/http"
	"net/url"
	"os"
	"path/filepath"
)

type TorrentInfo struct {
	Name     string `json:"name"`
	SavePath string `json:"save_path"`
	State    string `json:"state"`
	Hash     string `json:"hash"`
	Category string `json:"category"`
}

type APIVersion struct {
	Version string `json:"version"`
}

type QbitClient struct {
	BaseURL    string
	HTTPClient *http.Client
	Cookie     *http.Cookie
}

// defaultQbitTransport custom transport to define referrer headers in all qbit requests
// ref: https://stackoverflow.com/questions/54088660/add-headers-for-each-http-request-using-client
type defaultQbitTransport struct {
	defaultHeaders map[string]string
}

func (t *defaultQbitTransport) RoundTrip(req *http.Request) (*http.Response, error) {
	for key, value := range t.defaultHeaders {
		req.Header.Set(key, value)
	}
	return http.DefaultTransport.RoundTrip(req)
}

func InitQbit(qbitUrl, protocol, user, pass string) (DownloadClient, error) {
	clientStr := fmt.Sprintf("%s://%s", protocol, qbitUrl)
	customTransport := defaultQbitTransport{
		defaultHeaders: map[string]string{
			"Referer": fmt.Sprintf("%s://%s", protocol, qbitUrl),
		},
	}

	client := &QbitClient{
		BaseURL:    clientStr,
		HTTPClient: &http.Client{Transport: &customTransport},
		Cookie:     nil,
	}

	err := client.Login(user, pass)
	if err != nil {
		return nil, fmt.Errorf("failed to login: %s", err)
	}

	return client, nil
}

func (qbitClient *QbitClient) DownloadTorrent(torrent string, downloadPath string) (string, error) {
	torrentResult, err := qbitClient.AddTorrent(torrent, downloadPath, "")
	if err != nil {
		return "", err
	}

	return torrentResult, nil
}

func (qbitClient *QbitClient) Health() (string, string, error) {
	serverVersion, err := qbitClient.GetAPIVersion()
	if err != nil {
		return "", "", err
	}

	// todo
	if serverVersion == "" {
		return "", "", fmt.Errorf("qbit version (v%s)", serverVersion)
	}

	return "qbit", fmt.Sprintf("Qbit (v%s) is compatible (v%d)\n",
		serverVersion, transmissionrpc.RPCVersion), nil
}

func (qbitClient *QbitClient) CheckTorrentStatus(torrentIds string) (TorrentStatus, error) {
	info, err := qbitClient.CheckStatus(torrentIds)
	if err != nil {
		return TorrentStatus{}, err
	}

	complete := false
	if info.State == "uploading" {
		complete = true
	}

	return TorrentStatus{
		Name:             info.Name,
		DownloadPath:     info.SavePath,
		DownloadComplete: complete,
		Status:           info.State,
	}, nil
}

// Login authenticates with the qBittorrent WebUI
func (qbitClient *QbitClient) Login(username, password string) error {
	data := url.Values{}
	data.Set("username", username)
	data.Set("password", password)

	resp, err := qbitClient.HTTPClient.PostForm(qbitClient.BaseURL+"/api/v2/auth/login", data)
	if err != nil {
		return fmt.Errorf("login request failed: %w", err)
	}
	defer func(Body io.ReadCloser) {
		err := Body.Close()
		if err != nil {
			log.Error().Err(err).Msg("failed to close response body")
		}
	}(resp.Body)

	if resp.StatusCode == http.StatusForbidden {
		return fmt.Errorf("login failed: IP is banned for too many failed attempts")
	}

	if resp.StatusCode != http.StatusOK {
		return fmt.Errorf("login failed with status: %d", resp.StatusCode)
	}

	// Store the SID cookie
	for _, cookie := range resp.Cookies() {
		if cookie.Name == "SID" {
			qbitClient.Cookie = cookie
			return nil
		}
	}

	return fmt.Errorf("no SID cookie found in response")
}

// GetAPIVersion retrieves the WebAPI version
func (qbitClient *QbitClient) GetAPIVersion() (string, error) {
	req, err := http.NewRequest("GET", qbitClient.BaseURL+"/api/v2/app/webapiVersion", nil)
	if err != nil {
		return "", fmt.Errorf("failed to create request: %w", err)
	}

	if qbitClient.Cookie != nil {
		req.AddCookie(qbitClient.Cookie)
	}

	resp, err := qbitClient.HTTPClient.Do(req)
	if err != nil {
		return "", fmt.Errorf("version request failed: %w", err)
	}
	defer func(Body io.ReadCloser) {
		err := Body.Close()
		if err != nil {
			log.Error().Err(err).Msg("failed to close response body")
		}
	}(resp.Body)

	if resp.StatusCode != http.StatusOK {
		return "", fmt.Errorf("failed to get version, status: %d", resp.StatusCode)
	}

	version, err := io.ReadAll(resp.Body)
	if err != nil {
		return "", fmt.Errorf("failed to read version response: %w", err)
	}

	return string(version), nil
}

// AddTorrent uploads a torrent file and starts downloading
func (qbitClient *QbitClient) AddTorrent(torrentFilePath, downloadPath string, category string) (string, error) {
	body := &bytes.Buffer{}
	writer := multipart.NewWriter(body)

	// Add the torrent file
	file, err := writer.CreateFormFile("torrents", filepath.Base(torrentFilePath))
	if err != nil {
		return "", fmt.Errorf("failed to create form file: %w", err)
	}

	torrentData, err := os.ReadFile(torrentFilePath)
	if err != nil {
		return "", fmt.Errorf("failed to read torrent file: %w", err)
	}

	if _, err = file.Write(torrentData); err != nil {
		return "", fmt.Errorf("failed to write torrent data: %w", err)
	}

	// Add the save path
	if err = writer.WriteField("savepath", downloadPath); err != nil {
		return "", fmt.Errorf("failed to add save path: %w", err)
	}

	// Add category if provided
	if category != "" {
		if err = writer.WriteField("category", category); err != nil {
			return "", fmt.Errorf("failed to add category: %w", err)
		}
	}

	if err = writer.Close(); err != nil {
		return "", fmt.Errorf("failed to close multipart writer: %w", err)
	}

	req, err := http.NewRequest("POST", qbitClient.BaseURL+"/api/v2/torrents/add", body)
	if err != nil {
		return "", fmt.Errorf("failed to create request: %w", err)
	}

	req.Header.Set("Content-Type", writer.FormDataContentType())
	if qbitClient.Cookie != nil {
		req.AddCookie(qbitClient.Cookie)
	}

	resp, err := qbitClient.HTTPClient.Do(req)
	if err != nil {
		return "", fmt.Errorf("add torrent request failed: %w", err)
	}
	defer func(Body io.ReadCloser) {
		err := Body.Close()
		if err != nil {
			log.Fatal().Err(err).Msg("failed to close response body")
		}
	}(resp.Body)

	if resp.StatusCode != http.StatusOK {
		return "", fmt.Errorf("failed to add torrent, status: %d", resp.StatusCode)
	}

	// Get the hash from torrent list
	torrents, err := qbitClient.getTorrentList()
	if err != nil {
		return "", fmt.Errorf("failed to get torrent hash: %w", err)
	}

	// Return the hash of the most recently added torrent
	if len(torrents) > 0 {
		return torrents[len(torrents)-1].Hash, nil
	}

	return "", fmt.Errorf("torrent was added but hash not found")
}

// CheckStatus retrieves the current status of a torrent by its hash
func (qbitClient *QbitClient) CheckStatus(hash string) (*TorrentInfo, error) {
	req, err := http.NewRequest("GET", fmt.Sprintf("%s/api/v2/torrents/info?hashes=%s", qbitClient.BaseURL, hash), nil)
	if err != nil {
		return nil, fmt.Errorf("failed to create request: %w", err)
	}

	if qbitClient.Cookie != nil {
		req.AddCookie(qbitClient.Cookie)
	}

	resp, err := qbitClient.HTTPClient.Do(req)
	if err != nil {
		return nil, fmt.Errorf("status request failed: %w", err)
	}
	defer func(Body io.ReadCloser) {
		err := Body.Close()
		if err != nil {
			log.Fatal().Err(err).Msg("failed to close response body")
		}
	}(resp.Body)

	if resp.StatusCode != http.StatusOK {
		return nil, fmt.Errorf("failed to get status, status code: %d", resp.StatusCode)
	}

	var torrents []TorrentInfo
	if err := json.NewDecoder(resp.Body).Decode(&torrents); err != nil {
		return nil, fmt.Errorf("failed to decode response: %w", err)
	}

	if len(torrents) == 0 {
		return nil, fmt.Errorf("torrent not found")
	}

	return &torrents[0], nil
}

// Helper function to get torrent list
func (qbitClient *QbitClient) getTorrentList() ([]TorrentInfo, error) {
	req, err := http.NewRequest("GET", qbitClient.BaseURL+"/api/v2/torrents/info", nil)
	if err != nil {
		return nil, err
	}

	if qbitClient.Cookie != nil {
		req.AddCookie(qbitClient.Cookie)
	}

	resp, err := qbitClient.HTTPClient.Do(req)
	if err != nil {
		return nil, err
	}
	defer func(Body io.ReadCloser) {
		err := Body.Close()
		if err != nil {
			log.Fatal().Err(err).Msg("failed to close response body")
		}
	}(resp.Body)

	var torrents []TorrentInfo
	if err := json.NewDecoder(resp.Body).Decode(&torrents); err != nil {
		return nil, err
	}

	return torrents, nil
}
