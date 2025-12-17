package mam

import (
	"encoding/base64"
	"encoding/json"
	"fmt"
	"io"
	"net/http"
	"strconv"
	"strings"
	"time"

	"github.com/RA341/gouda/internal/info"
	sc "github.com/RA341/gouda/internal/server_config"
	fu "github.com/RA341/gouda/pkg/file_utils"
	"github.com/RA341/gouda/pkg/schd"
	"github.com/rs/zerolog/log"
	"resty.dev/v3"
)

const (
	// CookieKeyID Cookie key name for auth
	CookieKeyID     = "mam_id"
	defaultDuration = time.Hour * 24
	PointsPerGB     = 500
)

// Service holds the necessary information to interact with the MAM API.
type Service struct {
	client func() *resty.Client
	conf   ConfigProvider

	scd *schd.Scheduler
}
type ConfigProvider func() *sc.MamConfig

type LoggerConfig func() *sc.Logger

func NewService(config ConfigProvider, logger LoggerConfig) *Service {
	client := setupClient(config, logger)

	interval := config().GetMamInterval(defaultDuration)
	s := &Service{
		client: client,
		conf:   config,
	}
	s.scd = schd.NewScheduler(
		s.autoBuy,
		interval,
	)
	s.scd.Manual()

	return s
}

func NewMamValidator(token string) error {
	provider := func() *sc.MamConfig {
		return &sc.MamConfig{MamToken: token}
	}
	logger := func() *sc.Logger {
		return &sc.Logger{
			Verbose: false,
		}
	}

	client := setupClient(provider, logger)
	service := Service{
		client: client,
		conf:   provider,
	}
	return service.IsMamSetup()
}

