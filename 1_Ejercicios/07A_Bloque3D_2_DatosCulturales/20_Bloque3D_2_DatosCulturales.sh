#!/usr/bin/env bash
clear

# Proxy de la FCEN (direccion de proxy:numero de puerto).
# Descomentar si se esta en FCEN
export http_proxy="http://proxy.fcen.uba.ar:8080"

#	Temas a ver:
#	1. Dibujar datos culturales en bloque 3D.

#	Definir Variables del mapa
#	-----------------------------------------------------------------------------------------------------------
#	Titulo del mapa
	title=20_Bloque3D_2_DatosCulturales
	echo $title

#	Region: Cuyo
	REGION=-72/-64/-35/-30
	BASE=-10000			# en metros
	TOP=10000			# en metros
	REGION3D=$REGION/$BASE/$TOP

#	Proyeccion Mercator (M)
	PROJ=M14c
	PROZ=2c				# variable para escala vertical
	p=160/30

#	Grilla
#	GRD=@earth_relief_30s
	GRD=@earth_relief_15s
#	GRD=@earth_relief_03s

# 	Nombre archivo de salida y Variables Temporales
	CUT=tmp_$title.nc
	SHADOW=tmp_$title-shadow.nc


#	Parametros Generales
#	-----------------------------------------------------------------------------------------------------------
#	Sub-seccion FORMATO
	gmt set FORMAT_GEO_MAP ddd:mm:ssF

#	Sub-seccion GMT
	gmt set GMT_VERBOSE w

#	Dibujar mapa
#	-----------------------------------------------------------------------------------------------------------
#	Iniciar sesion y tipo de figura
gmt begin $title png

#	Recortar Grilla
	gmt grdcut $GRD -G$CUT -R$REGION

#	Crear variables con valor de altura maximo
	max=`gmt grdinfo $CUT -Cn -o5`

#	Crear Paleta de Color solo para topografia
	gmt makecpt -Cdem4 -T0/$max

#	Crear Grilla de Pendientes para Sombreado (Hill-shaded). Definir azimuth del sol (-A)
	gmt grdgradient $CUT -A160 -G$SHADOW -Nt0.8

#	Dibujar Figura
#	--------------------------------------------------------------------------------------------------------
#	Bloque 3D. 
#	gmt grdview $CUT -R$REGION3D -J$PROJ -JZ$PROZ -p$p -I$SHADOW -C -Qi300
#	gmt grdview $CUT -R$REGION3D -J$PROJ -JZ$PROZ -p$p -I$SHADOW -C -Qi300 -Wf0.5 -N$BASE
#	gmt grdview $CUT -R$REGION3D -J$PROJ -JZ$PROZ -p$p -I$SHADOW -C -Qi300 -Wf0.5 -N$BASE+glightgray
	gmt grdview $CUT -R$REGION3D -J$PROJ -JZ$PROZ -p$p -I$SHADOW -C -Qi300 -Wf0.5 -N$BASE+glightgray -BnSwEZ -Baf -Bzaf+l"Altura (m)"

#	Pintar Oceanos (-S) y Lineas de Costa
	gmt coast -p$p/0 -Da -Sdodgerblue2 -A0/0/1
	gmt coast -p$p/0 -Da -W1/0.3,black
	
#	Dibujar datos de coast en 3D
	gmt coast -R$REGION -Df -M -N1/ | gmt grdtrack -G$CUT -sa | gmt plot3d -R$REGION3D -p$p -W0.5,black
	gmt coast -R$REGION -Df -M -N2/ | gmt grdtrack -G$CUT -sa | gmt plot3d -R$REGION3D -p$p -W0.2,black,-
	gmt coast -R$REGION -Df -M -Ia/ | gmt grdtrack -G$CUT -sa | gmt plot3d -R$REGION3D -p$p -W0.2,blue,-


#	Dibujar datos IGN en 3D
	gmt grdtrack -R$REGION IGN/RedVial_Autopista.gmt                       -G$CUT | gmt plot3d -R$REGION3D -p$p -Wthinnest,black
	gmt grdtrack -R$REGION IGN/RedVial_Ruta_Nacional.gmt                   -G$CUT | gmt plot3d -R$REGION3D -p$p -Wthinnest,black
	gmt grdtrack -R$REGION IGN/RedVial_Ruta_Provincial.gmt                 -G$CUT | gmt plot3d -R$REGION3D -p$p -Wfaint,black
	gmt grdtrack -R$REGION IGN/lineas_de_transporte_ferroviario_AN010.shp  -G$CUT | gmt plot3d -R$REGION3D -p$p -Wthinnest,darkred

#	Agregar escala de colores a partir de CPT (-C). Posici??n (x,y) +wlargo/ancho. Anotaciones (-Ba). Leyenda (+l). 
	gmt colorbar -DJCB+o0/0.7c+w14/0.618c -C -Ba1+l"Elevaciones (km)" -I -W0.001 -p$p

#	-----------------------------------------------------------------------------------------------------------
#	Cerrar el archivo de salida (ps)
gmt end

#	Borrar archivos temporales
	rm tmp_* gmt*

#	Ejercicios sugeridos
#	1. Agregar mas datos culturales.