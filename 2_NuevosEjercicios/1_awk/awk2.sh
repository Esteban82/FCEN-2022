#!/usr/bin/env -S bash -e

# Archivo de entrada
file=test3.txt

# 1. Uso AWK para formatear archivo de datos
#   A. NR>2: excluyendo las 2 primeras lineas. 
#   B. Reformateo fecha con formato ISO (año-jjjT)
# Formatos de fechas ("fechaThora")
#   yyyy-mm-ddThh:mm:ss.ms
#   yyyy-jjjThh:mm:ss.ms


 # Extraer Long Lat Fecha Record
awk '{if (NR>2) {print $11,$12,$1,$3"-"$4"T"$5":"$6":"$7}}' $file | gmt info # > tmp_NAV.txt  


# Mas info
# https://docs.generic-mapping-tools.org/dev/gmt.conf.html#format-parameters