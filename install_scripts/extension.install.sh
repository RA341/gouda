#!/bin/bash

# Default values
ASSET_NAME="extension.zip"
OUTPUT_PATH="./extracted"

# Function to display usage
usage() {
    echo "Usage: $0 -o <owner> -r <repo> -t <token> [-a <asset_name>] [-p <output_path>]"
    echo "  -o: GitHub repository owner"
    echo "  -r: Repository name"
    echo "  -t: GitHub personal access token"
    echo "  -a: Asset name (default: extension.zip)"
    echo "  -p: Output path (default: ./extracted)"
    exit 1
}

# Parse command line arguments
while getopts "o:r:t:a:p:" opt; do
    case $opt in
        o) OWNER="$OPTARG" ;;
        r) REPO="$OPTARG" ;;
        t) TOKEN="$OPTARG" ;;
        a) ASSET_NAME="$OPTARG" ;;
        p) OUTPUT_PATH="$OPTARG" ;;
        ?) usage ;;
    esac
done

# Check required parameters
if [ -z "$OWNER" ] || [ -z "$REPO" ] || [ -z "$TOKEN" ]; then
    echo "Error: Missing required parameters"
    usage
fi

# Create output directory if it doesn't exist
mkdir -p "$OUTPUT_PATH"

# Get the latest release information
echo "Fetching release information..."
RELEASE_INFO=$(curl -s -H "Authorization: token $TOKEN" \
    "https://api.github.com/repos/$OWNER/$REPO/releases/latest")

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

# Clean up
rm -f "$ASSET_NAME"

echo "Successfully downloaded and extracted to $OUTPUT_PATH"
