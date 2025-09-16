---
# make this page always last
title: Env vars
---

# Environment Variables

You can set the following environment variables for gouda

| Variable             | Description                               | Default              | Additional notes                                                                 |
|----------------------|-------------------------------------------|----------------------|----------------------------------------------------------------------------------|
| `GOUDA_USERNAME`     | Username for web interface authentication | admin                |                                                                                  |
| `GOUDA_PASS`         | Password for web interface authentication | admin                |                                                                                  |
| `GOUDA_UID`          | User ID for file permissions              | `1000`               | This is only required for `linux/macos` or when using `docker`                   |
| `GOUDA_GID`          | Group ID for file permissions             | `1000`               | This is only required for `linux/macos` or when using `docker`                   |                                                     |
| `GOUDA_DOWNLOAD_DIR` | Directory for downloads                   | `/appdata/downloads` | This is where your download client will download the file                        |
| `GOUDA_COMPLETE_DIR` | Directory for completed files             | `/appdata/complete`  | This is where the files will be hardlinked to, used by audiobookshelf or calibre |
| `GOUDA_TORRENT_DIR`  | Directory for torrent files               | `/appdata/torrents`  | This is where gouda will store and download all the torrent files from mam here. |

## Non-docker

For native executables you need to create a `.env` file like so 

```
GOUDA_USERNAME=admin
GOUDA_PASS=admin
.... other envs
```

## Docker

for docker environment pass it via docker `-e` flag or docker-compose.yml `environment:` section