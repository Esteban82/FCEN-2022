# Temas a ver:
# 1. Usar Batch para crear 

# Titulo
Title=47_Provincias
#Title=47_Paises

# 1. Crear lista de paises, territorios, provincias.
cat << EOF > pre.sh
gmt begin
#    gmt coast -E=SA+l > $Title
#    gmt coast -E+n > $Title
   gmt coast -EAR+L  > $Title
gmt end
EOF
# 2. Crear cada imagen.
cat << EOF > main.sh
gmt begin \${BATCH_NAME} pdf #,png
    gmt coast -R\${BATCH_WORD0}+e0.5 -JM10c -Glightgray -Slightblue -B -B+t"\${BATCH_WORD1}" -E\${BATCH_WORD0}+gred+p0.5p
    gmt coast -EAR+p 
    echo \${BATCH_WORD0} | gmt text -F+f16p+jTL+cTL -Gwhite -W1p
gmt end
EOF
# 3. Combinar todos los pdf en un unico archivo y borrar archivos individuales
cat << EOF > post.sh
gmt psconvert -TF \${BATCH_PREFIX}_*.pdf -F\${BATCH_PREFIX}
rm -f \${BATCH_PREFIX}_*.pdf
EOF

# 4. Ejecutar tarea
gmt batch main.sh -Sbpre.sh -Sfpost.sh -T$Title+w"\t" -N$Title -V -Zs -W

rm ${Title}_*.pdf
