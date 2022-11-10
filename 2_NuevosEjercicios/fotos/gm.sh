# Usar graphicsmagick
# ---------------------------------------------------------------------
# Pegar en horizontal
#convert fotos/Snap-400.jpg fotos/Snap-401.jpg +append hz.jpg

# Pegar en vertical
#convert fotos/Snap-400.jpg fotos/Snap-401.jpg -append vt.jpg

# Hacer mosaico
#gm montage -geometry +12+12 -tile 2x4 fotos/*.jpg gmMontage.jpg
#gm montage -geometry +12+12 -tile 1x7 fotos/*.jpg -bordercolor red gmMontage2.png


# Fuente: http://dptnt.com/2008/12/create-photo-montage-with-imagemagick/
# https://legacy.imagemagick.org/Usage/montage/