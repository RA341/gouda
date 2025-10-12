---
title: About
sidebar_position: 1
---

# Gouda

**A lightweight download automation tool for MyAnonaMouse users, offering a simpler alternative
to [Readarr](https://github.com/Readarr/Readarr).**

---

## What is Gouda?

Gouda is a streamlined tool designed to automate book downloads from MyAnonaMouse. Unlike more complex alternatives like
Readarr, Gouda focuses on simplicity—allowing you to search and download individual releases without the overhead of
monitoring entire author catalogs.

## Why Gouda?

I created Gouda after experiencing reliability issues with Readarr and realizing I didn't need its extensive monitoring
features. Gouda offers a more straightforward approach: search for what you want, download it, and let the tool handle
the rest.

**Key advantages:**

- **Direct downloads** – Grab specific releases without setting up complex monitoring rules
- **Lightweight** – Minimal resource usage and simple configuration
- **Automated organization** – Files are automatically organized by author and book title

---

## How It Works

1. **Search** – Open Gouda and navigate to the search page
2. **Download** – Find your book and click download
3. **Automation begins** – Gouda automatically:
    - Downloads the torrent file
    - Sends it to your configured torrent client
    - Monitors the download progress until completion (with optional timeout)
4. **Organization** – Once complete, Gouda organizes your files:
    - Creates symlinks (or copies if symlinking fails) to your designated complete directory
    - Organizes files in a clean structure:

   ```
   <complete directory>
   ├── <Author Name>
   │   └── <Book Title>
   │       └── <downloaded files>
   ```

---

## Requirements

### MyAnonaMouse Account & API Token

You'll need an active MyAnonaMouse account and an API token to use Gouda:

1. Log in to your MyAnonaMouse account
2. Head over to this [link](https://www.myanonamouse.net/preferences/index.php?view=security)
3. Generate an token
4. Keep this token handy for Gouda configuration

### Supported Torrent Clients

Gouda integrates seamlessly with the following torrent clients:

| Client       | Support Status    | Known Issues |
|--------------|-------------------|--------------|
| Transmission | ✅ Fully supported | None         |
| qBittorrent  | ✅ Fully supported | None         |

## Getting Started

Ready to install? Head over to the [Installation Guide](installation) to get Gouda up and running.

## Configuration

After installing Gouda, you'll need to configure:

- **MyAnonaMouse API token** – Required for authentication and searches
- **Torrent client connection settings** – Host, port, and credentials
- **Complete directory path** – Where your organized files will be stored

Head over to the [setup guide](setup.md)

---

## Support

Have questions or issues? You can ask me on the

- [MAM forum](https://www.myanonamouse.net/f/t/81042)
- [GitHub discussions](https://github.com/RA341/gouda/discussions)
