#!/bin/bash
clear

#	Temas a ver:
#	1. Resamplear grilla (resolución vs espaciado horizontal)

#	Define map
#	-----------------------------------------------------------------------------------------------------------
#	Titulo del mapa
	title=45_AireLibre_Dem
	echo $title

#	Region: Sudamerica y Atlantico Sur
	REGION=-72/-64/-35/-30
#	REGION=AR.A

#	Proyeccion Mercator (M)
	PROJ=M15c

# 	DEM topografico para efecto de sombreado
	DEM=@earth_relief_15s_p		

#	Grilla a graficar
	GRD=@earth_faa_01m_p		# Free Air Anomalies
#	GRD=@earth_vgg_01m_p		# Vertical Gravity Gradient
#	GRD=@earth_mag4km_02m_p		# EMAG2 a 4 km de altitud
#	GRD=@earth_geoid_01m_g		# Geoide 


# 	Nombre archivo de salida
	CUT=tmp_$title.nc
	SHADOW=tmp_$title-shadow.nc

#	Parametros GMT
#	-----------------------------------------------------------------------------------------------------------
#	Sub-seccion MAPA
	gmt set MAP_FRAME_AXES WesN
	gmt set MAP_SCALE_HEIGHT 0.1618
	gmt set MAP_TICK_LENGTH_PRIMARY 0.1

#	Dibujar mapa
#	-----------------------------------------------------------------------------------------------------------
#	Iniciar sesion y tipo de figura
gmt begin $title png
	
#	Setear la region y proyeccion
	gmt basemap -R$REGION -J$PROJ -B+n

#	Grilla para Sombreado a partir del DEM
	gmt grdgradient $DEM -G$SHADOW -R$REGION -A270 -Ne0.8

#	Recortar grilla
	gmt grdcut $GRD -R$REGION -Gtmp_grd
	
#	Resamplear grilla  para que tenga la misma resolucion que el DEM
	gmt grdsample tmp_grd -G$CUT -I15s		# Grillas con mismo registro
#	gmt grdsample tmp_grd -G$CUT -I15s -T   # Grillas con distinto registro

#	Ver informacion. Comparar valores para ver si las grillas coinciden. 	
	gmt grdinfo $SHADOW -C
	gmt grdinfo $SHADOW -Cn -o0,1,2,3,6,7,8,9
	gmt grdinfo $CUT 	-Cn -o0,1,2,3,6,7,8,9

#	Dibujar mapa
#	-----------------------------------------------------------------------------------------------------------
#	Crear Paleta de Colores. Paleta Maestra (-C), Definir rango (-Tmin/max/intervalo), CPT continuo (-Z)
	gmt grd2cpt $CUT -Z -L-100/100 -D

#	Crear Imagen a partir de grilla con  paleta de colores y sombreado
#	gmt grdimage $CUT
#	gmt grdimage $CUT -I
	gmt grdimage $CUT -I$SHADOW

#	Agrega escala de colores. (-E triangles). Posicion (-D) (horizontal = h)
	gmt colorbar -DJRM+o0.4/0+w10/0.618c+e -Ba20+l"Anomal\355as Aire Libre (mGal)" -I

#	-----------------------------------------------------------------------------------------------------------
#	Dibujar Bordes Administrativos. N1: paises. N2: Provincias, Estados, etc. N3: limites maritimos (Nborder[/pen])
	gmt coast -Df -N1/thinner
	gmt coast -Df -N2/thinnest,-

#	Dibujar Linea de Costa (W1)
	gmt coast -Df -W1/thinner

#	Dibujar frame
	gmt basemap -Bxaf -Byaf

#	-----------------------------------------------------------------------------------------------------------
#	Cerrar el archivo de salida (ps)
gmt end

	rm tmp_* gmt.*
