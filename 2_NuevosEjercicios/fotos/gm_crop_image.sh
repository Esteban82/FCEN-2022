# Usar graphicsmagick
# ---------------------------------------------------------------------
foto=magick.png

# Obtener dimensiones
#file $foto
#gm identify $foto 
#gm identify -format '%w %h' $foto

# Sintaxis basica para un unico archivo
#gm convert $foto -crop 1000x1000+0+0 crop.png  # width x height + originX + originY
#gm convert $foto -crop 1000x500+0+0 crop2.png  # width x height + originX + originY

# Valores para recortar la imagen (en pixeles)
W=1000
H=500
X=0
Y=200
input=magick.png
output=crop.png
#gm convert $input -crop ${W}x${H}+${X}+${Y} $output

# Recortar en n partes
gm convert $foto -crop 2x1@ +repage qq-%d.png