#!/bin/bash
clear

#	Definir variables del mapa
#	-----------------------------------------------------------------------------------------------------------

#	Titulo del mapa
	title=EJ11.5_Perfiles+Mapa
	echo $title

	DEM=GMRTv3_5.grd

#	Region: Argentina
	REGION=-88/-18/-56.5/15
	REGION=-88/-18/-57/15
	
#	Proyeccion Mercator (M)
	PROJ=M15c
#	PROJ=S-53/-21/45/15c
#	PROJ=S-65/-30/90/15c
	GRA="E:\Facultad\Datos_Geofisicos\Gravimetria\Sandwell-Smith\Datos\grav_29.1.img"

# 	Nombre archivo de salida
	OUT=$title.ps
	CUT=temp_$title.nc
	TGRA=temp_Grav.nc
	color=temp_$title.cpt
	SHADOW=temp_$title-shadow.nc

	gmt set MAP_FRAME_AXES WesN
	gmt set GMT_VERBOSE w

#	Dibujar mapa
#	-----------------------------------------------------------------------------------------------------------
#	Abrir archivo de salida (ps)
	gmt psxy -R%REGION% -J%PROJ% -T -K -P > $OUT

#	Recortar Grilla
	gmt grdcut "GMRTv3_5.grd" -G$CUT -R

#	Extraer informacion de la grilla recortada para determinar rango de CPT
#	grdinfo $CUT
#	grdinfo $CUT -T50
#	pause

#	Combinacion 2
	gmt makecpt -Cibcso      -T-8400/0/10 -Z -N >  $color
	gmt makecpt -Celevation  -T0/6050/50  -Z    >> $color

#	Grilla para sombreado
	gmt grdgradient $CUT -A270 -G$shadow -Ne0.5

#	Crear Imagen a partir de grilla con sombreado y cpt
	gmt grdimage -R -J -O -K $CUT -C$color  -I$shadow >> $OUT

#	Agregar escala de colores a partir de CPT (-C). Posición (x,y) +wlargo/ancho. Anotaciones (-Ba). Leyenda (+l). 
	gmt psscale -R -J -O -K -DJRM+o0.3c/0+w15/0.618c -C$color -Ba1+l"Elevaciones (km)"  -I >> $OUT -W0.001

#	Dibujar Trench
	gmt psxy -R -J -O -K >> $OUT "Trench_PlateProject.txt" -W1,red

#	Crear Grillas de Anomalias de Aire Libre
#	***********************************************************
#	Grilla Aire Libre
	gmt img2grd $GRA -R -G$TGRA -T1 -I1 -E -S0.1

#	Perfil: Crear archivo para dibujar perfil (Long Lat)
	echo -53 10  >  "temp_line"
	echo -53 -55 >> "temp_line"

#	Crear Periles Perdendiculares -Clongitud perfil/intervalo de datos/espaciado entre perfiles
#	gmt grdtrack -ELB/RT+i1k+d -G$TGRA -je > profiles.txt
#	gmt grdtrack "Trench_PlateProject.txt" -G$TGRA -C5000k/50k/200k+v > "temp_data"
#	gmt grdtrack "temp_line" -G$TGRA -C5000k/50k/200k > "temp_data"
#	gmt grdtrack "temp_line" -G$TGRA -C2000k/100k/500k > "temp_data"
#	gmt grdtrack "temp_line" -G$TGRA -C2000k/100k/1000k > "temp_data"
#	gmt grdtrack "temp_line" -G$TGRA -C2000k/50k/1000k > "temp_data"
#	gmt grdtrack "temp_line" -G$TGRA -C2000k/10k/1000k > "temp_data"
#	gmt grdtrack "temp_line" -G$TGRA -C2000k/10k/500k > "temp_data"
#	gmt grdtrack "temp_line" -G$TGRA -C2000k/10k/200k > "temp_data"
#	gmt grdtrack "temp_line" -G$TGRA -C5000k/10k/500k > "temp_data"
#	gmt grdtrack "temp_line" -G$TGRA -C5000k/10k/200k > "temp_data"
	gmt grdtrack "temp_line" -G$TGRA -C5000k/1k/200k > "temp_data"

	gmt pswiggle -R -J -O -K "temp_data" -i0,1,4 >> $OUT -Gred@50+p -Gblue@50+n -Z500 -T -W -DjRB+o0.5/0.5+w100+lmGal -F+gwhite+p+s

#	-----------------------------------------------------------------------------------------------------------
#	Dibujar frame
	gmt psbasemap -R -J -O -K -Baf >> $OUT

#	Dibujar Linea de Costa (W1)
	gmt pscoast -R -J -O -K -Df -W1/faint >> $OUT

#	-----------------------------------------------------------------------------------------------------------
#	Cerrar el archivo de salida (ps)
	gmt psxy -R -J -T -O >> $OUT

#	Convertir ps en otros formatos: EPS (e), PDF (f), JPEG (j), PNG (g), TIFF (t)
	gmt psconvert $OUT -Tg -A -Z

#	pause
	rm temp_* gmt.*