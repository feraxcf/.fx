#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

if command -v winget &>/dev/null; then 
    echo "Windows is not supported"
    exit 1
fi

# Define variables
FONT_DIR="$HOME/.local/share/fonts/jetbrains-mono"
TEMP_DIR="/tmp/jetbrains-mono-install"
FONT_ZIP="jetbrains-mono.zip"
FONT_URL="https://download.jetbrains.com/fonts/JetBrainsMono-2.304.zip"

# Print a header for the installation process
echo "Starting JetBrains Mono font installation..."

# Create temporary and font directories
echo "Creating necessary directories..."
mkdir -p "$FONT_DIR"
mkdir -p "$TEMP_DIR"

# Download the font zip file using curl
echo "Downloading JetBrains Mono from $FONT_URL"
curl -L -o "$TEMP_DIR/$FONT_ZIP" "$FONT_URL"

# Unzip the downloaded file
echo "Extracting font files..."
unzip -qq "$TEMP_DIR/$FONT_ZIP" -d "$TEMP_DIR"

# Copy the font files to the font directory, overwriting existing ones
echo "Copying fonts to $FONT_DIR..."
cp "$TEMP_DIR/fonts/ttf/"*.ttf "$FONT_DIR"

# Update the font cache
echo "Updating font cache..."
fc-cache -f -v

# Clean up temporary files
echo "Cleaning up temporary files..."
rm -rf "$TEMP_DIR"

echo "JetBrains Mono font installed successfully!"
echo "You may need to restart applications to see the new font."
