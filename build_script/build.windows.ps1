param(
    [Parameter(Mandatory = $true, HelpMessage = "Please specify the build variant. Possible values are 'desktop', 'server', or 'all'.")]
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

# consts
$flutterBuild = "build\windows\x64\runner\Release"
$desktopFrontendDir = "$desktopBuild\frontend"

function CreateServerBuild
{
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
            -X 'github.com/RA341/gouda/utils.Version=$Version'
            -H=windowsgui" `
        -o "$serverBuild\gouda-server-windows.exe" .

    Pop-Location
}

function createFlutterDesktop()
{
    # Build desktop binary
    Write-Host "Building desktop variant..." -ForegroundColor Green

    # flutter windows build
    Push-Location

    Write-Host "Building flutter desktop..." -ForegroundColor Green
    Set-Location "../brie"
    Remove-Item -Path "$desktopFrontendDir" -Recurse -Force -ErrorAction SilentlyContinue
    flutter build windows --release
    Copy-Item "build/web/*" $webSrc -Force -Recurse

    Pop-Location
}

function CreateDesktopBuild
{
    Push-Location

    $desktopBuild = "$buildDir\desktop"

    # setup dir if not exist
    New-Item -ItemType Directory -Force -Path "$desktopBuild"
    New-Item -ItemType Directory -Force -Path "$desktopFrontendDir"
    # clean dirs
    Remove-Item -Path "$desktopBuild" -Recurse -Force -ErrorAction SilentlyContinue

    Copy-Item "$flutterBuild" "$desktopFrontendDir\" -Force -Recurse

    Set-Location "../src"
    # Desktop build
    go build -tags "systray" `
        -ldflags "
            -X 'github.com/RA341/gouda/service.BinaryType=desktop'
            -X 'github.com/RA341/gouda/utils.Version=$Version'
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


function createFlutterWeb()
{
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
}

createFlutterWeb
createFlutterDesktop

# Start jobs
$jobs = @()

if ($Variant -eq "desktop" -or $Variant -eq "all")
{
    $jobs += Start-Job -ScriptBlock {
        param ($BuildDir, $FlutterBuildDir, $Version)
        . $using:BuildDir
        . $using:FlutterBuildDir
        . $using:Version
        CreateDesktopBuild -BuildDir $BuildDir -FlutterBuildDir $FlutterBuildDir -Version $Version
    } -ArgumentList $buildDir, $flutterBuild, $Version
}

if ($Variant -eq "server" -or $Variant -eq "all")
{
    $jobs += Start-Job -ScriptBlock {
        param ($BuildDir, $Version)
        . $using:BuildDir
        . $using:Version
        CreateServerBuild -BuildDir $BuildDir -Version $Version
    } -ArgumentList $buildDir, $Version
}

# Wait for jobs and retrieve results
if ($jobs.Count -gt 0)
{
    Write-Host "Waiting for all jobs to complete..." -ForegroundColor Green
    Wait-Job -Job $jobs
    foreach ($job in $jobs)
    {
        Receive-Job -Job $job
        Remove-Job -Job $job
    }
}

Write-Host "Build completed successfully!" -ForegroundColor Green
