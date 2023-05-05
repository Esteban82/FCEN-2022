# Usar graphicsmagick
# ---------------------------------------------------------------------
foto=magick.png

# Obtener dimensiones
file $foto
gm identify $foto 
gm identify -format '%w %h' $foto

# Cortar imagen 
# Sintaxis basica para un unico archivo
gm convert $foto -crop 1000x1000+0+0 crop.png