#!/bin/bash
 
#	Definir Variables del mapa
#	-----------------------------------------------------------------------------------------------------------
#	Titulo del mapa
	title=Mars-elipsoide
	echo $title

#	Region: 
	REGION=d
#	REGION=322/325/-37/-34		# Crater de Hale

#	Proyeccion Mercator (M)
	PROJ=W15c
#	PROJ=M15c
#	PROJ=G0/0/90/15c

#	Tabla de Armonicos Esfericos
	SPH=MarsTopo720.shape
#	SPH=MarsTopo2600.shape		# A descargar. Ver abajo

# 	Radios de Marte. https://spatialreference.org/ref/iau2000/49964/
	A=339619
	B=3376200

#	Resolucion de las grillas
	RES=0.5

# 	Nombre archivo de salida
	CUT=tmp_$title.nc

#	Parametros Generales
#	-----------------------------------------------------------------------------------------------------------
#	Sub-seccion MAPA
	gmt set MAP_FRAME_AXES WesN
	gmt set MAP_FRAME_PEN thin

#	Elipsoide
	gmt set PROJ_ELLIPSOID Mars

#	Dibujar mapa
#	-----------------------------------------------------------------------------------------------------------
#	Iniciar sesion y tipo de figura
gmt begin $title png

#	Setear la region y proyeccion
	gmt basemap -R$REGION -J$PROJ -B+n

#	Procesar datos
#	**********************************************************************
#	1. Calcular grillas a partir de los armonicos esfericos
	#gmt sph2grd -R$REGION $SPH -G$CUT -Ng -V -I$RES
	#gmt sph2grd -R$REGION $SPH -G$CUT -Ng -V -I$RES  -F0/0/720/720 #-E

#	2. Calcular elipsoside de Marte:
	gmt grdmath -R$REGION -I$RES $A $B ELLIPSOID = E.nc

#	3. Restar las grillas
	gmt grdmath E.nc $CUT SUB = Topo.nc
	#gmt grdmath $CUT my.grd SUB = Topo.nc

#	***********************************************************************
#	Extraer informacion
	gmt grdinfo -Cn $CUT
	gmt grdinfo -Cn E.nc
	#gmt grdinfo -Cn my.grd
	gmt grdinfo -Cn Topo.nc

#	Dibujar mapa
#	-----------------------------------------------------------------------------------------------------------
#	Crear Imagen a partir de grilla con  paleta de colores y sombreado
	gmt grdimage Topo.nc -Crainbow -B+tAlturas # -I #-CMars.cpt
	gmt colorbar -C -Baf+l"Alturas (m)" -I -DJRM+o0.3/0c+w80% -W0.001
	gmt grdimage my.grd -I  -Crainbow -B+tElipsoide -Y10c #-I #-CMars.cpt 
	gmt colorbar -C -Baf+l"Distancia al centro (km)" -I -DJRM+o0.3/0c+w80% -W0.001

	#gmt grdimage E.nc -Yh #-I #-CMars.cpt 
	gmt grdimage $CUT -I  -Y10c -Crainbow -B+tArmonicos #-I #-CMars.cpt
	
	#gmt grdimage $CUT -I #-CMars.cpt
	
#	Agrega escala de colores. (-E triangles). Posici�n (-D) (horizontal = h). Posici�n (x,y) +wlargo/ancho. Anotaciones (-Ba). Leyenda (+l). 
	gmt colorbar -C -Baf+l"Distancia al centro (km)" -I -DJRM+o0.3/0c+w80% -W0.001 #-DJCB+o0/0.3c+w80%+h

#	Dibujar frame
#	gmt basemap -B0
	gmt basemap -Baf

#	-----------------------------------------------------------------------------------------------------------
#	Cerrar figura
gmt end

#	Borrar temporales
#	rm tmp_* gmt.*