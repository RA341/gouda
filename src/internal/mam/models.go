package mam

type LeechType string

var (
	FreeLeechGlobal   LeechType = "gFL"
	FreeLeechPersonal LeechType = "personalFL"
)

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

// Book represents the final, cleaned-up book data.
type Book struct {
	ID          string `json:"id"`
	Title       string `json:"title"`
	Author      string `json:"author"`
	Format      string `json:"format"`
	Length      string `json:"length,omitempty"`
	TorrentLink string `json:"torrentLink"`
	Category    int    `json:"category"`
	Thumbnail   string `json:"thumbnail"`
	Size        string `json:"size"`
	Seeders     int    `json:"seeders"`
	Leechers    int    `json:"leechers"`
	Added       string `json:"added"`
	Tags        string `json:"tags"`
	Completed   int    `json:"completed"`
}

// SearchResponse defines the structure of the JSON response from the server.
type SearchResponse struct {
	Data []SearchResultItem `json:"data"`
	//the number of results the server loaded for your search.
	Total int `json:"total"`
	//int	Total results found
	TotalFound int `json:"found"`
}

// SearchResultItem represents a single item in the "data" array from the API response.
// It uses json.Number to handle fields that can be strings or numbers.
type SearchResultItem struct {
	ID             int    `json:"id"`
	Title          string `json:"title"`
	AuthorInfo     string `json:"author_info"`
	Filetype       string `json:"filetype"`
	DL             string `json:"dl"`
	MainCat        int    `json:"main_cat"`
	Thumbnail      string `json:"thumbnail"`
	Size           string `json:"size"`
	Seeders        int    `json:"seeders"`
	Leechers       int    `json:"leechers"`
	Added          string `json:"added"`
	Tags           string `json:"tags"`
	TimesCompleted int    `json:"times_completed"`
	Description    string `json:"description"`
}
