# Gouda

> [!Important]
> Project status:
> Overhaul in progress
>
> Check Progress [here](#overhaul-progress)
>
> Well, well, well... look who decided to dust off this repository after months! Finally getting around to this project
> after months of procrastination; this baby is getting a complete makeover.
>
> > **What's brewing:**
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
    - [ ] [UI] Allow option to download with wedge
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

---

## Getting Started

Gouda is best used with Docker. For platforms where Docker isn't an option, native binaries are provided.

### Docker

Downloads the sample [docker-compose.yml](install/docker-compose.yml), you will need to setup your download client
correctly

* On Linux:
    ```bash
    curl -sSL https://raw.githubusercontent.com/RA341/gouda/refs/heads/release/install/install.sh | bash -s -- docker
    ```

* On Windows
    ```powershell
    & ([scriptblock]::Create((Invoke-RestMethod 'https://raw.githubusercontent.com/RA341/gouda/refs/heads/main/install/install.ps1'))) 'docker'
    ```

### Docs

For configuration options, usage examples, and detailed explanations, refer to the [docs](https://gouda.radn.dev).

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
