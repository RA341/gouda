package mam

type LeechType string

var (
	FreeLeechGlobal   LeechType = "gFL"
	FreeLeechPersonal LeechType = "personalFL"
)

type UserData struct {
	Uid             int     `json:"uid"`
	Username        string  `json:"username"`
	Classname       string  `json:"classname"`
	VipUntil        string  `json:"vip_until"`
	Seedbonus       int     `json:"seedbonus"`
	Ratio           float64 `json:"ratio"`
	Downloaded      string  `json:"downloaded"`
	DownloadedBytes int64   `json:"downloaded_bytes"`
	Uploaded        string  `json:"uploaded"`
	UploadedBytes   int64   `json:"uploaded_bytes"`
	CountryCode     string  `json:"country_code"`
	CountryName     string  `json:"country_name"`
}

type BuyFLResponse struct {
	Success   bool   `json:"success"`
	Type      string `json:"type"`
	Seedbonus string `json:"seedbonus"`
	FLleft    int    `json:"FLleft"`
}

type BuyBonusResponse struct {
	Success       bool    `json:"success"`
	Type          string  `json:"type"`
	Amount        float64 `json:"amount"`
	Seedbonus     float64 `json:"seedbonus"`
	Uploaded      int64   `json:"uploaded"`
	Downloaded    int64   `json:"downloaded"`
	UploadFancy   string  `json:"uploadFancy"`
	DownloadFancy string  `json:"downloadFancy"`
	Ratio         float64 `json:"ratio"`
}

type BuyVIPResponse struct {
	Success   bool    `json:"success"`
	Type      string  `json:"type"`
	Amount    float64 `json:"amount"`
	SeedBonus float64 `json:"seedbonus"`
}

type SearchResult struct {
	Perpage int             `json:"perpage"`
	Start   int             `json:"start"`
	Total   int             `json:"total"`
	Found   int             `json:"found"`
	Data    []SearchBookRaw `json:"data"`
}

type Author struct {
	ID   string
	Name string
}

type Series struct {
	ID             string
	Name           string
	SequenceNumber string
}

// SearchBook represents the final, cleaned-up book data.
type SearchBook struct {
	MamID int

	Title        string
	Thumbnail    string
	Author       []Author
	Narrator     []Author
	UploaderName string
	Series       []Series
	Description  string

	Tags         string
	DateAddedIso string
	Snatched     bool
	LanguageCode string

	MediaCategory string
	// genre
	CategoryID   int
	CategoryName string

	// files extensions
	MediaFormat string
	// size in [k/m/g]ib
	MediaSize string
	Seeders   int
	Leechers  int
	Completed int

	TorrentLink string
}

// SearchBookRaw raw api response
// docs: https://www.myanonamouse.net/api/endpoint.php/1/tor/js/loadSearchJSONbasic.php
type SearchBookRaw struct {
	Id                int         `json:"id"`
	Language          int         `json:"language"`
	LangCode          string      `json:"lang_code"`
	MainCat           int         `json:"main_cat"`
	Category          int         `json:"category"`
	Catname           string      `json:"catname"`
	Size              string      `json:"size"`
	Numfiles          int         `json:"numfiles"`
	Vip               int         `json:"vip"`
	Free              int         `json:"free"`
	PersonalFreeleech int         `json:"personal_freeleech"`
	FlVip             int         `json:"fl_vip"`
	Title             string      `json:"title"`
	W                 int         `json:"w"`
	Tags              string      `json:"tags"`
	AuthorInfo        string      `json:"author_info"`
	NarratorInfo      string      `json:"narrator_info"`
	SeriesInfo        string      `json:"series_info"`
	Filetype          string      `json:"filetype"`
	Seeders           int         `json:"seeders"`
	Leechers          int         `json:"leechers"`
	Added             string      `json:"added"`
	Browseflags       int         `json:"browseflags"`
	TimesCompleted    int         `json:"times_completed"`
	Comments          int         `json:"comments"`
	OwnerName         string      `json:"owner_name"`
	Owner             int         `json:"owner"`
	Bookmarked        interface{} `json:"bookmarked"`
	MySnatched        int         `json:"my_snatched"`
	Description       string      `json:"description"`
	PosterType        string      `json:"poster_type"`
	Cat               string      `json:"cat"`
	Thumbnail         string      `json:"thumbnail"`
	Dl                string      `json:"dl"`
}
