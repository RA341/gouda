---
title: windows
---
# Windows

**Setup gouda for windows**


### Windows

* Server
    ```powershell
    & ([scriptblock]::Create((Invoke-RestMethod 'https://raw.githubusercontent.com/RA341/gouda/refs/heads/main/install/install.ps1'))) 'server'
    ```

* Desktop
    ```powershell
    & ([scriptblock]::Create((Invoke-RestMethod 'https://raw.githubusercontent.com/RA341/gouda/refs/heads/main/install/install.ps1'))) 'desktop'
    ```
