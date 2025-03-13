---
sidebar_position: 1
---
# Docker

**Setup gouda on docker.**

[Docker hub](https://hub.docker.com/repository/docker/ras334/gouda/general)

:::important
To get hardlink support, you MUST follow a specific folder structure [guide](#storage-setup-guide)
:::

:::tip
Look at the example [docker-compose](https://github.com/RA341/gouda/blob/release/prod-docker-compose.yml) here and adapt
it your needs.
:::

## Setup

1. Here is a minimal example for docker compose, but it is recommended to look at
   the [example docker-compose](https://github.com/RA341/gouda/blob/release/prod-docker-compose.yml) file, to get a
   better
   understanding.
   ```yaml
    gouda:
        container_name: gouda
        image: ras334/gouda:latest
        ports:
         - "9862:9862"
        environment:
         - GOUDA_USERNAME=admin
         - GOUDA_PASS=admin
         - GOUDA_UID=1000
         - GOUDA_GID=1000
         - GOUDA_DOWNLOAD_DIR=/media/downloads 
         - GOUDA_COMPLETE_DIR=/media/complete 
         - GOUDA_TORRENT_DIR=/media/downloads/torrents  
        volumes:
         - /path/to/media:/media # make sure this matches your download client mount exactly
         - /path/to/config:/config
     ```
2. Take look at all the env variables that can be added [here](env.md).
3. Start the compose stack
   ```bash
   docker compose up -d
   ```

## Storage Setup Guide

_Hardlinking is a way to create multiple names for a file that all point to the same location on a disk. This allows
users to access the file's contents through different paths, such as in different directories or under different names._

For a detailed guide on enabling hardlinking, refer to the excellent resource
by [Trash Guides](https://trash-guides.info/File-and-Folder-Structure/).

### TL;DR: Key Requirements

1. **All media must reside on the same filesystem to enable hardlinking.**

2. **Create a single root directory for all your media files:**
   ```plaintext
   /media
   ├── /downloads  # Where your download client will store files  
   ├── /audiobooks # Final destination for audiobooks  
   └── /comics     # Final destination for comics  
   ```  

3. **Docker Compose Example:**  
   Then mount the entire folder in your `docker-compose` config:
   ```yaml
   services:
     gouda:
       # Other service configuration
       volumes:
         - /home/user/config:/appdata/config  # Config files (location is flexible)
         - /home/user/media:/media            # Media files (shared path)
   
     download-client:
       # Other service configuration
       volumes:
         - /home/user/media:/media            # Must match Gouda's media path  
   ```  

:::tip  
**Using Multiple Hard Drives:**  
If you have multiple hard drives, consider using [mergerfs](https://github.com/trapexit/mergerfs) to combine them into a
single, unified storage pool.

This simplifies disk management and ensures compatibility with hardlinking.  
:::
