package clients

import (
	"fmt"
	"github.com/RA341/gouda/pkg/magnet"
	"github.com/hekmon/transmissionrpc/v3"
	"net/http"
	"net/url"
	"os"
	"resty.dev/v3"
	"strings"
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

func NewQbitClient(client *TorrentClient) (DownloadClient, error) {
	clientStr := fmt.Sprintf("%s://%s", client.Protocol, client.Host)
	qbit := &QbitClient{
		BaseURL: clientStr,
		defaultHeaders: map[string]string{
			"Referer": fmt.Sprintf("%s://%s", client.Protocol, client.Host),
		},
	}

	err := qbit.login(client.User, client.Password)
	if err != nil {
		return nil, fmt.Errorf("failed to login: %s", err)
	}

	return qbit, nil
}

type QbitClient struct {
	BaseURL        string
	defaultHeaders map[string]string
	cookie         *http.Cookie
}

func (qb *QbitClient) sendAddTorrentRequest(baseRequest *resty.Request) error {
	resp, err := baseRequest.Post(qb.BaseURL + "/api/v2/torrents/add")
	if err != nil {
		return fmt.Errorf("failed to call qbit api: %w", err)
	}

	if resp.IsError() {
		return fmt.Errorf("failed to add torrent, your torrent may be invalid, status: %d", resp.StatusCode())
	}

	return nil
}

func (qb *QbitClient) DownloadTorrentWithMagnet(magnetURL, downloadPath, category string) (string, error) {
	err := qb.sendAddTorrentRequest(
		qb.getBaseClient().
			SetMultipartFormData(map[string]string{
				"savepath": downloadPath,
				"category": category,
				"urls":     magnetURL,
			}),
	)
	if err != nil {
		return "", err
	}

	// qbit uses sha1 hash as ids
	component, err := magnet.DecodeMagnetURL(magnetURL)
	if err != nil {
		return "", err
	}

	return component.InfoHash, nil

}

func (qb *QbitClient) DownloadTorrentWithFile(torrent, downloadPath, category string) (string, error) {
	err := qb.sendAddTorrentRequest(
		qb.getBaseClient().
			SetFile("torrents", torrent).
			SetMultipartFormData(map[string]string{
				"savepath": downloadPath,
				"category": category,
			}),
	)
	if err != nil {
		return "", err
	}

	file, err := os.Open(torrent)
	if err != nil {
		return "", err
	}

	toMagnet, err := magnet.TorrentFileToMagnet(file)
	if err != nil {
		return "", err
	}

	torrentComponent, err := magnet.DecodeMagnetURL(toMagnet)
	if err != nil {
		return "", err
	}

	return torrentComponent.InfoHash, nil
}

func (qb *QbitClient) GetTorrentStatus(torrentIds ...string) ([]TorrentStatus, error) {
	torrents, err := qb.getTorrentListByHashes(torrentIds...)
	if err != nil {
		return []TorrentStatus{}, err
	}

	var result []TorrentStatus

	for _, torrent := range torrents {
		status := Downloading
		if torrent.State == "uploading" || torrent.State == "stalledUP" || torrent.State == "forcedUP" {
			status = Complete
		} else if torrent.State == "error" {
			status = Error
		}

		result = append(result, TorrentStatus{
			Name:         torrent.Name,
			DownloadPath: torrent.SavePath,
			ParsedStatus: status,
			ClientStatus: torrent.State,
			ID:           torrent.Hash,
		})
	}

	return result, nil
}

func (qb *QbitClient) Test() (string, string, error) {
	serverVersion, err := qb.getAPIVersion()
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

// login authenticates with the qBittorrent WebUI
func (qb *QbitClient) login(username, password string) error {
	data := url.Values{}
	data.Set("username", username)
	data.Set("password", password)

	resp, err := resty.New().R().
		SetHeaders(qb.defaultHeaders).
		SetFormDataFromValues(data).
		Post(qb.BaseURL + "/api/v2/auth/login")

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
			qb.cookie = cookie
			return nil
		}
	}

	return fmt.Errorf("no SID cookie found in response")
}

// getTorrentListByHashes retrieves the status of a torrent by its hash
func (qb *QbitClient) getTorrentListByHashes(hashes ...string) ([]TorrentInfo, error) {
	if len(hashes) == 0 {
		return nil, fmt.Errorf("hash list is empty")
	}

	finalHashQuery := ""
	for _, hash := range hashes {
		finalHashQuery += fmt.Sprintf("|%s", hash)
	}
	finalHashQuery = strings.Trim(finalHashQuery, "|")

	var torrents []TorrentInfo
	resp, err := resty.New().R().
		SetCookie(qb.cookie).
		SetHeaders(qb.defaultHeaders).
		SetResult(&torrents).
		Get(fmt.Sprintf("%s/api/v2/torrents/info?hashes=%s", qb.BaseURL, finalHashQuery))

	if err != nil {
		return nil, fmt.Errorf("request failed: %w", err)
	}

	if resp.IsError() {
		return nil, fmt.Errorf("unable to get torrents, code: %d, body: %s", resp.StatusCode(), resp.String())
	}

	if len(torrents) == 0 {
		return nil, fmt.Errorf("torrent list is empty")
	}

	return torrents, nil
}

// getAPIVersion retrieves the WebAPI version
func (qb *QbitClient) getAPIVersion() (string, error) {
	resp, err := resty.New().R().
		SetCookie(qb.cookie).
		Get(qb.BaseURL + "/api/v2/app/webapiVersion")
	if err != nil {
		return "", fmt.Errorf("failed to call qbit: %w", err)
	}

	if resp.StatusCode() != http.StatusOK {
		return "", fmt.Errorf("failed to get version, status: %d", resp.StatusCode())
	}

	return resp.String(), nil
}

func (qb *QbitClient) getBaseClient() *resty.Request {
	return resty.New().R().
		SetCookie(qb.cookie)
}
