#!/usr/bin/env bash

# Lists all images in a directory with details. It will list the following details:
# - File name
# - File size
# - File type
# - Image width
# - Image height


# Dependencies: imagemagick

# Usage: list-images-with-details.sh <directory>

# Example: list-images-with-details.sh images/

# Check parameter
if [ -z "$1" ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

# Check if imagemagick is installed
if ! command -v identify &> /dev/null; then
    echo "imagemagick is not installed"
    exit 1
fi

# Check if directory exists
if [ ! -d "$1" ]; then
    echo "Directory $1 does not exist"
    exit 1
fi

# Check if directory is empty
if [ -z "$(ls -A $1)" ]; then
    echo "Directory $1 is empty"
    exit 1
fi

# Check if directory contains images
if [ -z "$(find $1 -type f -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.gif" -o -name "*.bmp")" ]; then
    echo "Directory $1 does not contain images"
    exit 1
fi

# List images with details - the filesize should be in bytes
echo "Listing images with details"
find $1 -type f -name "*.jpg" -exec identify -format '%f %b %w %h\n' {} \;
find $1 -type f -name "*.jpeg" -exec identify -format '%f %b %w %h\n' {} \;
find $1 -type f -name "*.png" -exec identify -format '%f %b %w %h\n' {} \;
find $1 -type f -name "*.gif" -exec identify -format '%f %b %w %h\n' {} \;
find $1 -type f -name "*.bmp" -exec identify -format '%f %b %w %h\n' {} \;
