#!/bin/bash
clear

#	Temas a ver
#	1. Dibujar perfil sobre el mapa (wiggle).

#	Definir variables del mapa
#	-----------------------------------------------------------------------------------------------------------
#	Titulo del mapa
	title=31_Mapa_Perfil
	echo $title

#	Region y Proyección del mapa
	REGION=-78/-44/-37/-27
	PROJ=M15c

#	Resolucion de la grilla (y del perfil)
	RES=15s

#	Grilla para el mapa
	DEM=@earth_relief

# 	Grilla para extraer los datos
	GRD=@earth_relief_$RES		# Misma grilla topografica
#	GRD=@earth_faa_01m			# Anomalias de Aire Libre

# 	Nombre archivo de salida
	CUT=tmp_$title.nc

#	Dibujar mapa
#	-----------------------------------------------------------------------------------------------------------
#	Iniciar sesion y tipo de figura
gmt begin $title png

#	Setear region y proyeccion
	gmt basemap -R$REGION -J$PROJ -B+n

#	Mapa Base
#	********************************************************************
#	Crear Imagen a partir del DEM con sombreado
	gmt grdimage $DEM -Cgeo -I

#	Agregar escala vertical a partir de CPT (-C). Posicion (x,y) +wlargo/ancho. Anotaciones (-Ba). Leyenda (+l). 
	gmt colorbar -Dx15.5/0+w5/0.618c -C -Ba+l"Elevaciones (km)" -I -W0.001

#	Dibujar frame
	gmt basemap -Bxaf -Byaf

#	********************************************************************
#	Perfil 
#	-----------------------------------------------------------------------------------------------------------
#	Perfil: Crear archivo para dibujar perfil (Long Lat)
	cat > tmp_line <<- END
	-76 -32
	-46 -32
	END

#	Interpolar: agrega datos en el perfil segun resolucion de la grilla.
	gmt sample1d tmp_line -I$RES -fg     > tmp_sample1d
#	gmt sample1d tmp_line -I$RES -fg -Am > tmp_sample1d

#	Crear variable con region geografica del perfil
#	Si se trabaja con datos remotos con alta resolucion, conviene definir
#	la region. Caso contrario, se descargan todos los datos disponibles.	
	REGION=$(gmt info tmp_sample1d -I+e0.1)

#	Agregar columna con datos extraidos de la grilla
	gmt grdtrack tmp_sample1d -G$GRD $REGION > tmp_data

#	Dibujar Perfil
#	gmt plot tmp_data -W0.5,black

#	Dibujar Perfil en el mapa. Z: Escala (metros/cm).
#	gmt wiggle tmp_data -Z3000c -W                    									# Dibujar solo linea
#	gmt wiggle tmp_data -Z3000c -W -Gred			  									# Pintar areas positivas 
#	gmt wiggle tmp_data -Z3000c -W -Gred+p    -Gblue+n     								# Pintar también negativas
#	gmt wiggle tmp_data -Z3000c -W -Gred+p    -Gblue+n    -T  							# Agregar linea base 
#	gmt wiggle tmp_data -Z3000c -W -Gred+p    -Gblue+n    -T -DjRB+o0.1/0.1+w500+lm 	# Agregar escala
	gmt wiggle tmp_data -Z3000c -W -Gred@50+p -Gblue@50+n -T -DjRB+o0.1/0.1+w500+lm  	# Agregar transaparencia.
#	********************************************************************

#	-----------------------------------------------------------------------------------------------------------
#	Cerrar la sesion y mostrar archivo
gmt end

	rm tmp_* gmt.*

# 	Ejercicios sugeridos
#	1. Cambiar las coordenadas de inicio y fin del perfil.
#	2. Cambiar a la grilla de anomalias de aire libre (faa en linea 25)
#	3. Ajustar los parametros del perfil wiggle para que se observen bien las anomalias de Aire Libre
