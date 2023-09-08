#!/usr/bin/env bash
# Converts all image in a directory from HEIC/HEIF to JPG
# It will delete the original HEIC/HEIF file after conversion

# Dependencies: imagemagick

# Usage:
#   convert-heic-heif-to-jpg.sh <directory>

# Example:
#   convert-heic-heif-to-jpg.sh images/

# Check parameter
if [ -z "$1" ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

# Check if imagemagick is installed
if ! command -v convert &> /dev/null; then
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

# Check if directory contains HEIC/HEIF files
if [ -z "$(find $1 -type f -name "*.heic" -o -name "*.heif")" ]; then
    echo "Directory $1 does not contain HEIC/HEIF files"
    exit 1
fi

set -xe

# Convert HEIC/HEIF to JPG and keep original HEIC/HEIF files use imagemagick
echo "Converting HEIC/HEIF to JPG"
find $1 -type f -name "*.heic" -exec convert {} {}.jpg \;
find $1 -type f -name "*.heif" -exec convert {} {}.jpg \;

# rename files with name .heic.jpg and .heif.jpg to .jpg
echo "Renaming files"
find $1 -type f -name "*.heic.jpg" -exec rename 's/\.heic\.jpg/\.jpg/' {} \;
find $1 -type f -name "*.heif.jpg" -exec rename 's/\.heif\.jpg/\.jpg/' {} \;

# Delete original HEIC/HEIF files

echo "Deleting original HEIC/HEIF files"
find $1 -type f -name "*.heic" -exec rm {} \;
find $1 -type f -name "*.heif" -exec rm {} \;