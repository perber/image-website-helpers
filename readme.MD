# image processing helpers
This helpers are used to prepare images for our own galery.

## Dependencies
You need to install imagemagick with heic support.
The simplest way was to use imei https://github.com/SoftCreatR/imei 

## Usage
**Rename images:** `python3 rename <path> <prefix>`
Runs through the provided directory and changes the filename to the prefix + a number.

**Convert HEIC & HEIF TO JPG:** `./convert-heic-heif-to-jpg.sh <path>`
Runs through the provided directory and converts all HEIC & HEIF files to JPG.

**Resize Images:** `./resize-images.sh <path> <max-size>`
Runs through the provided directory and resizes all images to the max-size.

**List Images with Details:** `./list-images-with-details.sh <path>`
Runs through the provided directory and lists all images with details.

**Generate JSON for Galery:** `python3 generate-json-for-galery <path>`
Runs through the provided directory and prints a json text for the galery.

**To run all steps at once**
You can execute the script `./prepare-images-for-galery.sh`


