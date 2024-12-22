# Gouda

A download automation tool, designed specifically for myanonamouse users.

Think of it like a minimal alternative to [readarr](https://github.com/Readarr/Readarr).

Most of the features offered by readarr are overkill for me, I just want to download my books without adding the entire authors collection to the monitor.

So I made this, key difference is that gouda is best used from within myanonamouse site, without leaving it. Hence, it is designed to work with the [extension](https://github.com/ra341/parmesan).

A normal usage will look like, 

* You tell the extension to download the media while you are browsing myanonamouse. 

* gouda then downloads the torrent file, sends it to the download client.

* Gouda will continue to monitor download until, 
  * its complete it then hardlinks it to the location you specify (think of hardlinking like moving the file without copying, so it exists in 2 locations at the same time)
  * If the download fails or if it takes to long (default limit is 15 minutes, this can be changed), gouda stops monitoring and does nothing.

* No need to manually go in and create the folders or mess with the download files!!.

### FAQ

Q. Will this mess with my ratio or remove the download from my download client?

A. No. Gouda only checks the download status from your torrent client, it will NEVER modify, 
delete or otherwise touch the file at the download location.

If gouda is unable to hardlink the downloaded file it will only display error, and no further action will be taken by gouda.

Q. Does this work with freeleech and personal freeleech torrents

A. Yes!, As long as you buy the torrent as freeleech (or if it is already set as freeleech) before sending it to gouda, 
it will behave as if you started download yourself and will not affect your ratio.

Q. Is it secure or against myanonamouse TOS

A. I have been using it for a while now, and it has not caused any problems on the site for me, this tool mimics what someone would do normally on the site,
The extension and the app are fully local, and open source you can check the code for yourself, or ask chatgpt ;)

Q. How does it download the torrent file without authentication

A. MAM torrent file download links do not require authentication, since they are pretty much useless without an active account on the site.

## Installation

Currently, gouda is only packaged with docker, (standalone binaries are planned)

### Docker Compose Example

Look at the example docker compose here [docker-compose](prod-docker-compose.yml) and adapt it your needs.

Note: docker requires specific folder structure or else hardlinks will not work ([more info](#volume-mounts))

Once running, access the web interface at `http://your-ip:9862` to configure:
- Torrent client settings (only qBittorrent and Transmission are supported at the moment)
- Set the Download categories
- Other application settings

#### Environment Variables

##### Required Variables
| Variable | Description | Default |
|----------|-------------|---------|
| `GOUDA_USERNAME` | Username for web interface authentication | *Required* |
| `GOUDA_PASS` | Password for web interface authentication | *Required* |

##### Optional Variables but recommended to set 
| Variable | Description | Default |
|----------|-------------|---------|
| `GOUDA_UID` | User ID for file permissions | `1000` |
| `GOUDA_GID` | Group ID for file permissions | `1000` |
| `GOUDA_DOWNLOAD_DIR` | Directory for temporary downloads | `/appdata/downloads` |
| `GOUDA_DEFAULT_DIR` | Directory for completed downloads | `/appdata/complete` |
| `GOUDA_TORRENT_DIR` | Directory for torrent files | `/appdata/torrents` |

##### Volume Mounts

I recommend the following dir structure (it follows [trash guides](https://trash-guides.info/File-and-Folder-Structure/)), to get hardlink support.

Store all your media in a single folder, for eg:
```
/media
 | /downloads
 | /audiobooks
 | /comics
```

Gouda will use the category used when downloading the media, for example, if you used 'manga' category, 
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

##### Final mounts

* config -
  * You can set this path to any folder you want this will never be used for hardlinking or downloading
  * `<your path to config>`:`/appdata/config`

Assuming you follow the above dir structure, use the following volume mounts

* media - 
  * Make sure this mount is exactly the same as you mount it in your download client  
  * `<path to media folder>`:`/media`
    * For example if your media folder is located at `/home/deep_thought/media` then the mount would look like
      * `/home/deep_thought/media`:`/media`
      * And your download client mount would also look like
      * `/home/deep_thought/media`:`/media`

* Transmission or Qbit should also be mounted the same way
  * media - `<path to media folder>`:`/media`

There is also an [example docker compose](./prod-docker-compose.yml) with a download client you can refer to.

If no paths are given via the env variables:
This will create the following directory structure:
```
/appdata/
├── config/         # Configuration files
├── downloads/      # Temporary download location
├── complete/       # Completed downloads
└── torrents/      # Torrent files
```

