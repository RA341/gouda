package mam

import (
	"encoding/json"
	"fmt"
	"time"
)

// SearchType represents the type of search to perform
type SearchType string

const (
	SearchAll      SearchType = "all"
	SearchActive   SearchType = "active"
	SearchInactive SearchType = "inactive"
	SearchFL       SearchType = "fl"
	SearchFLVIP    SearchType = "fl-VIP"
	SearchVIP      SearchType = "VIP"
	SearchNVIP     SearchType = "nVIP"
	SearchNMeta    SearchType = "nMeta"
)

// SortType represents how to sort the results
type SortType string

const (
	SortTitleAsc     SortType = "titleAsc"
	SortTitleDesc    SortType = "titleDesc"
	SortFileAsc      SortType = "fileAsc"
	SortFileDesc     SortType = "fileDesc"
	SortSizeAsc      SortType = "sizeAsc"
	SortSizeDesc     SortType = "sizeDesc"
	SortSeedersAsc   SortType = "seedersAsc"
	SortSeedersDesc  SortType = "seedersDesc"
	SortLeechersAsc  SortType = "leechersAsc"
	SortLeechersDesc SortType = "leechersDesc"
	SortSnatchedAsc  SortType = "snatchedAsc"
	SortSnatchedDesc SortType = "snatchedDesc"
	SortDateAsc      SortType = "dateAsc"
	SortDateDesc     SortType = "dateDesc"
	SortBmkaAsc      SortType = "bmkaAsc"
	SortBmkaDesc     SortType = "bmkaDesc"
	SortReseedAsc    SortType = "reseedAsc"
	SortReseedDesc   SortType = "reseedDesc"
	SortCategoryAsc  SortType = "categoryAsc"
	SortCategoryDesc SortType = "categoryDesc"
	SortRandom       SortType = "random"
	SortDefault      SortType = "default"
)

// SearchIn represents where to search
type SearchIn string

const (
	SearchInTorrents SearchIn = "torrents"
)

// MainCategory represents main category IDs
type MainCategory int

const (
	AudioBooks MainCategory = 13
	EBooks     MainCategory = 14
	Musicology MainCategory = 15
	Radio      MainCategory = 16
)

// TorrentQuery represents the torrent search parameters
type TorrentQuery struct {
	Text                  string     `json:"text,omitempty"`
	SrchIn                []string   `json:"srchIn,omitempty"`
	SearchType            SearchType `json:"searchType,omitempty"`
	SearchIn              SearchIn   `json:"searchIn,omitempty"`
	Cat                   []string   `json:"cat,omitempty"`
	BrowseLang            []int      `json:"browse_lang,omitempty"`
	MainCat               []int      `json:"main_cat,omitempty"`
	BrowseFlagsHideVsShow string     `json:"browseFlagsHideVsShow,omitempty"`
	StartDate             string     `json:"startDate,omitempty"`
	EndDate               string     `json:"endDate,omitempty"`
	Hash                  string     `json:"hash,omitempty"`
	SortType              SortType   `json:"sortType,omitempty"`
	StartNumber           string     `json:"startNumber,omitempty"`
	PerPage               int        `json:"perpage,omitempty"`

	// Search field flags
	Author      bool `json:"author,omitempty"`
	Description bool `json:"description,omitempty"`
	Filenames   bool `json:"filenames,omitempty"`
	FileTypes   bool `json:"fileTypes,omitempty"`
	Narrator    bool `json:"narrator,omitempty"`
	Series      bool `json:"series,omitempty"`
	Tags        bool `json:"tags,omitempty"`
	Title       bool `json:"title,omitempty"`
}

// SearchQuery represents the complete search query structure
type SearchQuery struct {
	Tor       TorrentQuery `json:"tor"`
	Thumbnail string       `json:"thumbnail,omitempty"`
	DlLink    bool         `json:"dlLink,omitempty"`
	Empty     bool         `json:"empty,omitempty"`
	ISBN      bool         `json:"isbn,omitempty"`
}

// SearchQueryBuilder helps build search queries
type SearchQueryBuilder struct {
	query SearchQuery
}

// NewSearchQueryBuilder creates a new query builder
func NewSearchQueryBuilder() *SearchQueryBuilder {
	return &SearchQueryBuilder{
		query: SearchQuery{
			Tor: TorrentQuery{
				SearchType:  SearchAll,
				SearchIn:    SearchInTorrents,
				SortType:    SortDefault,
				StartNumber: "0",
			},
		},
	}
}

// SetText sets the search text
func (b *SearchQueryBuilder) SetText(text string) *SearchQueryBuilder {
	b.query.Tor.Text = text
	return b
}

// SetSearchType sets the search type
func (b *SearchQueryBuilder) SetSearchType(searchType SearchType) *SearchQueryBuilder {
	b.query.Tor.SearchType = searchType
	return b
}

// SetSortType sets the sort type
func (b *SearchQueryBuilder) SetSortType(sortType SortType) *SearchQueryBuilder {
	b.query.Tor.SortType = sortType
	return b
}

// SetCategories sets the categories to search in
func (b *SearchQueryBuilder) SetCategories(categories []string) *SearchQueryBuilder {
	b.query.Tor.Cat = categories
	return b
}

// SetMainCategories sets the main categories
func (b *SearchQueryBuilder) SetMainCategories(mainCats []MainCategory) *SearchQueryBuilder {
	cats := make([]int, len(mainCats))
	for i, cat := range mainCats {
		cats[i] = int(cat)
	}
	b.query.Tor.MainCat = cats
	return b
}

