# Como seleccionar y filtrar datos 2.
# Unix: GREP, AWK
# GMT: -e

# Archivo de prueba
# ---------------------------------------------
# Archivo CSV (campos separado por comas)
file=../0_sed/query.csv
# ---------------------------------------------

# 1. GMT: Opcion -e
# ---------------------------------------------------------
# SOLO analiza registros (No tiene en cuenta encabezados de archivos y segmentos).
# A. Leer archivo entero 
gmt info $file -h1

# B. Leer solo registros que contegan el texto: Scotia
gmt info $file -h1 -eScotia

# C. Leer los que NO contengan SCOTIA
gmt info $file -h1 -e~Scotia

# 2. Una celda valor identico a (AWK ==)
# ---------------------------------------------------------
# A. Por ejemplo, buscar sismos con profundidad de 33 km (profundidad por defecto por la falta de datos)
#awk -F"," '$4==33' $file

# 3. GREP
# ---------------------------------------------------------
# Globally Search For Regular Expression and Print out (Búsqueda global de expresiones regulares)
# Analiza el archivo completo (incluyendo encabezados)

# Sintaxis
# grep '<texto-buscado>' <archivo/archivos>

# A. Que el registro contenga el texto "Scotia"
grep Scotia $file | gmt info

# B. Inversa (-v, --invert-match)
grep Scotia $file -v | gmt info

# C. -c (--count): Imprimir el número de líneas de coincidencias 
grep "Tierra del Fuego" $file -c #| gmt info

# D. -A (--after-context): - imprimir las líneas después del patrón coincidente

# E. -B (--before-context) - imprimir las líneas antes del patrón coincidente

# F. -C (--context): es igual a -A + -B.

# Expresiones regulares para patrones
# F. ^<texto-buscado> - Inicio de línea

# G. <texto-buscado>$ - fin de la línea


# Fuente 
# https://www.freecodecamp.org/espanol/news/grep-command-tutorial-how-to-search-for-a-file-in-linux-and-unix-with-recursive-find/
