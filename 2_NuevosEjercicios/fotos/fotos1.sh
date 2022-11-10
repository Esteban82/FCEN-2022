#!/usr/bin/env bash

#gmt begin fotos1 png
#    gmt image fotos/Snap-400.jpg -Dx0/0+w5c 
#    gmt image fotos/Snap-401.jpg -Dx0/0+w5c -X5c
#    gmt image fotos/Snap-401.jpg -Dx0/0+w5c -Y4.1c
#gmt end # show


# Pegar en horizontal
#convert fotos/Snap-400.jpg fotos/Snap-401.jpg +append hz.jpg

# Pegar en vertical
#convert fotos/Snap-400.jpg fotos/Snap-401.jpg -append vt.jpg

# Hacer mosaico
gm montage -geometry 640x480  -tile 2x3 fotos/*.jpg Montage.jpg
gm montage -geometry 640x480 -tile 2x3 fotos/*.jpg -bordercolor red Montage2.png

