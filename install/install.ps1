#Requires -Version 5.0 # For Expand-Archive and Invoke-WebRequest

#------------------------------------------------------------------------------
# Configuration Variables
#------------------------------------------------------------------------------
$GITHUB_USER = "ra341"
$GITHUB_REPO = "gouda"
$RELEASE_TAG = "latest" # Can be a specific tag like "v1.0.0"

$ASSET_FOR_EXTENSION = "parmesan_extension.zip"
$ASSET_FOR_SERVER = "gouda-server-windows.exe"
$ASSET_FOR_DESKTOP = "gouda-desktop-windows.zip"

$DOCKER_COMPOSE_REPO_PATH = "install/docker-compose.yml"
$DOCKER_COMPOSE_OUTPUT_FILENAME = "docker-compose.yml"

#------------------------------------------------------------------------------
# Helper Functions
#------------------------------------------------------------------------------

# Function to download a release asset
# Usage: download_release_asset -asset_filename_on_github "asset.zip" [-output_filename "new_name.zip"]
function download_release_asset {
    param(
        [Parameter(Mandatory=$true)]
        [string]$asset_filename_on_github,

        [string]$output_filename
    )

    if ([string]::IsNullOrEmpty($output_filename)) {
        $output_filename = $asset_filename_on_github
    }

    $download_url = ""
    if ($RELEASE_TAG -eq "latest") {
        $download_url = "https://github.com/$($GITHUB_USER)/$($GITHUB_REPO)/releases/latest/download/$($asset_filename_on_github)"
    } else {
        # Corrected line below:
        $download_url = "https://github.com/$($GITHUB_USER)/$($GITHUB_REPO)/releases/download/$($RELEASE_TAG)/$($asset_filename_on_github)"
    }

    Write-Host "⬇️ Attempting to download RELEASE ASSET: $($asset_filename_on_github)"
    Write-Host "   From URL: $($download_url)"
    Write-Host "   Saving as: $($output_filename)"

    try {
        Invoke-WebRequest -Uri $download_url -OutFile $output_filename -UseBasicParsing -ErrorAction Stop
        Write-Host "✅ Successfully downloaded $($output_filename)" -ForegroundColor Green
        return $true
    } catch {
        Write-Host "❌ ERROR: Failed to download release asset $($asset_filename_on_github)." -ForegroundColor Red
        Write-Host "   Download URL: $($download_url)"
        Write-Host "   Output file: $($output_filename)"
        Write-Host "   Error details: $($_.Exception.Message)" -ForegroundColor Red
        Write-Host "   Please check the following:"
        Write-Host "   1. The asset name '$($asset_filename_on_github)' is correct for the release '$($RELEASE_TAG)'."
        Write-Host "   2. The release tag '$($RELEASE_TAG)' exists."
        Write-Host "   3. The repository '$($GITHUB_USER)/$($GITHUB_REPO)' is correct and public."
        Write-Host "   4. You have an internet connection."
        return $false
    }
}

# Function to download a specific file from the repository
# Usage: download_repo_file -file_path_in_repo "path/file.txt" -output_filename "out.txt" -git_ref "main"
function download_repo_file {
    param(
        [Parameter(Mandatory=$true)]
        [string]$file_path_in_repo,

        [Parameter(Mandatory=$true)]
        [string]$output_filename,

        [Parameter(Mandatory=$true)]
        [string]$git_ref # Branch or tag
    )

    $download_url = "https://raw.githubusercontent.com/$($GITHUB_USER)/$($GITHUB_REPO)/$($git_ref)/$($file_path_in_repo)"

    Write-Host "⬇️ Attempting to download REPOSITORY FILE: $($file_path_in_repo) (from ref: $($git_ref))"
    Write-Host "   From URL: $($download_url)"
    Write-Host "   Saving as: $($output_filename)"

    try {
        Invoke-WebRequest -Uri $download_url -OutFile $output_filename -UseBasicParsing -ErrorAction Stop
        Write-Host "✅ Successfully downloaded $($output_filename)" -ForegroundColor Green
        return $true
    } catch {
        Write-Host "❌ ERROR: Failed to download repository file $($file_path_in_repo) from ref $($git_ref)." -ForegroundColor Red
        Write-Host "   Download URL: $($download_url)"
        Write-Host "   Output file: $($output_filename)"
        Write-Host "   Error details: $($_.Exception.Message)" -ForegroundColor Red
        Write-Host "   Please check the following:"
        Write-Host "   1. The file path '$($file_path_in_repo)' is correct."
        Write-Host "   2. The git reference (branch/tag) '$($git_ref)' exists."
        Write-Host "   3. The repository '$($GITHUB_USER)/$($GITHUB_REPO)' is correct and public."
        Write-Host "   4. You have an internet connection."
        return $false
    }
}

