param(
    [Parameter(Mandatory=$true, HelpMessage="Please specify the build variant. Possible values are 'desktop', 'server', or 'all'.")]
    [string]$Variant, # build variant, possible values: desktop, server, all
    [string]$Version = "dev"  # Optional parameter with a default value
)

Write-Output "Building with variant:$Variant and version:$Version"

# install deps
Write-Output "Installing 7zip"
winget install --id 7zip.7zip --silent --accept-package-agreements

# Create directories
$buildDir = ".\build_output\windows"
New-Item -ItemType Directory -Force -Path "$buildDir"
$buildDir = (Resolve-Path "$buildDir").Path

function CreateServerBuild {
    Push-Location

    $serverBuild = "$buildDir\server"

    New-Item -ItemType Directory -Force -Path "$serverBuild"

    # clean dirs
    Remove-Item -Path "$serverBuild" -Recurse -Force -ErrorAction SilentlyContinue

    # build server varaint
    Write-Host "Building server variant..." -ForegroundColor Green
    Set-Location "../src"

    # server build
    go build `
        -ldflags "
            -X 'github.com/RA341/gouda/service.Version=$Version'
            -H=windowsgui" `
        -o "$serverBuild\gouda-server-windows.exe" .

    Pop-Location
}

function CreateDesktopBuild {
    Push-Location

    $desktopBuild = "$buildDir\desktop"
    $desktopFrontendDir = "$desktopBuild\frontend"

    # setup dir if not exist
    New-Item -ItemType Directory -Force -Path "$desktopBuild"
    New-Item -ItemType Directory -Force -Path "$desktopFrontendDir"
    # clean dirs
    Remove-Item -Path "$desktopBuild" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item -Path "$desktopFrontendDir" -Recurse -Force -ErrorAction SilentlyContinue

    # Build desktop binary
    Write-Host "Building desktop variant..." -ForegroundColor Green

    # flutter windows build
    Push-Location

    Write-Host "Building flutter desktop..." -ForegroundColor Green
    Set-Location "../brie"
    flutter build windows --release
    Copy-Item "build/web/*" $webSrc -Force -Recurse
    $flutterBuild = "build\windows\x64\runner\Release"
    Copy-Item "$flutterBuild" "$desktopFrontendDir\" -Force -Recurse

    Pop-Location

    Set-Location "../src"
    # Desktop build
    go build -tags "systray" `
        -ldflags "
            -X 'github.com/RA341/gouda/service.BinaryType=desktop'
            -X 'github.com/RA341/gouda/service.Version=$Version'
            -H=windowsgui" `
        -o "$desktopBuild\gouda-desktop.exe" .

    Set-Location $desktopBuild

    $desktopZip = "gouda-desktop-windows.zip"

    # zip files
    7z a $desktopZip .
    # remove original files
    Remove-Item * -Recurse -Force -Exclude $desktopZip

    Pop-Location
}


Push-Location

# build flutter web and copy to gouda src
$webSrc = "../src/web"
Write-Host "Building Flutter for web..." -ForegroundColor Green
Set-Location "../brie"
flutter pub get
flutter build web --release

New-Item -ItemType Directory -Force -Path $webSrc
# clean web dir before copying
Remove-Item -Path "$webSrc/*" -Recurse -Force -ErrorAction SilentlyContinue
Copy-Item "build/web/*" $webSrc -Force -Recurse

Pop-Location

if ($Variant.Equals("desktop") -or $Variant.Equals("all")) {
    CreateDesktopBuild
}

if ($Variant.Equals("server") -or $Variant.Equals("all")) {
    CreateServerBuild
} else {
    Write-Host "Invalid build variant: $Variant" -ForegroundColor Red
}

Write-Host "Build completed successfully!" -ForegroundColor Green
