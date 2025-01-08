# Gouda

A lightweight download automation tool for MyAnonaMouse users, offering a simpler alternative
to [Readarr](https://github.com/Readarr/Readarr).

Most of the features offered by readarr are overkill for me, I just want to download my media without monitoring the
entire authors' collection.

So I made this, key difference is that gouda is designed to be used from within myanonamouse site, without leaving it.
Hence, it is intended to work with the [extension](parmesan).

## Features

- Seamless integration with MyAnonaMouse via the [Parmesan browser extension](parmesan)
- One-click downloads directly from MAM's interface
- Automatic torrent handling and download management
- Storage management through hardlinking

## How it Works

* When you download something from myanonmouse, You use the gouda button (from the [extension](parmesan)) instead of the
  download button.

* The extension then sends the book, author, series info and the [category](#categories), to gouda.

* gouda then downloads the torrent file, sends it to the download client.

* gouda will continue to monitor downloads until,
    * Its complete
        * then [hardlinks](#storage-setup-guide) to save storage space, to the location you specify while setting up
          gouda.
    * It fails
        * if it takes to long (default limit is 15 minutes, this can be changed).
        * Or there was an issue hardlinking, (e.g. the file path already exists).
        * In either case, gouda will not do anything (only display an error), the original downloaded file will remain
          untouched (if it successfully downloaded)

## Application Setup

1. Setup gouda [here](#installation-and-requirements)
2. Once running, access the web interface at `http://your-ip:9862` to:
    - configure the torrent client settings (only Transmission is supported at the moment)
      - Make sure to disable temporary folder (transmission)
    - configure the [categories](#categories)
    - Verify the 
      - download path 
      - complete path 
      - the linux UID,GID permissions (if using a linux based os or docker)
3. Setup the [browser extension](parmesan)

## Installation and requirements

Currently, gouda is only packaged with docker, (standalone binaries are WIP).

Therefore, you will need

1. Basic understanding of Docker and Docker compose.
2. Use transmission as your download client (qbit is currently broken).
3. Structure your files as mentioned [here](#basic-directory-structure)
4. And a reverse proxy setup, since browsers block 'http' requests from https sites.

### Docker Compose

Look at the example docker compose here [docker-compose](prod-docker-compose.yml) and adapt it your needs.

Note: docker requires specific folder structure or else hardlinks will not work ([setup guide](#storage-setup-guide))

#### Environment Variables

##### Required Variables

| Variable         | Description                               | Default    |
|------------------|-------------------------------------------|------------|
| `GOUDA_USERNAME` | Username for web interface authentication | *Required* |
| `GOUDA_PASS`     | Password for web interface authentication | *Required* |

##### Optional Variables but recommended to set

| Variable             | Description                       | Default              |
|----------------------|-----------------------------------|----------------------|
| `GOUDA_UID`          | User ID for file permissions      | `1000`               |
| `GOUDA_GID`          | Group ID for file permissions     | `1000`               |
| `GOUDA_DOWNLOAD_DIR` | Directory for temporary downloads | `/appdata/downloads` |
| `GOUDA_COMPLETE_DIR`  | Directory for completed downloads | `/appdata/complete`  |
| `GOUDA_TORRENT_DIR`  | Directory for torrent files       | `/appdata/torrents`  |

#### Storage Setup Guide

_Hardlinking is a way to create multiple names for a file that all point to the same location on a disk. This allows
users to access the file's contents through different paths, such as in different directories or under different names._

Follow this if you are using docker, if you are running gouda directly, no additional setup is required.

We recommend the following dir structure (it
follows [trash guides](https://trash-guides.info/File-and-Folder-Structure/)), required to get hardlink support.

##### Basic Directory Structure

Create a single root folder for all your media files:

```
/media
 | /downloads <-- this where your download client will store files
 | /audiobooks <-- these are the final destination of your files (more info below)
 | /comics
```

**Key requirements:**

1. All media must be on the same filesystem for hardlinking
2. Your download client must store files in `/media/downloads`
3. Gouda will use [categories](#categories) (audiobooks, comics, etc.) and will create the folder if it doesn't exist.

> [!TIP]
****If you want to use multiple hard drives, look into https://github.com/trapexit/mergerfs to combine your storage.****

> [!TIP]
> There is also an [example docker compose](./prod-docker-compose.yml) with a download client you can refer to.

###### Final Setup

Mount your media directory in both Gouda and your download client:

```yaml
services:
  gouda:
    volumes:
      - /home/user/config:/appdata/config  # Config files (can be mounted anywhere you like)
      - /home/user/media:/media        # Media files

  download-client:
    volumes:
      - /home/user/media:/media        # Must match Gouda's path
```

#### Categories

Gouda uses category sent when downloading the media, for example, if you used 'manga' category,
then gouda will do the following:

```
/media
| /downloads
| /audiobooks
| /comics
| /manga <--- automatically created by gouda if it doesn't exist
 | /author <--- sub folders are also created 
  | /name
   | <final file or folder downloaded automatically hardlinked>
```

##### Configuration

Categories are configured via the webui, categories are required when downloading any media.

## Help and suggestions

If you need help, encounter a bug, or want a new feature

open a issue or start a discussion here https://github.com/RA341/gouda/discussions

## FAQ

Q. Will this mess with my ratio or remove the download from my download client?

A. No. Gouda only checks the download status from your torrent client, it will NEVER modify,
delete or otherwise touch the file at the download location.

If gouda is unable to hardlink the downloaded file it will only display error, and no further action will be taken by
gouda.

Q. Does this work with freeleech and personal freeleech torrents

A. Yes!, As long as you buy the torrent as freeleech (or if it is already set as freeleech) before sending it to gouda,
it will behave as if you started download yourself and will not affect your ratio.

Q. Is it secure or against myanonamouse TOS

A. I have been using it for a while now, and it has not caused any problems on the site for me, this tool mimics what
someone would do normally on the site,
The extension and the app are fully local, and open source you can check the code for yourself, or ask chatgpt ;)

Q. How does it download the torrent file without authentication

A. MAM torrent file download links do not require authentication, since they are pretty much useless without an active
account on the site.

## License

This project is licensed under the [GNU GENERAL PUBLIC LICENSE](LICENSE):