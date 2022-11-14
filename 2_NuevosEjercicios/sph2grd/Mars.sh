#!/bin/bash
 
#	Definir Variables del mapa
#	-----------------------------------------------------------------------------------------------------------
#	Titulo del mapa
	title=MarsTopo
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

#	Calcular grillas a partir de los armonicos esfericos
#	Cambiar resolucion de la grilla
	gmt sph2grd -R$REGION $SPH -G$CUT -Ng -V -I1     -F1/1/710/720
#	gmt sph2grd -R$REGION $SPH -G$CUT -Ng -V -I0.5   -F1/1/710/720
#	gmt sph2grd -R$REGION $SPH -G$CUT -Ng -V -I0.25  -F1/1/710/720
#	gmt sph2grd -R$REGION $SPH -G$CUT -Ng -V -I0.125 -F1/1/710/720

#	Cambiar rango de armonicos esfericos utlizados
#	gmt sph2grd -R$REGION $SPH -G$CUT -Ng -V -I0.125 -F1/1/85/90
#	gmt sph2grd -R$REGION $SPH -G$CUT -Ng -V -I0.125 -F1/1/180/180
#	gmt sph2grd -R$REGION $SPH -G$CUT -Ng -V -I0.125 -F1/1/350/360
#	gmt sph2grd -R$REGION $SPH -G$CUT -Ng -V -I0.25  -F0/0/710/720

#	Usar con MarsTopo2600.shape 
#	gmt sph2grd -R$REGION $SPH -G$CUT -Ng -V -I01m   -F1/1/1410/1420
#	gmt sph2grd -R$REGION $SPH -G$CUT -Ng -V -I01m   -F1/1/2600/2600

#	Extraer informacion
#	gmt grdinfo $CUT

#	Dibujar mapa
#	-----------------------------------------------------------------------------------------------------------
#	Crear CPT. Paleta Maestra (-C), Definir rango (-Tmin/max/intervalo), CPT continuo (-Z)
	gmt makecpt -T-8000/12000 -D

#	Crear Imagen a partir de grilla con  paleta de colores y sombreado
	gmt grdimage $CUT -I -C

#	Agrega escala de colores. (-E triangles). Posici�n (-D) (horizontal = h). Posici�n (x,y) +wlargo/ancho. Anotaciones (-Ba). Leyenda (+l). 
	gmt colorbar -C -Baf+l"Alturas (km)" -I -DJCB+o0/0.3c+w80%+h -W0.001

#	Dibujar frame
#	gmt basemap -B0
	gmt basemap -Baf

#	-----------------------------------------------------------------------------------------------------------
#	Cerrar figurael archivo de salida (ps)
gmt end

#	Borrar temporales
#	rm tmp_* gmt.*

# Fuente:
# Link para version original con 2600 coeficientes
# https://zenodo.org/record/3870922/files/MarsTopo2600.shape.gz?download=1