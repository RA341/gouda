#!/bin/bash

# Create build directories
BUILD_DIR="./build_output/linux"
API_DIR="$BUILD_DIR/api"
FRONTEND_DIR="$BUILD_DIR/frontend"

mkdir -p "$API_DIR"
mkdir -p "$FRONTEND_DIR"

# Build API server
echo -e "\e[32mBuilding API server...\e[0m"
cd ../src || exit
go build -o "$API_DIR/gouda" .

# Build Flutter app
echo -e "\e[32mBuilding Flutter app...\e[0m"
cd ../brie || exit
flutter build linux --release

# Copy Flutter build output
cp -r build/linux/x64/release/bundle/* "$FRONTEND_DIR/"

# Build launcher
echo -e "\e[32mBuilding launcher...\e[0m"
cd ../launcher || exit

# Create launcher service
cat > gouda.service << EOF
[Unit]
Description=Gouda Application
After=network.target

[Service]
Type=simple
ExecStart=/usr/local/bin/gouda-launcher
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF

# Build the launcher
go build -o "$BUILD_DIR/gouda-launcher" main.go

echo -e "\e[32mBuild completed successfully!\e[0m"

# Make executables executable
chmod +x "$API_DIR/gouda"
chmod +x "$BUILD_DIR/gouda-launcher"
