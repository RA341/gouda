# PowerShell Script (download_asset.ps1)

$assetName = "gouda-desktop-windows.zip"
$outputPath = "./gouda-desktop"

# Create output directory if it doesn't exist
if (-not (Test-Path $outputPath)) {
    New-Item -ItemType Directory -Path $outputPath | Out-Null
}

# GitHub API Headers
$headers = @{
    'Accept' = 'application/vnd.github.v3+json'
}

try {
    # Get the latest release
    $releaseUrl = "https://api.github.com/repos/ra341/gouda/releases/latest"
    $release = Invoke-RestMethod -Uri $releaseUrl -Headers $headers -Method Get

    # Find the asset
    $asset = $release.assets | Where-Object { $_.name -eq $assetName }

    if ($null -eq $asset) {
        throw "Asset '$assetName' not found in the latest release"
    }

    # Download the asset
    $downloadUrl = $asset.browser_download_url
    $zipPath = Join-Path $PWD "$assetName"

    Write-Host "Downloading $assetName..."
    Invoke-WebRequest -Uri $downloadUrl -Headers $headers -OutFile $zipPath

    # Extract the zip file
    Write-Host "Extracting files..."
    Expand-Archive -Path $zipPath -DestinationPath $outputPath -Force
    $absolutePath = Resolve-Path $outputPath
    Write-Host "Successfully downloaded and extracted to $absolutePath"

    Write-Host "Remvoing zip file: $zipPath"
    Remove-Item $zipPath -Force
}
catch {
    Write-Error "Error: $_"
    exit 1
}
