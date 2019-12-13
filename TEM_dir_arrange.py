# -*- coding: utf-8 -*-
# Created: 2019/12/12, Kosuke Kikuchi

import os, sys
from time import localtime, strftime
from PIL import Image

# BMP2JPEG_conversion --- True: Allow conversion, False: DONT convert into .jpg
BMP2JPEG_conversion = True

def main():
    # Check the input date for new directory name, otherwise the current date will be used
    if len(sys.argv) > 1:
        date_dir = sys.argv[2]
    else:
        date_dir = str(strftime("%y%m%d", localtime()))

    # Load all files within the current directory
    files = os.listdir()
    for file in files:
        root, ext = os.path.splitext(file)

        if BMP2JPEG_conversion == True:
            # Conversion of .bmp into .jpg
            if ext == '.bmp':
                # Open .bmp with PIL and save as .jpg
                img = Image.open(file)
                new_jpg = "%s.jpg" % file[:-4]
                img.save(new_jpg)
                img.close()
                # Rename and transfer .bmp
                ren_bmp = "%s_bmp\\%s.bmp" % (date_dir, file[:-4])
                ren_jpg = "%s_jpg\\%s.jpg" % (date_dir, file[:-4])
                os.renames(file, ren_bmp)
                os.renames(new_jpg, ren_jpg)
            # Rename and transfer .txt and .tif
            elif ext == '.txt' or '.tif':
                ren_pos = "%s_%s\\%s" % (date_dir, file[-3:], file)
                os.renames(file, ren_pos)
            else:
                pass
        else:
            # Rename and transfer .bmp, .txt and .tif
            if ext == '.txt' or '.bmp' or '.tif':
                new_pos = "%s_%s\\%s" % (date_dir, file[-3:], file)
                os.renames(file, new_pos)
            else:
                pass
    print("### The files have been successfully classified! ###")

if __name__ == '__main__':
    main()
