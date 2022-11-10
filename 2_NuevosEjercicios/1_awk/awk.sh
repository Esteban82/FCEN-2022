# Ejemplos de AWK

# Archivo de prueba
# ---------------------------------------------
# Archivo txt (campos separado espacios)
file1=../Sismos/Datos/quakes.txt

# Archivo CSV (campos separado por comas)
file2=../0_sed/query.csv
# ---------------------------------------------

# 0. Inspeccionar archivo
# Head muestra las primeras 10 lineas
#head $file1
# gmt info permite ver que GMT lea bien el archivo
#gmt info $file1

# 1. Imprimir todos los registros (o lineas) completas ($0)
# awk '{print $0}' $file1
# El mismo resultados que 
# cat $file1

# 2. Imprimir solo algunas columnas
# A. Imprimir columan 1 ($1)
#awk '{print $4}' $file1

# B. Columna Final ($NF)
#awk '{print $NF}' $file1

# C. Columna 2 y final (separadas en columnas)
#awk '{print $2,$NF}' $file1 | head

# C. Columna 2 y final (juntos en una misma columna)
#awk '{print $2$NF}' $file1

# D. Agregar el Numero de Registro ()
#awk '{print NR, $2}' $file1 

# E. Lo mismo pero agregando texto.
#awk '{print "El numero de registro es el " NR " y su valor es: "$2}' $file1 


# -----------------------------------------------------------------
# 3. Usar arhivo 2 (que es CSV)

# A. Imprimo columna 1 pero obtengo todo el archivo! 
#awk '{print $1}' $file2 
#echo Imprime TODAS las columnas. No identifica la , como separador de campo (FS)

# B. Especificar la , como FS (-F",")
#awk -F"," '{print $2}' $file2

# C. Realizar operaciones matematica
#awk -F"," '{print $2*100}' $file2


# -----------------------------------------------------------------
# 3. Filtrar datos
# A. Filtrar registros profundidad mayor a 300 (campo 4)
#awk -F"," '$4>300 ' $file2

# Filtrar y solo mostrar un campo
#awk -F"," '$4>300 {print $4}' $file2

# ... y luego usar sed para borrar linea 1
#awk -F"," '$4>300 {print $4}' $file2 | sed '1d'

# ... y luego usar sort para ordenar
awk -F"," '$4>300 {print $4}' $file2 | sed '1d' | sort

# Fuente 
# https://sio2sio2.github.io/doc-linux/03.scripts/06.misc/04.awk.html
# https://www.youtube.com/watch?v=YFlEY_4gUVs