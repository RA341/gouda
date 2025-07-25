package mam

import (
	"bytes"
	"encoding/json"
	"fmt"
	"github.com/RA341/gouda/internal/info"
	fu "github.com/RA341/gouda/pkg/file_utils"
	"github.com/rs/zerolog/log"
	"io"
	"maps"
	"net/http"
	"regexp"
	"resty.dev/v3"
	"slices"
	"strconv"
	"strings"
	"time"
)

const IDCookieKey = "mam_id"

// Service holds the necessary information to interact with the MAM API.
type Service struct {
	client *resty.Client
}

// NewService creates a new instance of the MAM service.
func NewService(apiKey string) *Service {
	client := setupClient(apiKey)
	return &Service{
		client: client,
	}
}

// BuyVIP 0 for max
func (s *Service) BuyVIP(durationInWeeks uint) (*BuyVIPResponse, error) {

	dur := ""
	if durationInWeeks == 0 {
		dur = "max"
	} else {
		dur = strconv.Itoa(int(durationInWeeks))
	}

	now := time.Now().Unix()
	vipBase := fmt.Sprintf("/json/bonusBuy.php/?spendtype=VIP&duration=%s&_=%d", dur, now)
	body, err := s.runGet(vipBase)
	if err != nil {
		return nil, err
	}

	var result BuyVIPResponse
	err = parseBuyResponse(body, &result)
	if err != nil {
		return nil, err
	}

	return &result, nil
}

// BuyBonus 0 for max
func (s *Service) BuyBonus(amountInGB uint) (*BuyBonusResponse, error) {
	strAmount := ""
	if amountInGB == 0 {
		strAmount = "Max%20Affordable%20"
	} else {
		strAmount = strconv.Itoa(int(amountInGB))
	}

	now := time.Now().Unix()
	base := fmt.Sprintf("/json/bonusBuy.php/?spendtype=upload&amount=%s&_=%d", strAmount, now)
	body, err := s.runGet(base)
	if err != nil {
		return nil, err
	}

	var result BuyBonusResponse
	err = parseBuyResponse(body, &result)
	if err != nil {
		return nil, err
	}

	return &result, nil
}

func (s *Service) UseFreeleech(torrentID string, leechType LeechType) (*BuyFLResponse, error) {
	timestamp := time.Now().Unix()
	urlPath := fmt.Sprintf(
		"/json/bonusBuy.php/%d?spendtype=%s&torrentid=%s&timestamp=%d",
		timestamp,
		leechType,
		torrentID,
		timestamp,
	)

	body, err := s.runGet(urlPath)
	if err != nil {
		return nil, fmt.Errorf("could not buy free: %w", err)
	}

	var result BuyFLResponse
	err = parseBuyResponse(body, result)
	if err != nil {
		return nil, fmt.Errorf("could not parse body: %w", err)
	}

	log.Debug().Any("result", result).Msg("purchased freeleech successfully")
	return &result, nil
}

// BuyVault todo borken do not use
func (s *Service) BuyVault(amount uint) error {
	if amount > 2000 {
		amount = 2000
	}
	if amount == 0 {
		return fmt.Errorf("amount must be greater than zero")
	}

	now := time.Now()
	timestamp := fmt.Sprintf("%.5f", float64(now.UnixNano())/1e9)

	resp, err := s.client.R().
		SetDebug(true).
		SetHeaders(map[string]string{
			"User-Agent":      "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36",
			"Content-Type":    "application/x-www-form-urlencoded",
			"Referer":         "https://www.myanonamouse.net/millionaires/donate.php?",
			"Origin":          "https://www.myanonamouse.net",
			"Accept":          "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
			"Accept-Encoding": "gzip, deflate",
			"Accept-Language": "en-US,en;q=0.9",
		}).
		SetFormData(map[string]string{
			"Donation": strconv.Itoa(int(amount)),
			"time":     timestamp,
			"submit":   "Donate Points",
		}).
		Post("/millionaires/donate.php")

	if err != nil {
		return fmt.Errorf("could not buy vault: %w", err)
	}

	fmt.Println("Status:", resp.Status())
	fmt.Println("Body:", resp.String())

	return nil
}

