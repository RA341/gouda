---
title: Help

---

# Setup

Follow these steps to setup gouda

1. Configure Gouda for your [platform](/docs/category/installation).
2. Access the web interface at `http://your-ip:9862` to:
    - Set up your check (support here [torrent client](intro.md#supported-torrent-clients))
        - Important: Disable the temporary folder in Transmission
    - Configure your [categories](category)
    - Verify your paths and permissions:
        - Download path
        - Complete path
        - Linux UID/GID permissions (for Linux/macOS or Docker installations)
3. If gouda is running externally i.e. not on your computer you may need to setup a [reverse proxy](reverse-proxy).
4. Install and set up the [browser extension](extension).