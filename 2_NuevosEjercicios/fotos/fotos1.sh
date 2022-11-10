#!/usr/bin/env bash

#gmt begin fotos1 png
#    gmt image fotos/Snap-400.jpg -Dx0/0+w5c 
#    gmt image fotos/Snap-401.jpg -Dx0/0+w5c -X5c
#    gmt image fotos/Snap-401.jpg -Dx0/0+w5c -Y4.1c
#gmt end # show


# Pegar en horizontal
#ma

# Pegar en vertical
#convert fotos/Snap-400.jpg fotos/Snap-401.jpg -append vt.jpg

# Hacer mosaico
gm montage -geometry +12+12 -tile 2x4 fotos/*.jpg gmMontage.jpg
gm montage -geometry +12+12 -tile 1x7 fotos/*.jpg -bordercolor red gmMontage2.png
#gm montage -geometry 640x480 -tile 2x3 fotos/*.jpg -bordercolor red gmMontage2.png

# Usar Imagemagick

magick montage -geometry +12+12 -tile 4x2 fotos/*.jpg montage.jpg

#montage 2008*.jpg -thumbnail 300x300 -set caption %t -bordercolor #E6E6FA  -background grey40 -pointsize 9 -density 144x144 +polaroid -resize 50%  -background white -geometry +1+1 -tile 4x4 -title "Las Vegas Travel 2008" polaroid_t.jpg
magick montage fotos/*.jpg -thumbnail 300x300 -set caption %t -background grey40 -pointsize 9 -density 144x144 +polaroid -resize 50%  -background white -geometry +1+1 -tile 4x4 -title "Las fotos de mi tesis" polaroid_t.jpg

# Fuente: http://dptnt.com/2008/12/create-photo-montage-with-imagemagick/
