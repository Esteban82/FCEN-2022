#!/usr/bin/env bash
lat=-13.16169183
lon=-72.54587841
dpc=100

cat << EOF > pre.sh
gmt begin
	gmt math -T1/4/720+n 10 T POW -o1 -I = z
#	gmt math -T1/4/72+n 10 T POW -o1 -I = z
#	gmt math -T1/4/20+n 10 T POW -o1 -I = z
	gmt makecpt -Cgeo -H > topo.cpt
gmt end
EOF
cat << EOF > main.sh
gmt begin
	gmt grdimage @earth_relief -Rd -JG$lon/$lat/14.9c+z\${MOVIE_COL0}+v60 -Yc -Xc -B0 -Ctopo.cpt -I+d --GMT_GRAPHICS_DPU=${dpc}c --MAP_FRAME_PEN=faint
	echo $lon $lat | gmt plot -SE-10 -Gred@50
#	L=\$(gmt grdcut @earth_relief -Rd -JG$lon/$lat/14.9c+z\${MOVIE_COL0}+v60 -D+t --GMT_GRAPHICS_DPU=${dpc}c)
#	echo \${L} | gmt text -F+cTR+jTR+f8p
#	echo "altitude = \${MOVIE_COL0} L = \${L}"
gmt end
EOF
gmt movie main.sh -Sbpre.sh -NZoom_Relief -Tz -C15cx15cx100 -D36 -H8 -M0,png \
    -Lc0+gwhite+f12p+t"Altitude = %6.1lf km" -V -Gblack -Fmp4