func (s *Service) autoBuy() {
	log.Info().Msg("starting autobuy")

	var availableBonus float64 = 0

	if s.conf().AutoBuyVip {
		vip, err := s.BuyVIP(0)
		if err != nil {
			log.Warn().Err(err).Msg("unable buy vip")
		} else {
			log.Info().Any("vip", vip).Msg("bought vip weeks")
			availableBonus = vip.SeedBonus
		}
	} else {
		log.Info().Msg("AutoBuy vip is disabled, skipping....")
	}

	if s.conf().AutoBuyBonus {
		gbToBuy := 0
		if availableBonus == 0 {
			profile, err := s.GetProfile()
			if err != nil {
				log.Warn().Err(err).Msg("unable to get profile, available points will be 0")
			} else {
				availableBonus = float64(profile.Seedbonus)
			}
		}

		minPointsToKeep := float64(s.conf().MinPointsToKeep)
		if availableBonus > minPointsToKeep {
			gbToBuy = int((availableBonus - minPointsToKeep) / PointsPerGB)
			log.Info().Int("gb", gbToBuy).Msg("buying bonus")
			bonus, err := s.BuyBonus(uint(gbToBuy))
			if err != nil {
				log.Warn().Err(err).Msg("unable buy bonus")
			} else {
				log.Info().Any("bonus", bonus).Msg("bought bonus points")
			}
		} else {
			log.Info().
				Float64("available", availableBonus).
				Float64("minimum required", minPointsToKeep).
				Msg("Insufficient Bonus, skipping")
		}
	} else {
		log.Info().Msg("AutoBuy bonus is disabled, skipping....")
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

// Divides a number into the specified integer intervals: 100, 20, 5, 1.
// since mam requires the gb to be 100, 20, 5, 1 GB
// It returns a slice of the gbs to buy dividing the original amount.
func divideIntoMamGBAmounts(num uint) []uint {
	n := num
	intervals := []uint{100, 20, 5, 1}

	var result []uint
	for _, interval := range intervals {
		count := n / interval

		for i := uint(0); i < count; i++ {
			result = append(result, interval)
			n -= interval
		}
	}

	return result
}

// BuyBonus 0 for max
func (s *Service) BuyBonus(amountInGB uint) (*BuyBonusResponse, error) {
	strAmount := ""
	if amountInGB == 0 {
		strAmount = "Max%20Affordable%20"
		return s.buyBonusRequest(strAmount)
	}

	res := divideIntoMamGBAmounts(amountInGB)
	log.Debug().Uints("amounts", res).Msg("buying amounts")
	var errs error
	var resp *BuyBonusResponse

	for _, amount := range res {
		var err error
		resp, err = s.buyBonusRequest(strconv.Itoa(int(amount)))

		if err != nil {
			currentErr := fmt.Errorf("buyBonus Amount: %d failed: %w", amount, err)
			if errs != nil {
				errs = fmt.Errorf("%w\n%w", currentErr, errs)
			} else {
				errs = currentErr
			}
		}

		log.Debug().Any("response", resp).Msg("bought amount")

		time.Sleep(time.Second * 2)
	}

	return resp, errs
}

// strAmount
func (s *Service) buyBonusRequest(amount string) (*BuyBonusResponse, error) {
	now := time.Now().Unix()
	base := fmt.Sprintf("/json/bonusBuy.php/?spendtype=upload&amount=%s&_=%d", amount, now)
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

func (s *Service) SafeGetProfile() (*UserData, error) {
	key := s.conf().MamToken
	if key == "" {
		return nil, fmt.Errorf("mam api key is empty")
	}

	return s.GetProfile()
}

func (s *Service) IsMamSetup() error {
	_, err := s.SafeGetProfile()
	return err
}

func (s *Service) GetProfile() (*UserData, error) {
	resp, err := s.client().R().Post("/jsonLoad.php")
	if err != nil {
		return nil, err
	}

	if resp.IsError() {
		return nil, fmt.Errorf("error occured while making request: %s\nBody:\n%s", resp.Status(), resp.String())
	}

	var userResp UserData
	if err = json.Unmarshal(resp.Bytes(), &userResp); err != nil {
		return nil, fmt.Errorf("failed to decode JSON response: %w", err)
	}

	return &userResp, nil
}

func (s *Service) GetBonusProfile() (*UserData, error) {
	resp, err := s.client().R().Post("/json/userBonusHistory.php")
	if err != nil {
		return nil, err
	}

	if resp.IsError() {
		return nil, fmt.Errorf("error occured while making request: %s\nBody:\n%s", resp.Status(), resp.String())
	}

	sd := resp.String()
	fmt.Println(sd)

	//var userResp UserData
	//if err = json.Unmarshal(resp.Bytes(), &userResp); err != nil {
	//	return nil, fmt.Errorf("failed to decode JSON response: %w", err)
	//}

	return nil, nil
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
	err = parseBuyResponse(body, &result)
	if err != nil {
		return nil, fmt.Errorf("could not parse body: %w", err)
	}

	log.Debug().Any("result", result).Msg("purchased freeleech successfully")
	return &result, nil
}

// BuyVault todo borken do not use
func (s *Service) BuyVault(apiKey string, amount uint) error {
	if amount > 2000 {
		amount = 2000
	}
	if amount == 0 {
		return fmt.Errorf("amount must be greater than zero")
	}

	// todo
	uid := ""

	now := time.Now()
	timestamp := fmt.Sprintf("%.5f", float64(now.UnixNano())/1e9)

	resp, err := resty.New().R().
		SetDebug(true).
		SetHeaders(map[string]string{
			"Content-Type": "application/x-www-form-urlencoded",
			"Origin":       "https://www.myanonamouse.net",
			"Referer":      "https://www.myanonamouse.net/millionaires/donate.php",
			"User-Agent":   "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36",
		}).
		SetCookie(&http.Cookie{Name: "uid", Value: uid}).
		SetCookie(&http.Cookie{
			Name:  CookieKeyID,
			Value: apiKey,
		}).
		SetFormData(map[string]string{
			"Donation": strconv.Itoa(int(amount)),
			"time":     timestamp,
			"submit":   "Donate Points",
		}).
		Post("https://www.myanonamouse.net/millionaires/donate.php")
	if err != nil {
		return fmt.Errorf("could not buy vault: %w", err)
	}

	st := resp.String()

	fmt.Println("Status:", resp.Status())
	fmt.Println("Body:", st)

	//resp, err := s.client().R().
	//	SetDebug(true).
	//	SetHeaders(map[string]string{
	//		"User-Agent":      "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36",
	//		"Content-Type":    "application/x-www-form-urlencoded",
	//		"Referer":         "https://www.myanonamouse.net/millionaires/donate.php?",
	//		"Origin":          "https://www.myanonamouse.net",
	//		"Accept":          "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
	//		"Accept-Encoding": "gzip, deflate",
	//		"Accept-Language": "en-US,en;q=0.9",
	//	}).
	//	SetFormData(map[string]string{
	//		"Donation": strconv.Itoa(int(amount)),
	//		"time":     timestamp,
	//		"submit":   "Donate Points",
	//	}).
	//	Post("/millionaires/donate.php")
	//
	//if err != nil {
	//	return fmt.Errorf("could not buy vault: %w", err)
	//}

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
// - books ([]title): List of matching title entries.
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
func (s *Service) SearchRaw(payload map[string]any) (books []SearchBook, found int, total int, err error) {
	// always get description and dl-links
	payload["description"] = ""
	payload["dlLink"] = ""
	payload["thumbnail"] = "true"

	resp, err := s.client().R().
		SetBody(payload).
		Post("/tor/js/loadSearchJSONbasic.php")
	if err != nil {
		return nil, found, total, fmt.Errorf("error sending search request: %w", err)
	}
	defer fu.Close(resp.Body)

	if resp.StatusCode() != http.StatusOK {
		return nil, found, total, fmt.Errorf("failed to fetch from MAM: %d", resp.StatusCode())
	}

	body := resp.Bytes()

	var apiResponse SearchResult
	if err = json.Unmarshal(body, &apiResponse); err != nil {
		return nil, found, total, fmt.Errorf("failed to decode JSON response: %w", err)
	}

	books, err = processResponseItems(apiResponse.Data)
	if err != nil {
		return nil, found, total, fmt.Errorf("failed to clean response: %w", err)
	}

	return books, apiResponse.Found, apiResponse.Total, nil
}

func (s *Service) runGet(path string) ([]byte, error) {
	resp, err := s.client().R().Get(path)
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

func (s *Service) DownloadTorrentFile(link string) (io.ReadCloser, error) {
	resp, err := s.client().R().Get(link)
	if err != nil {
		return nil, fmt.Errorf("unable to download torrent file: %w", err)
	}

	if resp.StatusCode() != http.StatusOK {
		return nil, fmt.Errorf("invalid status code: %d, message: %s", resp.StatusCode(), string(resp.Bytes()))
	}

	return resp.Body, nil
}

// Buy endpoints return a true or false, parse that first
// and then unmarshal to their respective structs via generics
func parseBuyResponse(data []byte, result any) error {
	// First unmarshal just the `success` field
	var meta struct {
		Success bool   `json:"success"`
		Error   string `json:"error"`
	}
	if err := json.Unmarshal(data, &meta); err != nil {
		return fmt.Errorf("failed to check success flag: %w", err)
	}

	if !meta.Success {
		if meta.Error == "This is already a personal freeleech" {
			return nil
		}
		return fmt.Errorf("api returned a failed response: %s", string(data))
	}

	if err := json.Unmarshal(data, result); err != nil {
		return fmt.Errorf("failed to parse response: %w", err)
	}

	return nil
}

/*
{
	"id" : 1173876,

	"title" : "When We Meet Again",
	"series_info" : ""{\"126732\": [\"Rainey Paxton\", \"3\"]}"",
	"author_info" : "{\"325312\": \"Hayden Hall\"}",
	"narrator_info" : "{\"44239\": \"Curtis Michael Holland\"}",
	"thumbnail": ""
	"tags" : "96Kb 2 channel Stereo",
	"owner_name" : "",
	"owner" : 0,
	"added" : "2025-08-17 04:03:33",
	"bookmarked" : null,
    "my_snatched" : 0,

	"language" : 1,
	"lang_code" : "ENG",

	"main_cat" : 13, <- audiobook/ebooks/etc
	"category" : 46,
	"catname" : "Audiobooks - Romance",

	"size" : "296.0 MiB",
	"filetype" : "m4b",
	"numfiles" : 1,
	"seeders" : 26,
	"leechers" : 0,
    "times_completed" : 28,

	"vip" : 1,
	"free" : 0,
	"personal_freeleech" : 0,
	"fl_vip" : 1,

	"w" : 1,
	"browseflags" : 64,
	"comments" : 0,
	"cat" : "<div class=\"cat46\">&nbsp;</div>"
}
*/
// processResponseItems iterates over raw API data and converts it into a slice of title structs.
func processResponseItems(items []SearchBookRaw) ([]SearchBook, error) {
	if len(items) == 0 {
		return []SearchBook{}, nil
	}

	books := make([]SearchBook, 0, len(items))
	for _, item := range items {
		bk := SearchBook{
			MamID: item.Id,
			Title: item.Title,
			// todo thumbnail are protected, make a proxy endpoint
			Thumbnail:     processThumbnails(&item),
			Description:   item.Description,
			// Author:        authors,
			// Narrator:      narrators,
			UploaderName:  item.OwnerName,
			// Series:        series,
			Tags:          item.Tags,
			DateAddedIso:  item.Added,
			Snatched:      item.MySnatched != 0,
			LanguageCode:  item.LangCode,
			MediaCategory: getMediaCategory(item.MainCat),
			CategoryID:    item.Category,
			CategoryName:  item.Catname,
			MediaFormat:   item.Filetype,
			MediaSize:     item.Size,
			Seeders:       item.Seeders,
			Leechers:      item.Leechers,
			Completed:     item.TimesCompleted,
			TorrentLink:   appendMamDownloadBase(item.Dl),
		}
		
		authors, err := parseAuthorInfo(item.AuthorInfo)
		if err != nil {
			log.Warn().Err(err).
				Str("authorInfoRaw", item.AuthorInfo).
				Msg("failed to parse author info")
		} else {
			bk.Author = authors
		}

		narrators, err := parseAuthorInfo(item.NarratorInfo)
		if err != nil {
			log.Warn().Err(err).
				Str("narratorInfoRaw", item.AuthorInfo).
				Msg("failed to parse narrator info")
		} else {
			bk.Narrator = narrators
		}

		series, err := parseSeriesInfo(item.SeriesInfo)
		if err != nil {
			log.Warn().Err(err).
				Str("seriesInfoRaw", item.SeriesInfo).
				Msg("failed to parse series info")
		} else {
			bk.Series = series
		}

		books = append(books, bk)
	}

	return books, nil
}

const cdnPrefix = "https://cdn.myanonamouse.net"

func (s *Service) getThumbnail(encodedLink string) ([]byte, error) {
	decoded, err := base64.StdEncoding.DecodeString(encodedLink)
	if err != nil {
		return nil, fmt.Errorf("failed to base64 decode thumbnail: %w", err)
	}

	r := s.client().R()
	resp, err := r.SetCookies(s.client().Cookies()).Get(cdnPrefix + string(decoded))
	if err != nil {
		return nil, err
	}

	if !resp.IsSuccess() {
		return nil, fmt.Errorf("invalid status code: %d, message: %s", resp.StatusCode(), resp.String())
	}

	return resp.Bytes(), nil
}

func processThumbnails(item *SearchBookRaw) string {
	// encode this string
	// /tor/poster_mini.php/321883/jpeg
	clean := strings.TrimPrefix(item.Thumbnail, cdnPrefix)
	encoded := base64.StdEncoding.EncodeToString([]byte(clean))
	return encoded
}

func appendMamDownloadBase(dl string) string {
	const mamDownloadBase = "https://www.myanonamouse.net/tor/download.php/"
	return fmt.Sprintf("%s%s", mamDownloadBase, dl)
}

func getMediaCategory(cat int) string {
	switch cat {
	case 13:
		return "AudioBooks"
	case 14:
		return "EBooks"
	case 15:
		return "Musicology"
	case 16:
		return "Radio"
	default:
		return "Unknown"
	}
}

// expected format
// "series_info" : "{\"4364\": [\"The Hitchhiker&#039;s Guide to the Galaxy\", \"1 - 5\"]}",
func parseSeriesInfo(seriesInfo string) ([]Series, error) {
	if seriesInfo == "" {
		return []Series{}, nil
	}

	var data map[string][]string
	err := json.Unmarshal([]byte(seriesInfo), &data)
	if err != nil {
		return nil, fmt.Errorf("failed to parse author info: %w", err)
	}

	var result []Series
	for k, v := range data {
		result = append(result, Series{
			ID:             k,
			Name:           v[0],
			SequenceNumber: v[1],
		})
	}
	return result, nil
}

// expected format
// "{\"3481\": \"Martin Freeman\", \"18954\": \"Stephen Fry\"}",
func parseAuthorInfo(authorRaw string) ([]Author, error) {
	if authorRaw == "" {
		return []Author{}, nil
	}

	var authorInfo map[string]string
	err := json.Unmarshal([]byte(authorRaw), &authorInfo)
	if err != nil {
		return nil, fmt.Errorf("failed to parse author info: %w", err)
	}

	var authors []Author
	for id, name := range authorInfo {
		authors = append(authors, Author{
			ID:   id,
			Name: name,
		})
	}

	return authors, nil
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

func setupClient(provider ConfigProvider, logger LoggerConfig) func() *resty.Client {
	return func() *resty.Client {
		authCookie := &http.Cookie{
			Name:  CookieKeyID,
			Value: provider().MamToken,
		}
		client := resty.New().
			SetCookie(authCookie).
			SetHeader(
				"User-Agent",
				fmt.Sprintf("gouda/%s (+https://github.com/RA341/gouda)", info.Version),
			).
			SetBaseURL(baseURL)

		if logger().Verbose || info.IsDev() {
			client.EnableDebug()
		}

		return client
	}
}

// adds https://www.myanonamouse.net, path must start with '/'
func addBaseUrl(path string) string {
	return fmt.Sprintf("%s%s", baseURL, path)
}
