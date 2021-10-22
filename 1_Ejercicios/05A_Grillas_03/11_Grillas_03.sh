#!/usr/bin/env bash
clear

#	Definir variables del mapa
#	-----------------------------------------------------------------------------------------------------------
#	Titulo del mapa
	title=09_Grillas_03
	echo $title

#	Grilla 
	GRD=@earth_relief_03m

#	Region: Argentina
	REGION=CO,AR,BR
	
#	Proyeccion Mercator (M)
	PROJ=M15c

# 	Archivos temporales
	CUT=temp_$title.nc
	SHADOW=temp_$title-shadow.nc
	color=temp_$title.cpt

	gmt set MAP_FRAME_AXES WesN
	gmt set GMT_VERBOSE w

#	Dibujar mapa
#	-----------------------------------------------------------------------------------------------------------
#	Iniciar sesion y tipo de figura
	gmt begin $title png E300

#	Setear la region y proyeccion
	gmt basemap -R$REGION -J$PROJ -B+n

#	Recortar Grilla
	gmt grdcut $GRD -G$CUT -R$REGION

#	Extraer informacion de la grilla recortada para determinar rango de CPT
	#gmt grdinfo $CUT
	gmt grdinfo $CUT -Cn
	gmt grdinfo $CUT -T50
	gmt grdinfo $CUT -Cn -T50 -o4
	gmt grdinfo $CUT -Cn -o5

#	Crear variables con los valores minimo y maximo 
	min=`gmt grdinfo $CUT -Cn -o4`
	max=`gmt grdinfo $CUT -Cn -o5`
	echo $min $max

#	Combinacion 1
#	gmt makecpt -Cabyss -T-8400/0 -N -H >  $color
#	gmt makecpt -Cdem2  -T0/6050     -H >> $color

#	gmt makecpt -Cabyss -T$min/0 -N -H >  $color
#	gmt makecpt -Cdem2  -T0/$max    -H >> $color

#	Combinacion 2
#	gmt makecpt -Cibcso      -T-8400/0/10 -Z -N >  $color
#	gmt makecpt -Celevation  -T0/6050/50  -Z    >> $color

#	Combinacion 3
#	gmt makecpt -Cbathy -T$min/0 -N -H >  $color
#	gmt makecpt -Cgray  -T0/$max    -H >> $color

#	Combinacion 3B
#	gmt makecpt -Cbathy -T$min/0 -N -H >  $color
#	gmt makecpt -Cgray  -T0/$max -I -H >> $color

#	Combinacion 4
#	gmt makecpt -Cocean  -T$min/0 -N -H >  $color
#	gmt makecpt -Ccopper -T0/$max -I -H >> $color

#	Combinacion 5
#	gmt makecpt -Coslo   -T$min/0 -N -H >  $color
#	gmt makecpt -Cbilbao -T0/$max -I -H >> $color

#	Combinacion 6
#	Link para cpt de topografia: http://soliton.vm.bytemark.co.uk/pub/cpt-city/views/topo.html
	URL="http://soliton.vm.bytemark.co.uk/pub/cpt-city/esri/hypsometry/eu/europe_3.cpt"
#	URL="http://soliton.vm.bytemark.co.uk/pub/cpt-city/wkp/schwarzwald/wiki-schwarzwald-cont.cpt"
#	gmt which -G $URL 		#Descarga el archivo y lo guarda con el nombre original
	top=$(gmt which -G $URL)	#Idem y guarda el nombre en la variable %top  

	gmt makecpt -Coslo -T$min/0 -N -H >  $color
	gmt makecpt -C$top -T0/$max    -H >> $color

#	Crear grilla para sombreado
	gmt grdgradient $CUT -A270 -G$SHADOW -Nt1

#	Crear Imagen a partir de grilla con sombreado y cpt
	gmt grdimage $CUT -C$color -I$SHADOW

#	Agregar escala de colores a partir de CPT (-C). Posición (x,y) +wlargo/ancho. Anotaciones (-Ba). Leyenda (+l). 
	gmt colorbar -DJRM+o0.3c/0+w15/0.618c -C$color -Ba1+l"Elevaciones (km)" -I -W0.001

#	-----------------------------------------------------------------------------------------------------------
#	Dibujar frame
	gmt basemap -Bxaf -Byaf

#	Dibujar Linea de Costa (W1)
	gmt coast -Df -W1/faint

#	-----------------------------------------------------------------------------------------------------------
#	Cerrar el archivo de salida (ps)
gmt end

	rm temp_* gmt.* $top