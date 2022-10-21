#!/usr/bin/env bash

#	Temas a ver
#	1. Crear animaciones a partir de un unico script.
#	2. Ver comando CAT para la creacion de archivos.
#	3. Ver comando HEAD para la inspeccion de archivos.

#	Titulo de la animación
	title=13_BsAs-Madrid

#	Lista de Valores: Archivo con los valores que se usaran para el script principal 
#	Crear puntos cada 50 km (-G) siguiendo un circulo maximo entre el punto inicial (-C) y el final (-E) en coordenadas geograficas (-Q).
	gmt project -C-58.5258/-34.8553 -E-3.56083/40.47222 -Q -G50 > "tmp_time.txt"
	
#	Mostrar primeras lineas del archivo
	head tmp_time.txt

cat << 'EOF' > main.sh
gmt begin
#	Setear la region y proyeccion
	gmt basemap -Rd -JG${MOVIE_COL0}/${MOVIE_COL1}/15c -B+n -Yc -Xc

#	Pintar areas secas (-G). Resolucion datos full (-Df)
	gmt coast -Da -G200 -Sdodgerblue2 -N1/0.2,-
	gmt basemap -Bg0
gmt end
EOF

#	Movie: Crear figuras y animacion
#	Opciones C: Canvas Size. -G: Color fondo
	gmt movie "main.sh" -N$title -T"tmp_time.txt" -C15cx15cx100 -D24 -Vi -Ml,png -Gblack -Zs #-Fmp4 

#	Borrar Temporales
	rm tmp_*
#	-------------------------------------------------
#	Apagar (-s) o Hibernar (/h) PC
#	Linux
#	shutdown -h # apagar
#systemctl suspend  #suspender

##  Windows 
#	shutdown -h # Hibernar
#sleep 2h 45m 20s && systemctl suspend -i
