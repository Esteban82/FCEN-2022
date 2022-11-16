#!/bin/bash
 
#	Definir Variables del mapa
#	-----------------------------------------------------------------------------------------------------------
#	Titulo del mapa
	title=Mars_MOLA
	echo $title

#	Region: 
#	REGION=d
	REGION=322/325/-37/-34		# Crater de Hale
	REGION=-80/-8/-60/-30		# Argyre Basin

#	Proyeccion Mercator (M)
#	PROJ=W15c
	PROJ=M15c
#	PROJ=G0/0/90/15c

#	Grillas 
	GRD=Mars_MGS_MOLA_DEM_mosaic_global_463m.tif	# Original
	CUT=Mars.grd									# Procesada

#	Procesar Grilla original
#	-----------------------------------------------------------------------------------------------------------
#	Calcular grillas a partir de los armonicos esfericos
#	gmt grdedit $GRD -G$CUT -Rd

#	Ver informacion
#	gmt grdinfo $CUT

#	Dibujar mapa
#	-----------------------------------------------------------------------------------------------------------
#	Elipsoide
	gmt set PROJ_ELLIPSOID Mars

#	Iniciar sesion y tipo de figura
gmt begin $title png

#	Setear la region y proyeccion
	gmt basemap -R$REGION -J$PROJ -B+n

#	Crear Imagen a partir de grilla con  paleta de colores y sombreado
	gmt grdimage $CUT -I

#	Dibujar frame
	gmt basemap -Baf -BNWse

#	Agrega escala de colores. (-E triangles). Posici�n (-D) (horizontal = h). Posici�n (x,y) +wlargo/ancho. Anotaciones (-Ba). Leyenda (+l). 
	gmt colorbar -C -Baf+l"Alturas (km)" -I -DJCB+o0/0.3c+w80%+h -W0.001

#	-----------------------------------------------------------------------------------------------------------
#	Cerrar figurael archivo de salida (ps)
gmt end

#	Borrar temporales
	rm gmt.*

# Fuente:
# https://forum.generic-mapping-tools.org/t/questions-about-conversion-from-cartesian-coordinate-system-to-geographic-coordinate-system/781/7
