#!/usr/bin/env bash


#	Titulo de la animación
title=Zoom_Relief

# Coordenadas Machu Picchu
lat=-13.16169183
lon=-72.54587841
dpc=100

cat << EOF > pre.sh
gmt begin
	gmt math -T1/4/720+n 10 T POW -o1 -I = z
#	gmt math -T1/4/20+n 10 T POW -o1 -I = z
	gmt makecpt -Cgeo -H > topo.cpt
gmt end
EOF
cat << EOF > main.sh
gmt begin
	gmt grdimage @earth_relief -Rd -JG$lon/$lat/14.9c+z\${MOVIE_COL0}+v60 -Yc -Xc -B0 -Ctopo.cpt -I+d --GMT_GRAPHICS_DPU=${dpc}c --MAP_FRAME_PEN=faint
	echo $lon $lat | gmt plot -SE-10 -Gred@50
gmt end
EOF
gmt movie main.sh -Sbpre.sh -N$title -Tz -C15cx15cx100 -D36 -H8 -M0,png \
    -Lc0+gwhite+f12p+t"Altitude = %6.1lf km" -V -Zs #-Gblack -Fmp4
