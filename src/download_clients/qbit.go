package download_clients

import (
	"fmt"
	models "github.com/RA341/gouda/models"
	"github.com/go-resty/resty/v2"
	"github.com/hekmon/transmissionrpc/v3"
	"net/http"
	"net/url"
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
	BaseURL        string
	defaultHeaders *map[string]string
	cookie         *http.Cookie
}

func InitQbit(qbitUrl, protocol, user, pass string) (models.DownloadClient, error) {
	clientStr := fmt.Sprintf("%s://%s", protocol, qbitUrl)
	client := &QbitClient{
		BaseURL: clientStr,
		defaultHeaders: &map[string]string{
			"Referer": fmt.Sprintf("%s://%s", protocol, qbitUrl),
		},
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

func (qbitClient *QbitClient) CheckTorrentStatus(torrentIds []string) ([]models.TorrentStatus, error) {
	infos, err := qbitClient.CheckStatus(torrentIds)
	if err != nil {
		return []models.TorrentStatus{}, err
	}

	var result []models.TorrentStatus

	for _, info := range *infos {
		complete := false
		if info.State == "uploading" {
			complete = true
		}

		result = append(result, models.TorrentStatus{
			Name:             info.Name,
			DownloadPath:     info.SavePath,
			DownloadComplete: complete,
			Status:           info.State,
			ID:               info.Hash,
		})
	}

	return result, nil
}

// Login authenticates with the qBittorrent WebUI
func (qbitClient *QbitClient) Login(username, password string) error {
	data := url.Values{}
	data.Set("username", username)
	data.Set("password", password)

	resp, err := resty.New().R().
		SetHeaders(*qbitClient.defaultHeaders).
		SetFormDataFromValues(data).
		Post(qbitClient.BaseURL + "/api/v2/auth/login")

	if err != nil {
		return fmt.Errorf("login request failed: %w", err)
	}

	if resp.StatusCode() == http.StatusForbidden {
		return fmt.Errorf("login failed: IP is banned for too many failed attempts")
	}

	if resp.StatusCode() != http.StatusOK {
		return fmt.Errorf("login failed with status: %d", resp.StatusCode())
	}

	// Store the SID cookie
	for _, cookie := range resp.Cookies() {
		if cookie.Name == "SID" {
			qbitClient.cookie = cookie
			return nil
		}
	}

	return fmt.Errorf("no SID cookie found in response")
}

// GetAPIVersion retrieves the WebAPI version
func (qbitClient *QbitClient) GetAPIVersion() (string, error) {
	resp, err := resty.New().R().
		SetCookie(qbitClient.cookie).
		Get(qbitClient.BaseURL + "/api/v2/app/webapiVersion")
	if err != nil {
		return "", fmt.Errorf("failed to call qbit: %w", err)
	}

	if resp.StatusCode() != http.StatusOK {
		return "", fmt.Errorf("failed to get version, status: %d", resp.StatusCode())
	}

	return resp.String(), nil
}

// AddTorrent uploads a torrent file and starts downloading
func (qbitClient *QbitClient) AddTorrent(torrentFilePath, downloadPath string, category string) (string, error) {
	resp, err := resty.New().R().
		SetCookie(qbitClient.cookie).
		SetFile("torrents", torrentFilePath).
		SetMultipartFormData(map[string]string{
			"savepath": downloadPath,
			"category": category,
		}).
		Post(qbitClient.BaseURL + "/api/v2/torrents/add")

	if err != nil {
		return "", fmt.Errorf("failed to call qbit api: %w", err)
	}

	if resp.StatusCode() != http.StatusOK {
		return "", fmt.Errorf("failed to add torrent, status: %d", resp.StatusCode())
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

// Helper function to get torrent list
func (qbitClient *QbitClient) getTorrentList() ([]TorrentInfo, error) {
	var torrents []TorrentInfo
	resp, err := resty.New().R().
		SetCookie(qbitClient.cookie).
		SetResult(&torrents).
		Get(qbitClient.BaseURL + "/api/v2/torrents/info")

	if err != nil {
		return nil, err
	}

	if resp.StatusCode() != http.StatusOK {
		return nil, fmt.Errorf("failed to list torrents, status: %d, body:%s", resp.StatusCode(), resp.String())
	}

	return torrents, nil
}

// CheckStatus retrieves the current status of a torrent by its hash
func (qbitClient *QbitClient) CheckStatus(hashes []string) (*[]TorrentInfo, error) {
	if hashes == nil || len(hashes) == 0 {
		return nil, fmt.Errorf("hashlist is empty")
	}

	finalHashQuery := ""
	for _, hash := range hashes {
		finalHashQuery = fmt.Sprintf("%s|%s", finalHashQuery, hash)
	}

	var torrents []TorrentInfo
	resp, err := resty.New().R().
		SetHeaders(*qbitClient.defaultHeaders).
		SetResult(&torrents).
		Get(fmt.Sprintf("%s/api/v2/torrents/info?hashes=%s", qbitClient.BaseURL, finalHashQuery))

	if err != nil {
		return nil, fmt.Errorf("failed to get status, request failed: %d", resp.StatusCode())
	}

	if resp.StatusCode() != http.StatusOK {
		return nil, fmt.Errorf("failed to get status, status code: %d", resp.StatusCode())
	}

	if len(torrents) == 0 {
		return nil, fmt.Errorf("torrent list is empty")
	}

	return &torrents, nil
}
