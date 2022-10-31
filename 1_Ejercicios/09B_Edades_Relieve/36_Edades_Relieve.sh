#!/usr/bin/env bash
clear

#	Temas a ver:
#	1. Grilla de edades de la corteza oceanica
#	2. CPT de la escala geologica y crones magentoestratigraficos.
#	3. Personalizar rangos de CPT.

#	Definir variables del mapa
#	-----------------------------------------------------------------------------------------------------------
#	Titulo del mapa
	title=36_Edades_Relieve
	echo $title

#	Region y proyeccion
	REGION=d
#	REGION=AR+r2
#	REGION=-66/-36/-66/-34
	PROJ=W15c
#	PROJ=G0/0/90/15c

#	Resolucion Grilla
	RES=05m_g

# 	Nombre archivo de salida
	SHADOW=tmp_$title-shadow.nc

	gmt set MAP_FRAME_WIDTH 1p
	gmt set MAP_FRAME_PEN thin,black
	gmt set FONT_ANNOT_PRIMARY 5p,Helvetica,black
	gmt set FONT_LABEL   8p,Helvetica,black

#	Dibujar mapa
#	-----------------------------------------------------------------------------------------------------------
#	Iniciar sesion y tipo de figura
gmt begin $title png

#	Setear la region y proyeccion
	gmt basemap -R$REGION -J$PROJ -B+n

#	Crear Imagen a partir de grilla de relieve con sombreado y cpt 
	gmt grdimage @earth_relief -I -Cgeo

#	Mapa con edades geologicas
#	----------------------------------------------------------
#	Descargar CPT de CPT-City para escalas geologicas
#	URL="http://soliton.vm.bytemark.co.uk/pub/cpt-city/heine/GTS2012_eons.cpt"
#	URL="http://soliton.vm.bytemark.co.uk/pub/cpt-city/heine/GTS2012_eras.cpt"
	URL="http://soliton.vm.bytemark.co.uk/pub/cpt-city/heine/GTS2012_periods.cpt"
#	URL="http://soliton.vm.bytemark.co.uk/pub/cpt-city/heine/GTS2012_epochs.cpt"
#	URL="http://soliton.vm.bytemark.co.uk/pub/cpt-city/heine/GTS2012_ages.cpt"
#	URL="http://soliton.vm.bytemark.co.uk/pub/cpt-city/heine/GeeK07.cpt"
	gmt which -G $URL 		#Descarga el archivo y lo guarda con el nombre original
    cpt=$(gmt which -G $URL)

#	Descargar DEM para la region. Resolucion definida automaticamente.
	gmt grdcut @earth_relief_$RES -Gtmp_cut.nc -R$REGION

#	Sombreado a partir del DEM
	gmt grdgradient tmp_cut.nc -Nt0.8 -A45 -G$SHADOW -R$REGION

#   Crear Imagen a partir de grilla con sombreado y cpt con transparencia para zonas emergidas (-Q)
	gmt grdimage @earth_age_$RES -C$cpt -Q -I$SHADOW
#	gmt grdimage @earth_age_$RES -C$cpt -Q

#	Escala de color. Acortar rango (-G). Recuadro de igual tamaño (-Lgap).
#	gmt colorbar -DJLM+o0.3c/0+w-7/0.618c -C$cpt -I
#	gmt colorbar -DJLM+o0.3c/0+w-7/0.618c -C$cpt -I -G0/200
	gmt colorbar -DJLM+o0.3c/0+w-7/0.618c -C$cpt -I -G0/200 -L0
#	gmt colorbar -DJLM+o0.3c/0+w-7/0.618c -C$cpt -I -G0/200 -L0.1
#	gmt colorbar -DJRM+o0.3c/0+w-7/0.618c -C$cpt -I -G0/200 -B+l"Age (Ma)"

#	Dibujar frame
	gmt basemap -B0

#	Dibujar Linea de Costa (W1)
	gmt coast -W1/faint

#	-----------------------------------------------------------------------------------------------------------
#	Cerrar el archivo de salida (ps)
gmt end

rm	tmp_* gmt.* $cpt

#	Ejercicios Sugeridos
#	1. Probar los distintos CPT geologicos (lineas 52 a 56).
#	2. Probar CPT para crones (linea 57).
#	2. Ver las distintas opciones para la escala de color (lineas 66 a 69).