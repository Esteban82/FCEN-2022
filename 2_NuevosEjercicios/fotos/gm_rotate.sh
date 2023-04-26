# Usar graphicsmagick
# ---------------------------------------------------------------------
# Rotar imagen 
# Sintaxis basica para un unico archivo
#gm convert file.png -rotate 90 file_rot90.png

# Rotar todos los archivos con extension jpg en una carpeta
# El archivo de salida tienen el prefijo "rot_90_"
for imagen in *.jpg; do
    gm convert $imagen -rotate 90 rot_90_${imagen}
done;