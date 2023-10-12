#!/usr/bin/env bash

# runs all scripts in image-tools directory
# input parameter is the directory with images and the prefix for the output files

# Check parameter
if [ -z "$1" ]; then
    echo "Usage: $0 <directory> <prefix>"
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

# Check if prefix is empty
if [ -z "$2" ]; then
    echo "Prefix is empty"
    exit 1
fi



# call rename.py script
python3 rename.py $1 $2

# call convert-heic-heif-to-jpg.sh
./convert-heic-heif-to-jpg.sh $1

# call resize-images.sh
./resize-images.sh $1 1000

# get json for the galery
python3 generate-json-for-galery.py $1
