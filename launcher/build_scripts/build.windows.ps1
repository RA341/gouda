# build.windows.ps1

# Create build directories
$buildDir = ".\build_output\windows"
New-Item -ItemType Directory -Force -Path "$buildDir"
$buildDir = (Resolve-Path "$buildDir").Path

$apiDir = "$buildDir\api"
$frontendDir = "$buildDir\frontend"

New-Item -ItemType Directory -Force -Path "$apiDir"
New-Item -ItemType Directory -Force -Path "$frontendDir"

try
{
    # 1. Build API server
    Write-Host "Building API server..." -ForegroundColor Green
    Set-Location "../src"
    go build -o "$apiDir\gouda.exe" .

    # 2. Build Flutter app
    Write-Host "Building Flutter app..." -ForegroundColor Green
    Set-Location "../brie"
    flutter build windows --release

    $flutterBuild = "build\windows\x64\runner\Release"
    Copy-Item "$flutterBuild\*" "$frontendDir" -Force -Recurse

    # 3. Build launcher
    Write-Host "Building launcher..." -ForegroundColor Green
    Set-Location "../launcher"
    # use '.' instead of 'main.go' becasue applyOSSpecificAttr
    # will not be able to located if main.go is used
    go build -o "$buildDir\gouda-launcher.exe" -ldflags "-H=windowsgui" .

    Write-Host "Build completed successfully!" -ForegroundColor Green
}
catch
{
    Write-Host "Error: $ErrorMessage" -ForegroundColor Red
}