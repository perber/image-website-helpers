#!/usr/bin/env bash

# Resize all images in a directory to a specific size
# It will overwrite the original image
# It will not resize images that are smaller than the specified size
# It will resize the image in the same ratio as the original image. It will not stretch the image.

# Dependencies: imagemagick

# Usage: resize-images.sh <directory> <max-size>

# Example: resize-images.sh images/ 1024

# Check parameter
if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Usage: $0 <directory> <max-size>"
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

# Check if directory contains images
if [ -z "$(find $1 -type f -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.gif" -o -name "*.bmp")" ]; then
    echo "Directory $1 does not contain images"
    exit 1
fi

# Check if max size is a number
if ! [[ "$2" =~ ^[0-9]+$ ]]; then
    echo "Max size is not a number"
    exit 1
fi

set -xe

# Resize images
echo "Resizing images"
find $1 -type f -name "*.jpg" -exec convert {} -resize $2x$2\> {} \;
find $1 -type f -name "*.jpeg" -exec convert {} -resize $2x$2\> {} \;
find $1 -type f -name "*.png" -exec convert {} -resize $2x$2\> {} \;
find $1 -type f -name "*.gif" -exec convert {} -resize $2x$2\> {} \;
find $1 -type f -name "*.bmp" -exec convert {} -resize $2x$2\> {} \;

