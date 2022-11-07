#!/usr/bin/env bash
clear

#	Temas a ver:
#	1. Dibujar columnas en 3D apiladas

#	Definir Variables del mapa
#	-----------------------------------------------------------------------------------------------------------
#	Titulo del mapa
	title=50_Copa_America_Titulos
	echo $title

#	Region: Cuyo
	REGION=-85/-33/-58/15
	Z=36

#	Proyeccion Mercator (M)
	PROJ=M15c
	PROZ=5c
	persp=210/40

#	Parametros Generales
#	-----------------------------------------------------------------------------------------------------------
#	Sub-seccion FUENTE
	gmt set FONT_ANNOT_PRIMARY 8,Helvetica,black
	gmt set FONT_LABEL 8,Helvetica,black

#	Sub-seccion FORMATO
	gmt set FORMAT_GEO_MAP ddd:mm:ssF

#	Sub-seccion GMT
	gmt set GMT_VERBOSE w

#	Sub-seccion MAPA
	gmt set MAP_FRAME_TYPE fancy
	gmt set MAP_FRAME_WIDTH 0.1
	gmt set MAP_GRID_CROSS_SIZE_PRIMARY 0
	gmt set MAP_SCALE_HEIGHT 0.1618
	gmt set MAP_TICK_LENGTH_PRIMARY 0.1

#	Dibujar mapa
#	-----------------------------------------------------------------------------------------------------------
#	Iniciar sesion y tipo de figura
gmt begin $title png

#	Setear variables
	gmt basemap -R$REGION/0/$Z -J$PROJ -JZ$PROZ -p$persp -B+n

#	Mapa  Base
	gmt coast -p -G200 -Sdodgerblue2 -N1

#	Titulo
	gmt basemap -p -B+t"Copas Américas"

#	Dibujar Eje X,Y,Z
	gmt basemap -p -BWSneZ -Bxf -Byf -Bzafg

#	Dibujar Datos en Columnas Apiladas
#	----------------------------------------------
#	Crear CPT para las columnas
	gmt makecpt -Cblue,green,yellow,red -T0,1,2,3,4

#	Dibujar 4 columnas (+Z4) apiladas con colores segun CPT (-C)
	gmt plot3d -p "CopaAmerica.csv" -SO0.5c+Z4 -C -Wthinner
#	------------------------------------------------

#	Crear leyenda
	cat > tmp_leyenda <<- END
	C blue
	L - L Primer Puesto
	C green
	L - L Segundo Puesto
	C yellow
	L - L Tercer Puesto
	C red
	L - L Cuarto Puesto
	END

	gmt legend tmp_leyenda -p -JZ -DjLB+o0.5c+w3.5c/0+jBL -F+glightgrey+pthinner+s-4p/-6p/grey20@40
#	-----------------------------------------------------------------------------------------------------------
#	Cerrar el archivo de salida (ps)
gmt end

#	Borrar archivos temporales
rm gmt.* tmp_*
