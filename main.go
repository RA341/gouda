package main

import (
	"log"
)

var ff = "https://file-examples.com/wp-content/storage/2017/02/file-sample_100kB.doc"

func main() {
	// start config

	_, err = DownloadTorrentFile(ff, "torrents")
	if err != nil {
		log.Fatal(err)
	}

	// load transmission
	downloadCli, err := initTransmission()
	if err != nil {
		log.Println("Error initializing client:", err)
		log.Fatal(err)
	}

	_, _, err = downloadCli.Health()
	if err != nil {
		log.Println("Error connecting to transmission:", err)
		log.Fatal(err)
	}

}
