# Desc: Rename all files in a directory and lowercases them. 
# It also will change the file extensions from known extensions to the shorter version.
# Usage: python rename.py <directory> <prefix>
# Example: python rename.py ./images/ trauerfloristik-
# Output: trauerfloristik-1.jpg, trauerfloristik-2.jpg, trauerfloristik-3.jpg, etc.


import os
import sys

# check count of arguments
if len(sys.argv) != 3:
    print('Usage: python rename.py <directory> <prefix>')
    sys.exit()

directory = sys.argv[1]
prefix = sys.argv[2]

# check if directory exists
if not os.path.exists(directory):
    print('Directory does not exist')
    sys.exit()

# check if a prefix was provided
if not prefix:
    print('Prefix not provided')
    sys.exit()

# list of known file extensions
extensions = {
    'jpeg': 'jpg',
    'tiff': 'tif',
    'png': 'png',
    'gif': 'gif',
    'webp': 'webp',
    'jfif': 'jfif',
    'heic': 'heic',
    'heif': 'heif',
    'svg': 'svg',
    'bmp': 'bmp',
    'ico': 'ico',
}

i = 0
for filename in os.listdir(directory):
    
    i = i + 1

    # lowercase filename
    filename_lower = filename.lower()

    # get file extension
    extension = filename_lower.split('.')[-1]

    # check if file extension is known
    if extension in extensions:
        extension = extensions[extension]

    # strip extension from filename, read from the end to avoid issues with periods in the filename
    filename_lower = '.'.join(filename_lower.split('.')[:-1])

    # create new filename
    new_filename = f"{prefix}{i}.{extension}"

    print("rename " + filename + " to " + new_filename + "")

    # rename file
    os.rename(os.path.join(directory, filename), os.path.join(directory, new_filename))
