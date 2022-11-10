# Usar Imagemagick
# ---------------------------------------------------------------------
magick montage fotos/*.jpg -geometry +12+12 -tile 4x2  -shadow  test1.jpg  

#magick montage fotos/*.jpg -thumbnail 300x300 -set caption %t -background grey40 -pointsize 9 -density 144x144 +polaroid -resize 50%  -background white -geometry +1+1 -tile 4x4 -title "Las fotos de mi tesis" polaroid_t.jpg

# Fuente: http://dptnt.com/2008/12/create-photo-montage-with-imagemagick/
# https://legacy.imagemagick.org/Usage/montage/