// SearchRaw performs a raw search against the torrent database using a JSON-formatted payload.
//
// The payload may include the following fields:
//
// - description (empty): If set, includes the full description in results.
// - dlLink (blank): If set, returns the hash for the torrent download link. Use with:
//   - `https://www.myanonamouse.net/tor/download.php/` + hash (no cookie needed)
//   - `https://www.myanonamouse.net/tor/download.php?tid=#` (with session cookie and torrent ID).
//
// - isbn (set): If set, includes the ISBN field (may-be empty).
// - perpage (int): Number of results per page (5–100).
// - startNumber (int): Number of entries to skip (pagination).
// - tor (array): REQUIRED field.
// - browse_lang ([]int): List of language IDs to include.
// - cat ([]int): List of category IDs to include.
// - endDate (string/int): Date (YYYY-MM-DD) or UNIX timestamp. Torrents must be older than this (exclusive).
// - hash (string): Hexadecimal-encoded torrent hash.
// - main_cat ([]int): IDs of main categories to include. Values:
//   - 13 = AudioBooks, 14 = E-Books, 15 = Musicology, 16 = Radio.
//
// - searchIn (enum): Field(s) to search in (list TBD).
// - searchType (enum): One of:
//   - 'all', 'active', 'inactive', 'fl', 'fl-VIP', 'VIP', 'nVIP', 'nMeta'.
//   - sortType (enum): Sorting method:
//     'titleAsc', 'titleDesc', 'fileAsc', 'fileDesc', 'sizeAsc', 'sizeDesc',
//     'seedersAsc', 'seedersDesc', 'leechersAsc', 'leechersDesc',
//     'snatchedAsc', 'snatchedDesc', 'dateAsc', 'dateDesc',
//     'bmkaAsc', 'bmkaDesc', 'reseedAsc', 'reseedDesc',
//     'categoryAsc', 'categoryDesc', 'random', 'default'.
//   - srchIn ([]string): Fields to perform text-based search in.
//   - author, description, filenames, fileTypes, narrator, series, tags, title (set): Flags to enable text search in specific fields.
//
// - startDate (string/int): Date (YYYY-MM-DD) or UNIX timestamp. Torrents must be newer than or equal to this (inclusive).
//
// - text (string): Text string to search for.
//
// Returns:
// - books ([]Book): List of matching Book entries.
// - found (int): Number of items found in this response.
// - total (int): Total number of items matching the query.
// - err (error): Error, if any occurred during the request.
//
//	{
//		"tor": {
//			"text": "collection cookbooks food test kitchen",
//			"srchIn": [
//				"title",
//				"author",
//				"narrator"
//			],
//			"searchType": "all",
//			"searchIn": "torrents",
//			"cat": ["0"],
//			"browseFlagsHideVsShow": "0",
//			"startDate": "",
//			"endDate": "",
//			"hash": "",
//			"sortType": "default",
//			"startNumber": "0"
//		},
//		"thumbnail": "true"
//	}
func (s *Service) SearchRaw(payload []byte) (books []Book, found int, total int, err error) {
	resp, err := s.client.R().
		SetBody(bytes.NewBuffer(payload)).
		Post("/tor/js/loadSearchJSONbasic.php")
	if err != nil {
		return nil, 0, 0, fmt.Errorf("error sending search request: %w", err)
	}
	defer fu.Close(resp.Body)

	if resp.StatusCode() != http.StatusOK {
		return nil, 0, 0, fmt.Errorf("failed to fetch from MAM: %d", resp.StatusCode())
	}

	body, err := io.ReadAll(resp.Body)
	if err != nil {
		return nil, 0, 0, fmt.Errorf("failed to read response body: %w", err)
	}

	var apiResponse SearchResponse
	if err = json.Unmarshal(body, &apiResponse); err != nil {
		return nil, 0, 0, fmt.Errorf("failed to decode JSON response: %w", err)
	}

	books, _ = processResponseItems(apiResponse.Data)
	return books, apiResponse.Total, apiResponse.TotalFound, nil
}