# Function to unzip an asset and then delete the original zip file
# Usage: unzip_and_cleanup -zip_file_path "path/to/yourfile.zip"
function unzip_and_cleanup {
    param(
        [Parameter(Mandatory=$true)]
        [string]$zip_file_path
    )

    # Check if the file exists
    if (-not (Test-Path -Path $zip_file_path -PathType Leaf)) {
        Write-Host "❌ ERROR (unzip_and_cleanup): File not found at '$($zip_file_path)'." -ForegroundColor Red
        return $false
    }

    # Check if the file appears to be a zip file (basic check)
    if ($zip_file_path -notlike "*.zip") {
        Write-Host "⚠️ WARNING (unzip_and_cleanup): File '$($zip_file_path)' does not have a .zip extension. Attempting to unzip anyway." -ForegroundColor Yellow
    }

    # Derive output directory name (filename without .zip extension)
    $filename = Split-Path -Path $zip_file_path -Leaf
    $output_dir_name = $filename -replace '\.zip$', '' # Remove .zip extension

    # Get the directory part of the zip_file_path
    $base_dir = Split-Path -Path $zip_file_path -Parent
    if ([string]::IsNullOrEmpty($base_dir)) {
        $base_dir = Get-Location # Use current directory if $zip_file_path is just a filename
    }
    $full_output_path = Join-Path -Path $base_dir -ChildPath $output_dir_name


    Write-Host "⚙️  Processing zip file: $($zip_file_path)"
    Write-Host "   Output directory will be: $($full_output_path)"

    # Create the output directory
    try {
        if (-not (Test-Path -Path $full_output_path -PathType Container)) {
            New-Item -ItemType Directory -Path $full_output_path -Force -ErrorAction Stop | Out-Null
            Write-Host "   Directory created: $($full_output_path)"
        } else {
            Write-Host "   Output directory already exists: $($full_output_path)"
        }
    } catch {
        Write-Host "❌ ERROR (unzip_and_cleanup): Failed to create directory '$($full_output_path)'." -ForegroundColor Red
        Write-Host "   Error details: $($_.Exception.Message)" -ForegroundColor Red
        return $false
    }

    # Unzip the file into the new directory
    Write-Host "   Unzipping..."
    try {
        Expand-Archive -Path $zip_file_path -DestinationPath $full_output_path -Force -ErrorAction Stop # -Force to overwrite files
        Write-Host "✅ Successfully unzipped '$($zip_file_path)' to '$($full_output_path)'" -ForegroundColor Green

        # Delete the original zip file if unzip was successful
        try {
            Remove-Item -Path $zip_file_path -Force -ErrorAction Stop
            Write-Host "🗑️  Successfully deleted '$($zip_file_path)'"
        } catch {
            Write-Host "❌ ERROR (unzip_and_cleanup): Failed to delete '$($zip_file_path)'." -ForegroundColor Red
            Write-Host "   Error details: $($_.Exception.Message)" -ForegroundColor Red
            return $false
        }
    } catch {
        Write-Host "❌ ERROR (unzip_and_cleanup): Failed to unzip '$($zip_file_path)'." -ForegroundColor Red
        Write-Host "   Error details: $($_.Exception.Message)" -ForegroundColor Red
        Write-Host "   The zip file has NOT been deleted."
        return $false
    }

    return $true
}

#------------------------------------------------------------------------------
# Main Script Logic
#------------------------------------------------------------------------------
if ($Args.Count -eq 0 -or [string]::IsNullOrEmpty($Args[0])) {
    Write-Host "Usage: $($MyInvocation.MyCommand.Name) <type>"
    Write-Host "Available types: extension, server, desktop, docker"
    return
}

$ACTION = $Args[0].ToLower() # Convert to lowercase for case-insensitive comparison

# PowerShell approximate colors (Foreground)
$C_PRIMARY_FG = "Cyan"
$C_HIGHLIGHT_FG = "Green"
$C_SEPARATOR_FG = "Blue"

# Nice Header
$LINE_SEPARATOR_TEXT = "=" * 34
Write-Host $LINE_SEPARATOR_TEXT -ForegroundColor $C_SEPARATOR_FG
Write-Host "🧀  Gouda Installer  🧀" -ForegroundColor $C_PRIMARY_FG
Write-Host $LINE_SEPARATOR_TEXT -ForegroundColor $C_SEPARATOR_FG
Write-Host "https://github.com/$($GITHUB_USER)/$($GITHUB_REPO)"
Write-Host "Consider leaving a star! ⭐ " -ForegroundColor $C_HIGHLIGHT_FG
Write-Host $LINE_SEPARATOR_TEXT -ForegroundColor $C_SEPARATOR_FG

$script_failed = $false # Flag to track if any operation fails

switch ($ACTION) {
    "extension" {
        Write-Host "Downloading 'extension' asset"
        if (download_release_asset -asset_filename_on_github $ASSET_FOR_EXTENSION) {
            if (-not (unzip_and_cleanup -zip_file_path $ASSET_FOR_EXTENSION)) {
                $script_failed = $true
            }
        } else {
            $script_failed = $true
        }
    }
    "server" {
        Write-Host "Downloading 'server' asset"
        if (-not (download_release_asset -asset_filename_on_github $ASSET_FOR_SERVER)) {
            $script_failed = $true
        }
    }
    "desktop" {
        Write-Host "Downloading 'desktop' asset"
        if (download_release_asset -asset_filename_on_github $ASSET_FOR_DESKTOP) {
            if (-not (unzip_and_cleanup -zip_file_path $ASSET_FOR_DESKTOP)) {
                $script_failed = $true
            }
        } else {
            $script_failed = $true
        }
    }
    "docker" {
        Write-Host "Downloading 'docker-compose.yml'"
        $GIT_REF_FOR_FILE = $RELEASE_TAG
        if (-not (download_repo_file -file_path_in_repo $DOCKER_COMPOSE_REPO_PATH -output_filename $DOCKER_COMPOSE_OUTPUT_FILENAME -git_ref $GIT_REF_FOR_FILE)) {
            $script_failed = $true
        }
    }
    default {
        Write-Host "❌ Error: Invalid type '$($ACTION)'." -ForegroundColor Red
        Write-Host "Available types: extension, server, desktop, docker"
        $script_failed = $true
    }
}

if ($script_failed) {
    Write-Host "Error" -ForegroundColor Red
} else {
    Write-Host "✅ All operations completed successfully." -ForegroundColor Green
}