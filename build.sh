#!/bin/bash

# Check if script has executable permissions
if [ ! -x "$0" ]; then
    echo "Error: Script does not have executable permissions."
    echo "Please run: chmod +x $0"
    echo "Then try again."
    exit 1
fi

# Check if zip command is available
if ! command -v zip >/dev/null 2>&1; then
    echo "Error: zip command not found"
    echo "Please install zip utility first:"
    echo "  macOS: brew install zip"
    echo "  Linux: sudo apt-get install zip"
    exit 1
fi

echo "Starting extension build process..."

# Define paths
V2_SOURCE="./v2"
V3_SOURCE="./v3"
BUILD_DIR="./build"
V2_OUTPUT="popup-blocker-v2.zip"
V3_OUTPUT="popup-blocker-v3.zip"

# Clean previous builds
echo "Cleaning previous builds..."
rm -f "$V2_OUTPUT" "$V3_OUTPUT"
rm -rf "$BUILD_DIR"
mkdir -p "$BUILD_DIR"

# Build V2 version
if [ -d "$V2_SOURCE" ]; then
    echo "Building V2 extension..."
    cp -R "$V2_SOURCE/"* "$BUILD_DIR/"
    (cd "$BUILD_DIR" && zip -r "../$V2_OUTPUT" ./* -x "*.DS_Store" "*.git*" "node_modules/*")
    rm -rf "$BUILD_DIR"/*
fi

# Build V3 version with Firefox compatibility
if [ -d "$V3_SOURCE" ]; then
    echo "Building V3 extension..."
    cp -R "$V3_SOURCE/"* "$BUILD_DIR/"
    
    # Modify manifest for Firefox compatibility
    if [ -f "$BUILD_DIR/manifest.json" ]; then
        # Create Firefox-compatible manifest
        sed -i.bak 's/"service_worker"/"scripts"/' "$BUILD_DIR/manifest.json"
        rm "$BUILD_DIR/manifest.json.bak"
    fi
    
    (cd "$BUILD_DIR" && zip -r "../$V3_OUTPUT" ./* -x "*.DS_Store" "*.git*" "node_modules/*")
fi

# Clean up
rm -rf "$BUILD_DIR"

echo "Extension builds complete!"
[ -f "$V2_OUTPUT" ] && echo "Created: $V2_OUTPUT"
[ -f "$V3_OUTPUT" ] && echo "Created: $V3_OUTPUT"
exit 0
