#!/bin/bash
clear

#	Definir variables del mapa
#	-----------------------------------------------------------------------------------------------------------
#	Titulo del mapa
	title=51_Perfiles+Mapa
	echo $title

#	Region: Sudamerica
	REGION=-88/-18/-56.5/15
	REGION=-88/-18/-57/15
#	REGION=-70/-40/-40/-20

#	Proyeccion Mercator (M)
	PROJ=M15c

# 	DEM topografico para efecto de sombreado
	DEM=@earth_relief

#	Grilla a graficar
	GRD=@earth_faa_01m_p		# Free Air Anomalies
#	GRD=@earth_vgg_01m_p		# Vertical Gravity Gradient
#	GRD=@earth_mag4km_02m_p		# EMAG2 a 4 km de altitud
#	GRD=@earth_geoid_01m_g		# Geoide 

# 	Nombre archivo de salida
	CUT=tmp_$title.nc

#	Dibujar mapa
#	-----------------------------------------------------------------------------------------------------------
#	Iniciar sesion y tipo de figura
gmt begin $title png
	
#	Setear la region y proyeccion
	gmt basemap -R$REGION -J$PROJ -B+n

#	Crear Imagen a partir de grilla con sombreado y cpt
	gmt grdimage $DEM -I

#	Agrega escala de colores. (-E triangles). Posicion (-D) (horizontal = h)
	gmt colorbar -DJRM+o0.4/0+w90%/0.618c -Ba+l"Elevaciones (km)" -I -W0.001

#	Dibujar Trench
	gmt plot Trench.txt -W1,red

#	Crear Grillas de Anomalias de Aire Libre
#	***********************************************************
#	Recortar grilla
	gmt grdcut $GRD -R$REGION -G$CUT

#	Perfil: Crear archivo para dibujar perfil (Long Lat)
	cat > tmp_line <<- END
	-53 10
	-53 -56
	END

#	Crear Periles Perpendiculares
#	***********************************************************
# 	-Clongitud perfil/intervalo de datos/espaciado entre perfiles
#	Perfiles solo en puntos originales
#	gmt grdtrack tmp_line 	-G$CUT -C2000k/100k         > tmp_data  

#	Agregar perfiles intermedios	
	gmt grdtrack tmp_line 	-G$CUT -C2000k/1k/200k    > tmp_data
#	gmt grdtrack tmp_line   -G$CUT -C2000k/100k/500k  > tmp_data
#	gmt grdtrack tmp_line   -G$CUT -C2000k/100k/1000k > tmp_data
#	gmt grdtrack tmp_line   -G$CUT -C2000k/50k/1000k  > tmp_data
#	gmt grdtrack tmp_line   -G$CUT -C2000k/10k/1000k  > tmp_data
#	gmt grdtrack tmp_line   -G$CUT -C2000k/10k/500k   > tmp_data
#	gmt grdtrack tmp_line   -G$CUT -C2000k/10k/200k   > tmp_data
#	gmt grdtrack tmp_line   -G$CUT -C5000k/10k/500k   > tmp_data
#	gmt grdtrack tmp_line   -G$CUT -C5000k/10d/200k   > tmp_data
#	gmt grdtrack tmp_line   -G$CUT -C5000k/1k/200k    > tmp_data

#	Extraer espaciado de las grilla
	INC=$(gmt grdinfo $CUT -Cn -o7)
#	Usar distancias en grados
#	gmt grdtrack tmp_line 	-G$CUT -C20d/$INC        > tmp_data   

#	Usar otra linea de la trinchera para hacer los perfiles
#	gmt grdtrack Trench.txt -G$CUT -C5000k/50k/200k+v > tmp_data
#	gmt grdtrack Trench.txt -G$CUT -C1000k/10k/100k 	  > tmp_data
#	gmt grdtrack Trench.txt -G$CUT -C1000k/1k/200k    > tmp_data
#	gmt grdtrack Trench.txt -G$CUT -C1000k/1k/500k    > tmp_data



#	Plotear datos
	gmt wiggle tmp_data -i0,1,4 -Gred@50+p -Gblue@50+n -Z500 -T -W -DjRB+o0.5/0.5+w100+lmGal -F+gwhite+p+s

#	-----------------------------------------------------------------------------------------------------------
#	Dibujar frame
	gmt basemap -Baf

#	Dibujar Linea de Costa (W1)
	gmt coast -Da -W1/faint

#	-----------------------------------------------------------------------------------------------------------
#	Cerrar el archivo de salida (ps)
gmt end

#	rm tmp_* gmt.*	# Borrar archivos temporales

#	Ejercicios sugeridos
#	1. Probar las otras combinaciones para crear perfiles perpendiculares