func (s *Service) runGet(fullpath string) ([]byte, error) {
	resp, err := s.client.R().Get(fullpath)
	if err != nil {
		return nil, fmt.Errorf("failed to make get request: %w", err)
	}

	if resp.StatusCode() != http.StatusOK {
		return nil, fmt.Errorf("invalid status code: %d, message: %s", resp.StatusCode(), string(resp.Bytes()))
	}

	defer fu.Close(resp.Body)
	body, err := io.ReadAll(resp.Body)
	if err != nil {
		return nil, fmt.Errorf("could not read response body: %w", err)
	}

	return body, nil
}

// Buy endpoints return a true or false, parse that first
// and then unmarshal to their respective structs via generics
func parseBuyResponse(data []byte, result any) error {
	// First unmarshal just the `success` field
	var meta struct {
		Success bool `json:"success"`
	}
	if err := json.Unmarshal(data, &meta); err != nil {
		return fmt.Errorf("failed to check success flag: %w", err)
	}

	if !meta.Success {
		return fmt.Errorf("api returned a failed response: %s", string(data))
	}

	if err := json.Unmarshal(data, result); err != nil {
		return fmt.Errorf("failed to parse response: %w", err)
	}

	return nil
}

// processResponseItems iterates over raw API data and converts it into a slice of Book structs.
func processResponseItems(items []SearchResultItem) ([]Book, error) {
	if len(items) == 0 {
		return []Book{}, nil
	}

	books := make([]Book, 0, len(items))
	lengthRegex := regexp.MustCompile(`(?i)(\d+h\d+m|\d+:\d+:\d+|\d+\s?hrs?(\s\d+\s?mins?)?)`)

	for _, item := range items {
		// Parse author info from its JSON string
		author := "Unknown Author"
		if item.AuthorInfo != "" {
			var authorMap map[string]string
			if err := json.Unmarshal([]byte(item.AuthorInfo), &authorMap); err == nil {
				author = strings.Join(slices.Collect(maps.Values(authorMap)), ", ")
			} else {
				log.Printf("Error parsing author info for item %s: %v", item.ID, err)
			}
		}

		// Extract format from filetype or tags
		format := item.Filetype
		if format == "" {
			format = extractFormatFromTags(item.Tags)
		}
		if format == "" {
			format = "Unknown"
		}

		// Fix thumbnail URL to be absolute
		thumbnail := item.Thumbnail
		if thumbnail != "" && !strings.HasPrefix(thumbnail, "http") {
			thumbnail = addBaseUrl(thumbnail)
		}

		// Extract length for audiobooks
		var length string
		if item.MainCat == 13 && item.Description != "" {
			match := lengthRegex.FindStringSubmatch(item.Description)
			if len(match) > 1 {
				length = strings.TrimSpace(match[1])
			}
		}

		baseUrl := addBaseUrl("/tor/download.php")
		downloadURL := fmt.Sprintf("%s%s", baseUrl, item.DL)

		books = append(books, Book{
			ID:          strconv.Itoa(item.ID),
			Title:       item.Title,
			Author:      author,
			Format:      format,
			Length:      length,
			TorrentLink: downloadURL,
			Category:    item.MainCat,
			Thumbnail:   thumbnail,
			Size:        item.Size,
			Seeders:     item.Seeders,
			Leechers:    item.Leechers,
			Added:       item.Added,
			Tags:        item.Tags,
			Completed:   item.TimesCompleted,
		})
	}

	return books, nil
}

// extractFormatFromTags finds a common format from a string of tags.
func extractFormatFromTags(tags string) string {
	commonFormats := []string{"mp3", "m4a", "m4b", "flac", "epub", "mobi", "azw3", "pdf"}
	tagsLower := strings.ToLower(tags)

	for _, format := range commonFormats {
		if strings.Contains(tagsLower, format) {
			return format
		}
	}
	return ""
}

const baseURL = "https://www.myanonamouse.net"

func setupClient(apiKey string) *resty.Client {
	authCookie := &http.Cookie{
		Name:  IDCookieKey,
		Value: apiKey,
	}

	client := resty.New().
		SetCookie(authCookie).
		SetHeader(
			"User-Agent",
			fmt.Sprintf("gouda/%s (+https://github.com/RA341/gouda)", info.Version),
		).
		SetBaseURL(baseURL)

	return client
}

// adds https://www.myanonamouse.net, path must start with '/'
func addBaseUrl(path string) string {
	return fmt.Sprintf("%s%s", baseURL, path)
}
