import argparse
import os
import shutil
import subprocess
import sys
from pathlib import Path

SCRIPT_DIR = Path(__file__).parent.resolve()
SRC_DIR = (SCRIPT_DIR / "../src").resolve()
BRIE_DIR = (SCRIPT_DIR / "../brie").resolve()
# --- Create Base Build Directory ---
BUILD_OUTPUT_DIR = (SCRIPT_DIR / "build_output" / "windows").resolve()
WEB_SRC_DIR = (SRC_DIR / "cmd" / "web").resolve()

def run_command(command, cwd=None, check=True, shell=False):
    """Runs a command using subprocess and prints output."""
    print(f"Executing: {' '.join(command)} in {cwd or os.getcwd()}")
    try:
        # On Windows, shell=True might be needed for commands like winget or 7z
        # if they are not directly in PATH or are shell built-ins/aliases.
        # However, it's generally safer to use shell=False if possible.
        # For winget and 7z, ensure they are in the system's PATH.
        process = subprocess.run(
            command,
            cwd=cwd,
            check=check,
            capture_output=True,
            text=True,
            shell=shell  # Set shell=True if encountering issues finding commands like 7z
        )
        if process.stdout:
            print("Output:\n", process.stdout)
        if process.stderr:
            print("Error Output:\n", process.stderr, file=sys.stderr)
        return process
    except subprocess.CalledProcessError as e:
        print(f"Error executing command: {' '.join(command)}", file=sys.stderr)
        print(f"Return code: {e.returncode}", file=sys.stderr)
        if e.stdout:
            print("Stdout:", e.stdout, file=sys.stderr)
        if e.stderr:
            print("Stderr:", e.stderr, file=sys.stderr)
        # sys.exit(1)  # Exit if a crucial command fails
    except FileNotFoundError:
        print(f"Error: Command not found - {command[0]}. Ensure it's installed and in PATH.", file=sys.stderr)
        sys.exit(1)


def clean_dir(dir_path):
    """Removes and recreates a directory."""
    path = Path(dir_path)
    if path.exists():
        print(f"Cleaning directory: {path}")
        shutil.rmtree(path)
    print(f"Creating directory: {path}")
    path.mkdir(parents=True, exist_ok=True)


def create_server_build(version):
    """Builds the server variant."""
    server_build_dir = (BUILD_OUTPUT_DIR / "server").resolve()
    clean_dir(server_build_dir)

    print("\033[92mBuilding server variant...\033[0m")  # Green text

    ldflags = f"-X 'github.com/RA341/gouda/pkg.Version={version}' -H=windowsgui"
    output_path = server_build_dir / "gouda-server-windows.exe"
    command = [
        "go", "build",
        "-ldflags", ldflags,
        "-o", str(output_path),
        "./cmd/server"
    ]
    run_command(command, cwd=SRC_DIR)
    print(f"Server build completed: {output_path}")


