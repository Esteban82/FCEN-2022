#!/bin/bash
 
#	Definir Variables del mapa
#	-----------------------------------------------------------------------------------------------------------
#	Titulo del mapa
	title=Mars_MOLA_Pendiente
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
	#GRD=Mars_MGS_MOLA_DEM_mosaic_global_463m.tif	# Original
	GRD2=Mars.grd									# Procesada
    CUT=tmp_$title.grd

#	Procesar Grilla original
#	-----------------------------------------------------------------------------------------------------------
#	Convertir la grilla de a Long Lat
#	gmt grdedit $GRD -G$GRD2 -Rd

#	Recortar Grilla
#	gmt grdcut $GRD2 -G$CUT -R$REGION

#	Calcular Grilla con modulo del gradiente (-D) para grilla con datos geograficos (-fg)
#	gmt grdgradient $CUT -D -S$CUT -fg

#	Convertir modulo del gradiente a inclinacion (pendiente) en grados (ATAND).
#	gmt grdmath $CUT ATAND = $CUT

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

#   Crear CPT
	gmt makecpt -Crainbow -I -T0/15 -D

#	Crear Imagen a partir de grilla con  paleta de colores y sombreado
	gmt grdimage $CUT -I

#	Dibujar frame
	gmt basemap -Baf -BNWse

#	Agrega escala de colores. (-E triangles). Posici�n (-D) (horizontal = h). Posici�n (x,y) +wlargo/ancho. Anotaciones (-Ba). Leyenda (+l). 
	gmt colorbar -C -Baf+l"Pendiente (º)" -I -DJCB+o0/0.3c+w80%+h

#	-----------------------------------------------------------------------------------------------------------
#	Cerrar figurael archivo de salida (ps)
gmt end

#	Borrar temporales
	rm gmt.*

# Fuente:
# https://forum.generic-mapping-tools.org/t/questions-about-conversion-from-cartesian-coordinate-system-to-geographic-coordinate-system/781/7
