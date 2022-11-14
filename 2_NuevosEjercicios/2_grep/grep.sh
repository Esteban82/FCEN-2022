# Como seleccionar y filtrar datos 2.
# Unix: GREP, AWK
# GMT: -e

# Archivo de prueba
# ---------------------------------------------
# Archivo txt (campos separado espacios)
file1=../Sismos/Datos/quakes.txt

# Archivo CSV (campos separado por comas)
file2=../0_sed/query.csv
# ---------------------------------------------

# 1. GMT: Opcion -e
# SOLO analiza registros. No tiene en cuenta encabezados de archivos y segmetnos. 
# A. Leer archivo entero 
gmt info $file2 -h1

# B. Leer solo registros que contegan el texto: Scotia
gmt info $file2 -h1 -eScotia

# C. Leer los que NO contengan SCOTIA
gmt info $file2 -h1 -e~Scotia


# 2. Una celda valor identico a (AWK ==)
# A. Por ejemplo, buscar sismos con profundidad de 33 km 
#awk -F"," '$4==33' $file1

# 3. GREP
# Globally Search For Regular Expression and Print out 
# Analiza el archivo completo (incluyendo encabezados)
# (Búsqueda global de expresiones regulares

# Sintaxis
# grep '<texto-buscado>' <archivo/archivos>


# A. Que el registro contenga el texto> Islands
grep Scotia $file2 | gmt info

# ... y luego usar sort para ordenar
#awk -F"," '$4>300 {print $4}' $file2 | sed '1d' | sort

# Fuente 
# https://www.freecodecamp.org/espanol/news/grep-command-tutorial-how-to-search-for-a-file-in-linux-and-unix-with-recursive-find/
