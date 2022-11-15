# Como seleccionar y filtrar datos 2.
# Unix: GREP, AWK
# GMT: -e

# Archivo de prueba
# ---------------------------------------------
# Archivo CSV (campos separado por comas)
file=Datos.txt
out=Datos2.txt

#file2=Datos2.txt
# ---------------------------------------------

# Usar AWK para relenar celdas vacias con NaN (va)
    # -F"\t": Separador de campos del archivo de entrada es una tabulacion (\t)
    # OFS: Output field separator. Setear tabulaciones como separador de campos para el archivo de salida 
    # -v: asignar variable
    # Loop: for (initialization; condition; increment). Empieza en campo 1, sigue hasta llegar al total de campos NF, y va sumando 1 cada vez `(N++).
    # if($N=="") $N="NaN": Si el campo esta vacio, reemplazar por NaN.
    # -i inplace: sobreescribe archivo original

# Reemplaza archivo original
#awk -i inplace -F"\t" -v OFS="\t" '{ for(N=1; N<=NF; N++) if($N=="") $N="NaN" } 1' $file

# Crea archivo nuevo
#awk -F"\t" -v OFS="\t" '{ for(N=1; N<=NF; N++) if($N=="") $N="NaN" } 1' $file > $out

# aFuente:
# https://www.gnu.org/software/gawk/manual/html_node/For-Statement.html


# 1. GMT: Opcion -e
# ---------------------------------------------------------
# SOLO analiza registros (No tiene en cuenta encabezados de archivos y segmentos).
# A. Leer archivo entero 
#gmt info $out -h1

# B. Leer los registros segun nombre del Well
#gmt info $out -h1 -eWellA
#gmt info $out -h1 -eWellB
#gmt info $out -h1 -eWellC

# 2. Una celda valor identico a (AWK ==)
# ---------------------------------------------------------
# A. Por ejemplo, buscar sismos con profundidad de 33 km (profundidad por defecto por la falta de datos)
awk '$NF==WellA' $out

# 3. GREP
# ---------------------------------------------------------
# Globally Search For Regular Expression and Print out (Búsqueda global de expresiones regulares)
# Analiza el archivo completo (incluyendo encabezados)

# Sintaxis
# grep '<texto-buscado>' <archivo/archivos>

# A. Que el registro contenga el texto "Scotia"
#grep WellA $out | gmt info

# B. Inversa (-v, --invert-match)
#grep WellA $out -v | gmt info -h1

# C. <texto-buscado>$: Que el texo este al final de la linea.
#grep WellA$ $out | gmt info

# Fuente 
# https://www.freecodecamp.org/espanol/news/grep-command-tutorial-how-to-search-for-a-file-in-linux-and-unix-with-recursive-find/
