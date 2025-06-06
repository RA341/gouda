# Gouda

A lightweight download automation tool for MyAnonaMouse users, offering a simpler alternative
to [Readarr](https://github.com/Readarr/Readarr).

Most of the features offered by readarr are overkill for me, I just want to download my media without monitoring the
entire authors' collection.

So I made this, key difference is that gouda is designed to be used from within myanonamouse site, without leaving it.
Hence, it is intended to work with the [extension](parmesan).

## Getting Started

Gouda is best used with Docker. For platforms where Docker isn't an option, native binaries are provided.

### Docker

Downloads the sample [docker-compose.yml](install/docker-compose.yml), you will need to setup your download client correctly

* On linux:
    ```bash
    curl -sSL https://raw.githubusercontent.com/RA341/gouda/refs/heads/release/install/install.sh | bash -s -- docker
    ```

* On windows
    ```powershell
    & ([scriptblock]::Create((Invoke-RestMethod 'https://raw.githubusercontent.com/RA341/gouda/refs/heads/main/install/install.ps1'))) 'docker'
    ```

### Docs
For configuration options, usage examples, and detailed explanations, refer to the [docs](https://gouda.dumbapps.org).

## How it Works

* When you download something from myanonmouse, You use the gouda button (from the [extension](parmesan)) instead of the
  download button.

* The extension then sends the book, author, series info and the category, to gouda.

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

## Help and suggestions

If you need help, encounter a bug, or want a new feature

open an issue or start a discussion here https://github.com/RA341/gouda/discussions

## License

This project is licensed under the [GNU GENERAL PUBLIC LICENSE](LICENSE):
