#!/bin/bash
clear

#	Definir variables del mapa
#	-----------------------------------------------------------------------------------------------------------
#	Titulo del mapa
	title=28_Mascara_Ocean-Land
	echo $title

#	Region: Argentina
	REGION=-70/-42/-36/-12
	REGION==AF
	REGION=-20/20/-25/10

#	Proyeccion Mercator (M)
	PROJ=M15c

#	Resolucion de la grilla
#	RES=15s
	RES=02m

#	Base de datos de GRILLAS
	#DEM=@earth_relief_$RES
	DEM=@earth_faa_$RES
    SAT=@earth_day_$RES

# 	Nombre archivo de salida
	CUT=tmp_$title.nc
	CUT1=tmp_$title-1.nc
	MASK=tmp_$title-2.nc
	CLIP=tmp_clip.txt

#	Parametros Generales
#	-----------------------------------------------------------------------------------------------------------
#	Sub-seccion FUENTE
	gmt set FONT_ANNOT_PRIMARY 8,Helvetica,black
	gmt set FONT_LABEL 8,Helvetica,black

#	Sub-seccion FORMATO
	gmt set FORMAT_GEO_MAP ddd:mm:ssF

#	Sub-seccion GMT
	gmt set GMT_VERBOSE w

#	Iniciar sesion y tipo de figura
#	-----------------------------------------------------------------------------------------------------------
#	Abrir archivo de salida (ps)
gmt begin $title png

#	Setear la region y proyeccion (y no se dibuja nada)
	gmt basemap -R$REGION -J$PROJ -B+n	

#	Agregar imagan/grilla de fondo
#	gmt grdimage $SAT
#	gmt grdimage $DEM -I -Cwhite

#	Crear grilla
#	-------------------------------------------------------------
#	Recortar la grilla (rectangular)
	gmt grdcut $DEM -G$CUT1 -R$REGION

#	Crear Mascara Oceano-Tierra
	gmt grdlandmask -R$CUT1 -Dh -G$MASK -N1/NaN -V

#	Recortar 
	gmt grdmath $CUT1 $MASK MUL = $CUT

#	Crear Mapa
#	-------------------------------------------------------------
#	Crear Imagen a partir de grilla con sombreado y cpt. -Q: Nodos sin datos sin color 
	gmt grdimage $CUT -I -Q -Cbatlow

#	Agregar escala de colores a partir de CPT (-C). Posición (x,y) +wlargo/ancho. Anotaciones (-Ba). Leyenda (+l). 
	gmt colorbar -C -I -DJRM+o0.3c/0+w14/0.618c  -Ba+l"Alturas (km)" -W0.001

#	-----------------------------------------------------------------------------------------------------------
#	Dibujar frame
	gmt basemap -Baf

#	Dibujar Linea de Costa
	gmt coast -Df -W1/0.5

#	Dibujar Bordes Administrativos. N1: paises. N2: Provincias, Estados, etc. N3: limites marítimos (Nborder[/pen])
	gmt coast -Df -N1/0.30 
	gmt coast -Df -N2/0.25,-.

#	-----------------------------------------------------------------------------------------------------------
#	Cerrar sesion y mostrar figura
gmt end # show

	rm tmp_* gmt.*

#	Ejercicios sugeridos
#	1. Probar otros poligonos.
#	2. Invertir la mascara. 