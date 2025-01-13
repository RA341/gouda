# build.windows.ps1

# Create build directories
$buildDir = ".\build_output\windows"
New-Item -ItemType Directory -Force -Path "$buildDir"
$buildDir = (Resolve-Path "$buildDir").Path

$apiDir = "$buildDir"
$frontendDir = "$buildDir\frontend"

New-Item -ItemType Directory -Force -Path "$apiDir"
New-Item -ItemType Directory -Force -Path "$frontendDir"

try
{
    # 1. Build API server
    Write-Host "Building API server..." -ForegroundColor Green
    Set-Location "../src"
    go build -tags systray -ldflags "-X main.BinaryType=desktop -H=windowsgui" -o "$apiDir\gouda-desktop.exe" .

    # 2. Build Flutter app
    Write-Host "Building Flutter app..." -ForegroundColor Green
    Set-Location "../brie"
    flutter build windows --release
    flutter build web

    $flutterBuild = "build\windows\x64\runner\Release"
    Copy-Item "$flutterBuild\*" "$frontendDir" -Force -Recurse

    Write-Host "Build completed successfully!" -ForegroundColor Green
}
catch
{
    Write-Host "Error: $ErrorMessage" -ForegroundColor Red
}