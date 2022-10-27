#!/bin/bash
clear

#	Definir variables del mapa
#	-----------------------------------------------------------------------------------------------------------
#	Titulo del mapa
	title=31_Mapa_Perfil_2
	echo $title

#	Region y Proyección del mapa
	REGION=-78/-44/-37/-27
	PROJ=M15c

#	Resolucion de la grilla (y del perfil)
	RES=15s
	RES=02m

#	Grilla para el mapa
	DEM=@earth_relief_$RES

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
	-66 -32
	END

#	Interpolar: agrega datos en el perfil segun resolucion de la grilla.
	gmt sample1d tmp_line -I$RES -fg     > tmp_sample1d
#	gmt sample1d tmp_line -I$RES -fg -Am > tmp_sample1d

#	Crear variable con region geografica del perfil
#	Si se trabaja con datos remotos con alta resolucion, conviene definir
#	la region. Caso contrario, se descargan todos los datos disponibles.	
	REGION=$(gmt info tmp_sample1d -I+e0.1)

#	Distancia: Agrega columna (3a) con distancia del perfil en km (-G+uk)
	gmt mapproject tmp_sample1d -G+uk > tmp_track

#	Agrega columna (4) con datos extraidos de la grilla -G (altura) sobre el perfil
	gmt grdtrack tmp_track -G$DEM $REGION > tmp_data

#	Dibujar Perfil
	gmt plot tmp_data -W0.5,black

#
gmt basemap -B+n -Y-h-2c

	L=15
	H=5

#	Dibujar datos de columnas 3a y 4a (-i2,3)
	gmt plot tmp_data -JX$L/$H -Re -W0.5,blue -i2,3  

#	Dibujar Eje X (Sn)
	gmt basemap -BSn -Bxaf+l"Distancia (km)"

#   Dibujar Eje Y (eW)
	gmt basemap -BwE -Byafg+l"Altura (m)"

#	Coordenadas Perfil (E, O)
	echo O | gmt text -F+cTL+f14p -Gwhite -W1
	echo E | gmt text -F+cTR+f14p -Gwhite -W1

#	Agregar Escala (grafica) Horizontal y Vertical (+v) -LjCB+w40+lkm+o0/0.5i
	gmt basemap -LjCB+w1000+lm+o1.2/0.67+v
	gmt basemap -LjCB+w200+lkm+o0/0.5


#	-----------------------------------------------------------------------------------------------------------
#	Cerrar la sesion y mostrar archivo
gmt end

	rm tmp_* gmt.*