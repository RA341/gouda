# Gouda

A companion app for myanonmouse users to download stuff quickly

Components:
* [frontend](https://github.com/ra341/brie)

* [extension](https://github.com/ra341/parmesan)

## Features

- Web-based interface for managing downloads
- Integration with transmission torrent client
- Category-based organization for downloads
- Automated file management and permissions handling
- Secure authentication system

## Docker Setup

### Quick Start

### Docker run example
```bash
docker run -d \
  --name gouda \
  -p 9862:9862 \
  -e GOUDA_USERNAME=admin \
  -e GOUDA_PASS=password \
  -v /path/to/data:/appdata \
  ras334/gouda
```

### Docker Compose Example

Look at the example docker compose here [docker-compose](test-docker-compose.yml) and adapt it your needs.

Once running, access the web interface at `http://your-ip:9862` to configure:
- Torrent client settings (qBittorrent, Transmission, etc.) (currently only transmission is supported)
- Download categories and paths
- Additional application settings

### Environment Variables

#### Required Variables
| Variable | Description | Default |
|----------|-------------|---------|
| `GOUDA_USERNAME` | Username for web interface authentication | *Required* |
| `GOUDA_PASS` | Password for web interface authentication | *Required* |

#### Optional Variables
| Variable | Description | Default |
|----------|-------------|---------|
| `GOUDA_UID` | User ID for file permissions | `1000` |
| `GOUDA_GID` | Group ID for file permissions | `1000` |
| `GOUDA_DOWNLOAD_DIR` | Directory for temporary downloads | `/appdata/downloads` |
| `GOUDA_DEFAULT_DIR` | Directory for completed downloads | `/appdata/complete` |
| `GOUDA_TORRENT_DIR` | Directory for torrent files | `/appdata/torrents` |

### Volume Mounts

The container requires a volume mount for persistent storage:

I recommend the following dir structure (it follows [trash guides](https://trash-guides.info/File-and-Folder-Structure/))

Store all your media in a folder
```
/media
 | /downloads
 | /audiobooks
 | /comics
```

Gouda will use the category used when downloading the media, for example, if you use 'manga' category, 
then gouda will create a folder 
```
/media
| /downloads
| /audiobooks
| /comics
| /manga <--- automatically created by gouda if it doesn't exist
 | /author
  | /name
   | <final file or folder downloaded automatically hardlinked> 
```

#### Final mounts

* config - `<your path to config>`:`/appdata/config`

* media - `<path to media folder>`:`/media`

##### Transmission should also be mounted the same way

* media - `<path to media folder>`:`/media`


If no paths are given:
This will create the following directory structure:
```
/appdata/
├── config/         # Configuration files
├── downloads/      # Temporary download location
├── complete/       # Completed downloads
└── torrents/      # Torrent files
```

### Configuration

#### Initial Setup

1. After starting the container, access the web interface at `http://your-ip:9862`
2. Log in using the credentials set in `GOUDA_USERNAME` and `GOUDA_PASS`
3. Configure your torrent client connection (currently supports Transmission)
4. Set up download categories for organization

