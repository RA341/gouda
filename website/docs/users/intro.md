---
title: Gouda
sidebar_position: 1
---

# Gouda

**A lightweight download automation tool for MyAnonaMouse users, offering a simpler alternative
to [Readarr](https://github.com/Readarr/Readarr).**

## Motivation

I tried readarr, but it was buggy for me, and I don't need to use its monitoring features.

This makes it easier than readarr, as you can directly download the release without monitoring the
entire authors' collection.

Hence, it is intended to work with the [extension](extension.md).

## How it Works

* When you download something from myanonmouse, You use the gouda button (from the [extension](extension.md)) instead of the
  download button.

* The extension then sends the book, author, series info and the [category](category.md), to gouda.

* Gouda then downloads the torrent file, sends it to the download client.

* Gouda will continue to monitor downloads until,
    * Its complete
        * then [hardlinks](installation/docker.md#storage-setup-guide) to save storage space, to the location you specify while setting up
          gouda.
    * It fails
        * if it takes to long (default limit is 15 minutes, this can be changed).
        * Or there was an issue hardlinking, (e.g. the file path already exists).
      * In either case, gouda will not do anything (only display an error), the original downloaded file will remain
        untouched (if it successfully downloaded)

## Requirements

### Supported Torrent Clients

Gouda provides integration with the following torrent clients:

| Client       | Support | Issues |
|--------------|---------|--------|
| Transmission | ✅ Full  | None   |
| Deluge       | ✅ Full  | None   |
| qBittorrent  | ✅ Full  | None   |

### Supported platforms

#### Docker Package

The application is available as [docker image](installation/docker.md).

#### OS executables

Executables are available for 
 
* [Windows](installation/windows.md) 
* [Linux](installation/linux.md)
* [Macos](installation/macos.md)

There are two distinct variants for each OS:

##### Desktop Edition

The Desktop Edition is designed for personal computer usage and includes:

- Native UI implementation
- Web-based user interface
- System tray integration
- Full functionality optimized for desktop environments

##### Server Edition

The Server Edition is designed for headless environments such as seedboxes and servers:

- Lightweight binary without desktop dependencies
- Web-based user interface only
- No system tray implementation
- Designed for remote access and management
