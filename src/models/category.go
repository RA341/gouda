package types

type CatRequest struct {
	Category string `json:"category"`
}

type CatList struct {
	Categories []string `json:"categories"`
}
