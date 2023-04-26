# Usar graphicsmagick
# ---------------------------------------------------------------------
# Rotar imagen 
# Sintaxis basica
#gm convert file.png -rotate 90 file_rot90.png

# L
for f in *.jpg; do
    gm convert $f -rotate 90 rot_90_${f}
done;