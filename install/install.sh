#!/bin/bash

GITHUB_USER="ra341"
GITHUB_REPO="gouda"
RELEASE_TAG="latest"

ASSET_FOR_EXTENSION="parmesan_extension.zip"
ASSET_FOR_SERVER="gouda-server-linux"
ASSET_FOR_DESKTOP="gouda-desktop-linux.zip"

DOCKER_COMPOSE_REPO_PATH="install/docker-compose.yml"
DOCKER_COMPOSE_OUTPUT_FILENAME="docker-compose.yml"

# Function to download a release asset
# Usage: download_release_asset "asset_filename_on_github" "output_filename"
download_release_asset() {
  local asset_filename_on_github="$1"
  local output_filename="$2"
  local download_url

  if [ -z "$output_filename" ]; then
    output_filename="$asset_filename_on_github"
  fi

  if [ "$RELEASE_TAG" == "latest" ]; then
    download_url="https://github.com/${GITHUB_USER}/${GITHUB_REPO}/releases/latest/download/${asset_filename_on_github}"
  else
    download_url="https://github.com/${GITHUB_USER}/${GITHUB_REPO}/releases/download/${RELEASE_TAG}/${asset_filename_on_github}"
  fi

  echo "⬇️ Attempting to download RELEASE ASSET: ${asset_filename_on_github}"
  echo "   From URL: ${download_url}"
  echo "   Saving as: ${output_filename}"

  if curl -L --fail -o "${output_filename}" "${download_url}"; then
    echo "✅ Successfully downloaded ${output_filename}"
  else
    echo "❌ ERROR: Failed to download release asset ${asset_filename_on_github}."
    echo "   Please check the following:"
    echo "   1. The asset name '${asset_filename_on_github}' is correct for the release '${RELEASE_TAG}'."
    echo "   2. The release tag '${RELEASE_TAG}' exists."
    echo "   3. The repository '${GITHUB_USER}/${GITHUB_REPO}' is correct and public."
    echo "   4. You have an internet connection."
    return 1
  fi
}

# Function to download a specific file from the repository
# Usage: download_repo_file "path_in_repo" "output_filename" "git_ref"
download_repo_file() {
  local file_path_in_repo="$1"
  local output_filename="$2"
  local git_ref="$3" # Branch or tag
  local download_url

  download_url="https://raw.githubusercontent.com/${GITHUB_USER}/${GITHUB_REPO}/${git_ref}/${file_path_in_repo}"

  echo "⬇️ Attempting to download REPOSITORY FILE: ${file_path_in_repo} (from ref: ${git_ref})"
  echo "   From URL: ${download_url}"
  echo "   Saving as: ${output_filename}"

  if curl -L --fail -o "${output_filename}" "${download_url}"; then
    echo "✅ Successfully downloaded ${output_filename}"
  else
    echo "❌ ERROR: Failed to download repository file ${file_path_in_repo} from ref ${git_ref}."
    echo "   Please check the following:"
    echo "   1. The file path '${file_path_in_repo}' is correct."
    echo "   2. The git reference (branch/tag) '${git_ref}' exists."
    echo "   3. The repository '${GITHUB_USER}/${GITHUB_REPO}' is correct and public."
    echo "   4. You have an internet connection."
    return 1
  fi
}

