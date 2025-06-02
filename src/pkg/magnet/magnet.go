package magnet

import (
	"bytes"
	"crypto/sha1"
	"encoding/hex"
	"fmt"
	"github.com/jackpal/bencode-go"
	"io"
	"net/url"
	"strings"
)

/*
	To convert a .torrent file to a magnet link perform the following steps:

	. Ben-decode the content
	. Extract the 'info' dictionary: This dictionary contains the core information about the torrent
	. Bencode the 'info' dictionary: The info hash is the SHA-1 hash of the Bencoded info dictionary itself. So, you'll need to re-encode just this part. The bencode-go library sorts dictionary keys alphabetically by default, which is required by the BitTorrent specification.
	. Calculate the SHA-1 hash: Compute the SHA-1 hash of the Bencoded 'info' bytes and Hex encode the hash
	. Extract the display name ('dn'): This is the name field within 'info'
	. Extract tracker URLs ('tr'): in the 'announce' field and 'announce-list' field
	. Assemble the magnet link: Combine all the extracted parts, with URL encoding for the display name and tracker URLs
*/

// TorrentFileToMagnet converts a .torrent file to a magnet link string.
func TorrentFileToMagnet(data io.Reader) (string, error) {
	tmp, err := bencode.Decode(data)
	if err != nil {
		return "", fmt.Errorf("failed to unmarshal torrent data: %w", err)
	}
	torrentInfo, ok := tmp.(map[string]interface{})
	if !ok {
		return "", fmt.Errorf("failed to convert unmarshaled data to map[string]interface{}")
	}

	info, ok := torrentInfo["info"].(map[string]interface{})
	if !ok {
		return "", fmt.Errorf("'info' key not found or assertion failed to map[string]interface{}")
	}

	var infoBytes bytes.Buffer
	if err = bencode.Marshal(&infoBytes, info); err != nil {
		return "", fmt.Errorf("failed to marshal infoMap to bytes: %w", err)
	}

	hash := sha1.New()
	hash.Write(infoBytes.Bytes())
	infoHashBytes := hash.Sum(nil)

	var magnetLink strings.Builder
	magnetLink.WriteString("magnet:?xt=urn:btih:")
	magnetLink.WriteString(hex.EncodeToString(infoHashBytes))

	// set display name
	if name, ok := info["name"].(string); ok {
		magnetLink.WriteString("&dn=")
		magnetLink.WriteString(url.QueryEscape(name))
	}

	// assign tracker urls check both announce and announce-list
	trackerUrls := map[string]struct{}{} // map as a set to avoid duplicate urls

	if announce, ok := torrentInfo["announce"].(string); ok && announce != "" {
		trackerUrls[announce] = struct{}{}
	}
	if announceList, ok := torrentInfo["announce-list"].([]interface{}); ok {
		for _, tierInterface := range announceList {
			tier, ok := tierInterface.([]interface{})
			if !ok {
				continue
			}

			for _, trackerInterface := range tier {
				if trackerStr, ok := trackerInterface.(string); ok && trackerStr != "" {
					trackerUrls[trackerStr] = struct{}{}
				}
			}
		}
	}

	for tracker := range trackerUrls {
		magnetLink.WriteString("&tr=")
		magnetLink.WriteString(url.QueryEscape(tracker))
	}

	return magnetLink.String(), nil
}

type TorrentComponents struct {
	InfoHash    string   // Hex-encoded info hash (from the first urn:btih: found)
	DisplayName string   // dn (Display Name)
	Trackers    []string // tr (Tracker URLs)
	ExactTopics []string // All xt (Exact Topic) parameters
}

// DecodeMagnetURL parses a magnet URI string and extracts its components.
func DecodeMagnetURL(magnetURI string) (TorrentComponents, error) {
	var components = TorrentComponents{}
	parsedURL, err := url.Parse(magnetURI)
	if err != nil {
		return components, fmt.Errorf("failed to parse magnet URI: %w", err)
	}

	if parsedURL.Scheme != "magnet" {
		return components, fmt.Errorf("invalid magnet URI: scheme is not 'magnet'")
	}

	params := parsedURL.Query()

	// Extract Exact Topics (xt) and InfoHash (from urn:btih:)
	// A magnet link can technically have multiple xt parameters.
	if xtValues, ok := params["xt"]; ok {
		components.ExactTopics = xtValues
		for _, xtValue := range xtValues {
			// Check for BitTorrent Info Hash (BTIH)
			// Format is urn:btih:<hex_encoded_hash> or urn:btih:<base32_encoded_hash>
			// This code primarily targets the common hex-encoded SHA-1 hash (40 chars).
			if strings.HasPrefix(xtValue, "urn:btih:") {
				hash := strings.TrimPrefix(xtValue, "urn:btih:")
				if hash != "" {
					components.InfoHash = hash
					break // Use the first valid BTIH found
				}
			}
		}
	}

	// Extract Display Name (dn)
	components.DisplayName = params.Get("dn")

	// Extract Trackers (tr)
	if trValues, ok := params["tr"]; ok {
		components.Trackers = trValues
	}

	return components, nil
}