// SetLanguages sets the browse languages
func (b *SearchQueryBuilder) SetLanguages(langs []int) *SearchQueryBuilder {
	b.query.Tor.BrowseLang = langs
	return b
}

// SetSearchFields sets which fields to search in
func (b *SearchQueryBuilder) SetSearchFields(fields []string) *SearchQueryBuilder {
	b.query.Tor.SrchIn = fields

	// Also set the boolean flags based on the fields
	for _, field := range fields {
		switch field {
		case "title":
			b.query.Tor.Title = true
		case "author":
			b.query.Tor.Author = true
		case "narrator":
			b.query.Tor.Narrator = true
		case "description":
			b.query.Tor.Description = true
		case "filenames":
			b.query.Tor.Filenames = true
		case "fileTypes":
			b.query.Tor.FileTypes = true
		case "series":
			b.query.Tor.Series = true
		case "tags":
			b.query.Tor.Tags = true
		}
	}
	return b
}

// SetDateRange sets the start and end dates
func (b *SearchQueryBuilder) SetDateRange(startDate, endDate time.Time) *SearchQueryBuilder {
	if !startDate.IsZero() {
		b.query.Tor.StartDate = startDate.Format("2006-01-02")
	}
	if !endDate.IsZero() {
		b.query.Tor.EndDate = endDate.Format("2006-01-02")
	}
	return b
}

// SetDateRangeString sets the start and end dates as strings
func (b *SearchQueryBuilder) SetDateRangeString(startDate, endDate string) *SearchQueryBuilder {
	b.query.Tor.StartDate = startDate
	b.query.Tor.EndDate = endDate
	return b
}

// SetHash sets the torrent hash
func (b *SearchQueryBuilder) SetHash(hash string) *SearchQueryBuilder {
	b.query.Tor.Hash = hash
	return b
}

// SetPagination sets pagination parameters
func (b *SearchQueryBuilder) SetPagination(startNumber int, perPage int) *SearchQueryBuilder {
	b.query.Tor.StartNumber = fmt.Sprintf("%d", startNumber)
	if perPage >= 5 && perPage <= 100 {
		b.query.Tor.PerPage = perPage
	}
	return b
}

// SetThumbnail enables/disables thumbnails
func (b *SearchQueryBuilder) SetThumbnail(enabled bool) *SearchQueryBuilder {
	if enabled {
		b.query.Thumbnail = "true"
	} else {
		b.query.Thumbnail = "false"
	}
	return b
}

// SetOptions sets various boolean options
func (b *SearchQueryBuilder) SetOptions(dlLink, empty, isbn bool) *SearchQueryBuilder {
	b.query.DlLink = dlLink
	b.query.Empty = empty
	b.query.ISBN = isbn
	return b
}

// Build returns the final search query
func (b *SearchQueryBuilder) Build() SearchQuery {
	return b.query
}

// ToJSON converts the query to JSON string
func (b *SearchQueryBuilder) ToJSON() (string, error) {
	jsonBytes, err := json.MarshalIndent(b.query, "", "\t")
	if err != nil {
		return "", err
	}
	return string(jsonBytes), nil
}

// Example usage function
//func main() {
//	// Example 1: Basic search like the provided example
//	builder := NewSearchQueryBuilder()
//	query := builder.
//		SetText("collection cookbooks food test kitchen").
//		SetSearchFields([]string{"title", "author", "narrator"}).
//		SetSearchType(SearchAll).
//		SetCategories([]string{"0"}).
//		SetThumbnail(true).
//		Build()
//
//	jsonStr, err := json.MarshalIndent(query, "", "\t")
//	if err != nil {
//		fmt.Printf("Error marshaling JSON: %v\n", err)
//		return
//	}
//
//	fmt.Println("Example 1 - Basic search:")
//	fmt.Println(string(jsonStr))
//	fmt.Println()
//
//	// Example 2: More complex search
//	builder2 := NewSearchQueryBuilder()
//	query2 := builder2.
//		SetText("science fiction").
//		SetSearchFields([]string{"title", "description", "tags"}).
//		SetSearchType(SearchActive).
//		SetMainCategories([]MainCategory{EBooks, AudioBooks}).
//		SetSortType(SortSeedersDesc).
//		SetPagination(0, 25).
//		SetDateRangeString("2023-01-01", "2024-12-31").
//		SetThumbnail(true).
//		SetOptions(true, false, true). // dlLink=true, empty=false, isbn=true
//		Build()
//
//	jsonStr2, err := json.MarshalIndent(query2, "", "\t")
//	if err != nil {
//		fmt.Printf("Error marshaling JSON: %v\n", err)
//		return
//	}
//
//	fmt.Println("Example 2 - Complex search:")
//	fmt.Println(string(jsonStr2))
//	fmt.Println()
//
//	// Example 3: Using the builder's ToJSON method
//	builder3 := NewSearchQueryBuilder()
//	jsonStr3, err := builder3.
//		SetText("programming go golang").
//		SetSearchFields([]string{"title", "author"}).
//		SetSearchType(SearchFL).
//		SetSortType(SortDateDesc).
//		SetPagination(10, 50).
//		ToJSON()
//
//	if err != nil {
//		fmt.Printf("Error converting to JSON: %v\n", err)
//		return
//	}
//
//	fmt.Println("Example 3 - Using ToJSON method:")
//	fmt.Println(jsonStr3)
//}
