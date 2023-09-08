# This script generate a json file for the blumenwagner galery
# As input paramter is the path to the images folder needed

import os
import sys
import json

# Check if the path to the images folder is given
if len(sys.argv) != 2:
    print("Please give the path to the images folder as parameter")
    exit(1)

# Get the path to the images folder
path = sys.argv[1]

# Check if the path is valid
if not os.path.isdir(path):
    print("The given path is not a valid folder")
    exit(1)

# run the script list-images-with-details.sh to get the image details
# the details are stored in a variable called stdout
stdout = os.popen("./list-images-with-details.sh " + path).read()

# split the stdout variable into a list
# each list element is a line of the stdout variable
lines = stdout.split("\n")

# the format of the element is like this:
# trauerfloristik-5.jpg - 422093B 750 1000
# the first element is the filename
# the second element is the filesize
# the third element is the width
# the fourth element is the height

# extract the filename, filesize, width and height from each line
# and store them in a list
images = []
header = False
for line in lines:
    if not header:
        header = True
        continue

    if line != "":
        image = line.split(" ")

        # the image size could be B, MB, GB, KB
        # to identify the size of the image we need to check the last characters of the size
        # if the last character is B, KB, MB, GB we need to calculate the size in bytes

        # if the last character is B we don't need to do anything
        # if the last characters are KB we need to multiply the size with 1024
        # if the last characters are MB we need to multiply the size with 1024 * 1024
        # if the last characters are GB we need to multiply the size with 1024 * 1024 * 1024

        if image[1][-2:] == "KB":
            print("KB to B")
            image[1] = int(float(image[1][:-2]) * 1024)
        elif image[1][-2:] == "MB":
            print(f"MB to B {image[1]} -> {int(float(image[1][:-2]) * 1024 * 1024)}")
            image[1] = int(float(image[1][:-2]) * 1024 * 1024)
        elif image[1][-2:] == "GB":
            print("GB to B")
            image[1] = int(float(image[1][:-2]) * 1024 * 1024 * 1024)
        elif image[1][-1] == "B":
            print("B to B")
            image[1] = image[1][:-1]            

        images.append({
            "type": "image",
            "fileName": image[0],
            "origFileName": image[0],
            "fileSize": image[1],
            "width": image[2],
            "height": image[3],
            "url": os.path.join("images", path, image[0])
        })

# the filename looks like this: trauerfloristik-5.jpg. 
# the images list needs to be sorted by the number at the end of the filename.
# the number is the index of the image in the galery

images.sort(key=lambda x: int(x["fileName"].split("-")[1].split(".")[0]))

data = {
    "group": "Fotogalerie",
    "items": images
}

# output the data as json to stdout so it can be piped to a file or something else
# the json should be pretty printed
print(json.dumps(data, indent=4))
