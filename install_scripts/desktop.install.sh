#!/bin/bash

# Default values
ASSET_NAME="gouda-desktop-linux.zip"
OUTPUT_PATH="./gouda-desktop.zip"

# Create output directory if it doesn't exist
mkdir -p "$OUTPUT_PATH"

# Get the latest release information
echo "Fetching release information..."
RELEASE_INFO=$(curl -s \
    "https://api.github.com/repos/RA341/gouda/releases/latest")

# Get download URL for the asset
DOWNLOAD_URL=$(echo "$RELEASE_INFO" | grep -o "\"browser_download_url\": \"[^\"]*$ASSET_NAME\"" | cut -d\" -f4)

if [ -z "$DOWNLOAD_URL" ]; then
    echo "Error: Asset '$ASSET_NAME' not found in the latest release"
    exit 1
fi

# Download the asset
echo "Downloading $ASSET_NAME..."
curl -L -H "Authorization: token $TOKEN" -o "$ASSET_NAME" "$DOWNLOAD_URL"

if [ $? -ne 0 ]; then
    echo "Error: Failed to download the asset"
    exit 1
fi

# Extract the zip file
echo "Extracting files..."
unzip -o "$ASSET_NAME" -d "$OUTPUT_PATH"

if [ $? -ne 0 ]; then
    echo "Error: Failed to extract the zip file"
    rm -f "$ASSET_NAME"
    exit 1
fi

ABSOLUTE_PATH=$(readlink -f "$OUTPUT_PATH")
echo "Absolute path: $ABSOLUTE_PATH"