# Function to unzip an asset and then delete the original zip file
# Usage: unzip_and_cleanup "path/to/yourfile.zip"
unzip_and_cleanup() {
  local zip_file_path="$1"
  local output_dir_name

  # Check if the file path is provided
  if [ -z "$zip_file_path" ]; then
    echo "❌ ERROR (unzip_and_cleanup): No zip file path provided."
    return 1
  fi

  # Check if the file exists
  if [ ! -f "$zip_file_path" ]; then
    echo "❌ ERROR (unzip_and_cleanup): File not found at '$zip_file_path'."
    return 1
  fi

  # Check if the file appears to be a zip file (basic check)
  if [[ "$zip_file_path" != *.zip ]]; then
    echo "⚠️ WARNING (unzip_and_cleanup): File '$zip_file_path' does not have a .zip extension. Attempting to unzip anyway."
  fi

  # Check if unzip command is available
  if ! command -v unzip &> /dev/null; then
    echo "❌ ERROR (unzip_and_cleanup): 'unzip' command not found. Please install it."
    return 1
  fi

  # Derive output directory name (filename without .zip extension)
  # Using basename to get the filename if a path is provided
  local filename
  filename=$(basename "$zip_file_path")
  output_dir_name="${filename%.zip}"

  # Get the directory part of the zip_file_path
  local base_dir
  base_dir=$(dirname "$zip_file_path")
  local full_output_path="${base_dir}/${output_dir_name}"


  echo "⚙️  Processing zip file: ${zip_file_path}"
  echo "   Output directory will be: ${full_output_path}"

  # Create the output directory
  if mkdir -p "$full_output_path"; then
    echo "   Directory created: ${full_output_path}"
  else
    echo "❌ ERROR (unzip_and_cleanup): Failed to create directory '$full_output_path'."
    return 1
  fi

  # Unzip the file into the new directory
  echo "   Unzipping..."
  if unzip -q "$zip_file_path" -d "$full_output_path"; then # -q for quiet
    echo "✅ Successfully unzipped '${zip_file_path}' to '${full_output_path}'"

    # Delete the original zip file if unzip was successful
    if rm "$zip_file_path"; then
      echo "🗑️  Successfully deleted '${zip_file_path}'"
    else
      echo "❌ ERROR (unzip_and_cleanup): Failed to delete '${zip_file_path}'."
      return 1 # Or just a warning if you prefer
    fi
  else
    echo "❌ ERROR (unzip_and_cleanup): Failed to unzip '${zip_file_path}'."
    echo "   The zip file has NOT been deleted."
    return 1
  fi

  return 0
}

# Main Script
if [ -z "$1" ]; then
  echo "Usage: $0 <type>"
  echo "Available types: extension, server, desktop, docker"
  exit 1
fi

ACTION="$1"

C_PRIMARY='\033[1;36m'    # Bright Cyan
C_HIGHLIGHT='\033[1;32m'  # Bright Green
C_SEPARATOR='\033[0;34m'  # Blue
C_NC='\033[0m'            # No Color (to reset)

# Nice Header
LINE_SEPARATOR="${C_SEPARATOR}==================================${C_NC}"
echo -e "${LINE_SEPARATOR}"
echo -e "${C_PRIMARY}🧀  Gouda Installer  🧀${C_NC}"
echo -e "${LINE_SEPARATOR}"
echo -e "https://github.com/${GITHUB_USER}/${GITHUB_REPO}${C_NC}"
echo -e "${C_HIGHLIGHT}Consider leaving a star! ⭐ ${C_NC}"
echo -e "${LINE_SEPARATOR}"

case "$ACTION" in
  extension)
    echo "Downloading 'extension' asset"
    download_release_asset "${ASSET_FOR_EXTENSION}"
    unzip_and_cleanup "${ASSET_FOR_EXTENSION}"
    ;;
  server)
    echo "Downloading 'server' asset"
    download_release_asset "${ASSET_FOR_SERVER}"
    ;;
  desktop)
    echo "Downloading 'desktop' asset"
    download_release_asset "${ASSET_FOR_DESKTOP}"
    unzip_and_cleanup "${ASSET_FOR_DESKTOP}"
    ;;
  docker)
    echo "Downloading 'docker-compose.yml'"
    GIT_REF_FOR_FILE="${RELEASE_TAG}"
    download_repo_file "${DOCKER_COMPOSE_REPO_PATH}" "${DOCKER_COMPOSE_OUTPUT_FILENAME}" "${GIT_REF_FOR_FILE}"
    ;;
  *)
    echo "❌ Error: Invalid type '$ACTION'."
    echo "Available types: extension, server, desktop, docker"
    exit 1
    ;;
esac

exit $?
