# Gouda

> [!Important]
> Project status:
> Overhaul in progress
>
> Check Progress [here](#overhaul-progress)
>
> If you would like to test drive the dev build [check here](#beta-build)
>
> Well, well, well... look who decided to dust off this repository after months! Finally getting around to this project
> after months of procrastination; this baby is getting a complete makeover.
>
> **What's brewing:**
> - Direct download functionality (no need for the extension, you can also download with wedges)
> - Overseer-like request system so your family can also get their books
> - Improved architecture and performance improvements (translation: I'm fixing all the "TODO: refactor this mess"
    comments)
> - Mobile App !!!
>
> The current version works perfectly fine, so feel free to use it while I'm busy working through this overhaul!,
> but dont expect any bug fixes/features.

A lightweight download automation tool for MyAnonaMouse users, offering a simpler alternative
to [Readarr](https://github.com/Readarr/Readarr).

Most of the features offered by readarr are overkill for me. I just want to download my media without monitoring the
entire authors' collection.

So I made this, the key difference is that Gouda is designed to be used from within myanonamouse site, without leaving
it.
Hence, it is intended to work with the [extension](parmesan).

## Overhaul progress

Documents the overhaul progress and tasks

if you have any ideas you would like to add modify this section and open a PR

- [ ] Add direct download functionality
    - [x] Support downloads without the extension
    - [x] Support wedge-based downloads
  - [x] [UI] Allow option to download with wedge
    - [ ] [UI] Add searching and filtering for downloaded/requested books

- [ ] Mam search
    - [x] Basic Search
    - [ ] Advanced filtering and sorting
    - [ ] Wedge usage Recommendation similar to mam ratio protect

- [ ] Mam admin tasks
    - [x] Auto buy ratio
    - [x] Auto buy wedges
    - [ ] Auto IP updates
    - [ ] add frontend settings page

- [ ] Settings
    - [ ] File picker file paths

- [ ] Request System
    - [ ] Implement user request page
    - [ ] Implement admin request page
        - [ ] Approve/Disapprove
    - [ ] Notifications ???

## Beta Build

A beta build is now available for testing!

While the UI is still being refined, the core downloading functionality is operational.

Your feedback is highly appreciated!

### Getting Started

Follow sections below to get started with the beta build

Currently, the build is only published for docker

#### Docker-compose

```yaml
gouda:
  container_name: gouda-next
  image: ghcr.io/ra341/gouda:beta
  ports:
    - "9862:9862"
  volumes:
    - /path/to/config:/app/config
    - /path/to/media:/media # Must match download client
  restart: unless-stopped

transmissionprivate:
  container_name: transmissionpriv
  image: lscr.io/linuxserver/transmission:latest
  environment:
    - PUID=1000
    - PGID=1000
    - TZ=Etc/UTC
  volumes:
    - /path/to/media:/media  # Must match gouda's mount exactly
  ports:
    - "9092:9091"
    - "9161:9161"
  restart: unless-stopped
```

> [!IMPORTANT]
> **⚠️ Important Note on Volume Mounts**
>
> The `/path/to/media:/media` volume mount must be **identical** in both the gouda and torrent client containers.
>
> While you can customize the path to your preference, both gouda and your download client must share the exact same
> mapping to allow gouda to access the files properly and allow symlink of downloaded files.

#### Configuration

After starting your container, log in with:

```
username: admin
password: gouda
```

Navigate to the settings page and configure the following:

- MAM token
- File paths
- Downloader settings

### Reporting Issues

If you encounter any bugs or have suggestions, [open an issue](https://github.com/RA341/gouda/issues)

## How it Works

* When you download something from myanonmouse, you use the gouda button (from the [extension](parmesan)) instead of the
  download button.

* The extension then sends the book, author, series info, and the category to Gouda.

* Gouda then downloads the torrent file, sends it to the download client.

* Gouda will continue to monitor downloads until,
    * It's complete
        * then [hardlinks](#storage-setup-guide) to save storage space, to the location you specify while setting up
          Gouda.
    * It fails
        * if it takes too long (default limit is 15 minutes, this can be changed).
        * Or there was an issue hardlinking (e.g. the file path already exists).
        * In either case, Gouda will not do anything (only display an error), the original downloaded file will remain
          untouched (if it successfully downloaded)

## Help and suggestions

If you need help, encounter a bug, or want a new feature

Open an issue or start a discussion here https://github.com/RA341/gouda/discussions

## License

This project is licensed under the [GNU GENERAL PUBLIC LICENSE](LICENSE):
