#!/usr/bin/env bash
clear

# Adapto de GMT EXAMPLE 16
# 	Temas a ver: 
#	1. Grillar datos 
#	2. Hacer subgraficos
#
#	Definir variables del mapa
#	-----------------------------------------------------------------------------------------------------------
#	Titulo del mapa
	title=48_GrillarDatos
	echo $title
	
	CUT=tmp_$title.nc

#	Dibujar mapa
#	-----------------------------------------------------------------------------------------------------------
#	Iniciar sesion y tipo de figura
gmt begin $title png
	gmt subplot begin 2x3 -M0.5c -Fs8c/0 -R-0.2/6.6/-0.2/6.6 -Jx1c -Scb -Srl+t -Bwesn -T"Grlllar datos"
		gmt plot @Table_5_11.txt -Sc0.12c -Gblack -B+t"Datos originales" -c
		gmt text @Table_5_11.txt -D3p/0 -F+f6p+jLM -N
		#
		gmt surface @Table_5_11.txt -G$CUT -I0.2
		gmt grdimage $CUT -B+t"surface (tension = 0)" -c
		gmt grdcontour $CUT
		#
		gmt surface @Table_5_11.txt -G$CUT -I0.1 -T0
		gmt grdimage $CUT -B+t"surface (tension = 0)" -c
		gmt grdcontour $CUT
		#
		gmt surface @Table_5_11.txt -G$CUT -I0.1 -T0.33
		gmt grdimage $CUT -B+t"surface (tension = 0.5)" -c
		gmt grdcontour $CUT
		#
		gmt surface @Table_5_11.txt -G$CUT -I0.1 -T0.66
		gmt grdimage $CUT -B+t"surface (tension = 0.8)" -c
		gmt grdcontour $CUT
		#
		gmt surface @Table_5_11.txt -G$CUT -I0.1 -T1
		gmt grdimage $CUT -B+t"surface (tension = 0.1)" -c
		gmt grdcontour $CUT

	gmt subplot end
gmt end

#	Borrar temporales
rm tmp_*

# Ejercicios sugeridos
# 1. Cambiar la configuración de los subgraficos (2x3) a 3x2, 6x1, 1x6 (linea 21).
# 2. Modificar el margen de los subgraficos (-M)