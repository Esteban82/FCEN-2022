#!/usr/bin/env bash

# Crear lista de fotos en carpeta
#ls fotos/* > tmp_lista

gmt begin fotos2 png
    #gmt image -JX? fotos/Snap-401.jpg
    #gmt image -c fotos/Snap-402.jpg
    #gmt image -c fotos/Snap-403.jpg
    #gmt image -c fotos/Snap-400.jpg
    #gmt image -c fotos/Snap-401.jpg
gmt end # show

# Borrar lista
#rm tmp_lista