def create_desktop_build(version):
    """Builds the desktop variant."""
    desktop_build_dir = (BUILD_OUTPUT_DIR / "desktop").resolve()
    desktop_frontend_dir = (desktop_build_dir / "frontend").resolve()

    # Clean directories first
    if desktop_build_dir.exists():
        print(f"Cleaning directory: {desktop_build_dir}")
        shutil.rmtree(desktop_build_dir)
    # Recreate main build dir, frontend dir will be created by copy later or manually
    desktop_build_dir.mkdir(parents=True, exist_ok=True)
    # No need to clean frontend dir specifically if parent is cleaned

    print("\033[92mBuilding desktop variant...\033[0m")  # Green text

    # --- Build Flutter Desktop ---
    print("\033[92mBuilding flutter desktop...\033[0m")  # Green text
    flutter_build_command = ["flutter", "build", "windows", "--release"]
    run_command(flutter_build_command, cwd=BRIE_DIR)

    flutter_build_output = BRIE_DIR / "build" / "windows" / "x64" / "runner" / "Release"
    if not flutter_build_output.exists():
        print(f"Error: Flutter build output not found at {flutter_build_output}", file=sys.stderr)
        sys.exit(1)

    print(f"Copying Flutter build from {flutter_build_output} to {desktop_frontend_dir}")
    shutil.copytree(flutter_build_output, desktop_frontend_dir, dirs_exist_ok=True)
    # --- Build Go Desktop ---
    print("\033[92mBuilding Go desktop...\033[0m")  # Green text
    ldflags = f"-X 'github.com/RA341/gouda/pkg.Version={version}' -H=windowsgui"
    output_path = desktop_build_dir / "gouda-desktop.exe"
    go_build_command = [
        "go", "build", "-tags", "systray",
        "-ldflags", ldflags,
        "-o", str(output_path),
        "./cmd/desktop"
    ]
    run_command(go_build_command, cwd=SRC_DIR)

    # --- Zip Desktop Build ---
    print("Zipping desktop build...")
    desktop_zip_path = desktop_build_dir / "gouda-desktop-windows.zip"

    # Use 7z command line tool
    # Note: Ensure '7z' is in the system PATH or provide the full path.
    # Using shell=True might be necessary on Windows if '7z' isn't directly executable
    # or if you need shell features, but be cautious about security implications.
    # '.' means zip the contents of the current directory (desktop_build_dir)
    zip_command = ["7z", "a", str(desktop_zip_path), "."]
    run_command(zip_command, cwd=desktop_build_dir, shell=True)  # shell=True often needed for 7z

    # --- Clean up original files ---
    print("Cleaning up original desktop files...")
    for item in desktop_build_dir.iterdir():
        if item.is_file() and item.name != desktop_zip_path.name:
            print(f"Removing file: {item}")
            item.unlink()
        elif item.is_dir():
            print(f"Removing directory: {item}")
            shutil.rmtree(item)

    print(f"Desktop build completed and zipped: {desktop_zip_path}")


def build_flutter_web():
    """Builds Flutter web and copies to Go web source."""
    print("\033[92mBuilding Flutter for web...\033[0m")  # Green text

    # Ensure dependencies are up-to-date
    print("Running flutter pub get...")
    run_command(["flutter", "pub", "get"], cwd=BRIE_DIR, shell=True)

    # Build flutter web
    print("Running flutter build web...")
    run_command(["flutter", "build", "web", "--release"], cwd=BRIE_DIR, shell=True)

    flutter_web_build_output = BRIE_DIR / "build" / "web"

    if not flutter_web_build_output.exists():
        print(f"Error: Flutter web build output not found at {flutter_web_build_output}", file=sys.stderr)
        sys.exit(1)

    clean_dir(WEB_SRC_DIR)

    print(f"Copying Flutter web build from {flutter_web_build_output} to {WEB_SRC_DIR}")
    shutil.copytree(flutter_web_build_output, WEB_SRC_DIR, dirs_exist_ok=True)
    print("Flutter web build copied successfully.")


def main():
    parser = argparse.ArgumentParser(description="Build script for Gouda project.")
    parser.add_argument(
        "--variant",
        required=True,
        choices=['desktop', 'server', 'all'],
        help="Specify the build variant: 'desktop', 'server', or 'all'."
    )
    parser.add_argument(
        "--version",
        default="dev",
        help="Specify the build version (default: 'dev')."
    )
    args = parser.parse_args()

    print(f"Building with variant: {args.variant} and version: {args.version}")

    # --- Install Dependencies ---
    print("Installing 7zip...")
    # Using shell=True as winget might require it depending on setup
    run_command([
        "winget", "install", "--id", "7zip.7zip",
        "--silent", "--accept-package-agreements"
    ], shell=False)  # Added shell=True

    BUILD_OUTPUT_DIR.mkdir(parents=True, exist_ok=True)
    print(f"Ensured build directory exists: {BUILD_OUTPUT_DIR}")

    build_flutter_web()

    build_desktop = False
    build_server = False

    if args.variant in ["desktop", "all"]:
        build_desktop = True
    if args.variant in ["server", "all"]:
        build_server = True

    if not build_desktop and not build_server:
        # This case should technically be prevented by argparse choices, but good practice
        print(f"\033[91mInvalid build variant: {args.variant}\033[0m", file=sys.stderr)  # Red text
        sys.exit(1)

    if build_desktop:
        create_desktop_build(args.version)

    if build_server:
        create_server_build(args.version)

    print("\033[92mBuild completed successfully!\033[0m")  # Green text


if __name__ == "__main__":
    main()
