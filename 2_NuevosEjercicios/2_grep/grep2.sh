# Como seleccionar y filtrar datos 2.
# Unix: GREP, AWK
# GMT: -e

# Archivo de prueba
# ---------------------------------------------
# Archivo CSV (campos separado por comas)
file1=Datos1.txt
file1=copy.txt
out1=Datos3.txt

#file2=Datos2.txt
# ---------------------------------------------

# Usar AWK para relenar celdas vacias con NaN (va)
    # -F"\t": Separador de campos del archivo de entrada es una tabulacion (\t)
    # OFS: Output field separator. Setear tabulaciones como separador de campos para el archivo de salida 
    # -v: asignar variable
    # Loop: for (initialization; condition; increment). Empieza en campo 1, sigue hasta llegar al total de campos NF, y va sumando 1 cada vez `(N++).
    # if($N=="") $N="NaN": Si el campo esta vacio, reemplazar por NaN.
    # -i inplace: sobreescribe archivo original
awk -i inplace -F"\t" -v OFS="\t" '{ for(N=1; N<=NF; N++) if($N=="") $N="NaN" } 1' $file1
#awk -F"\t" -v OFS="\t" '{ for(N=1; N<=NF; N++) if($N=="") $N="NaN" } 1' $file1 > $out

# aFuente:
# https://www.gnu.org/software/gawk/manual/html_node/For-Statement.html


# 1. GMT: Opcion -e
# ---------------------------------------------------------
# SOLO analiza registros (No tiene en cuenta encabezados de archivos y segmentos).
# A. Leer archivo entero 
gmt info $file1 -h1

# B. Leer los registros segun nombre del Well
gmt info $file1 -h1 -eWellA
gmt info $file1 -h1 -eWellB
gmt info $file1 -h1 -eWellC

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
grep Scotia $file -v | gmt info -h1

# C. -c (--count): Imprimir el número de líneas de coincidencias 
grep "Tierra del Fuego" $file -c #| gmt info -h1

# D. -A (--after-context): - imprimir las líneas después del patrón coincidente
grep "Tierra del Fuego" $file -A 3 

# E. -B (--before-context) - imprimir las líneas antes del patrón coincidente
grep "Tierra del Fuego" $file -B 2

# F. -C (--context): es igual a -A + -B.
grep "Tierra del Fuego" $file -C 1
# Expresiones regulares para patrones
# F. ^<texto-buscado> - Inicio de línea

# G. <texto-buscado>$ - fin de la línea


# Fuente 
# https://www.freecodecamp.org/espanol/news/grep-command-tutorial-how-to-search-for-a-file-in-linux-and-unix-with-recursive-find/
