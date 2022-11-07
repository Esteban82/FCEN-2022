#!/usr/bin/env bash
clear

#	Titulo de la animación
title=39_Upward_Animacion

# 2. Crear archivos para la animacion
# 2A. Archivos previos
cat << 'EOF' > pre.sh
gmt begin
# Lista de Valores: Archivo con los valores que se usaran para el script principal 
#  	gmt math -T0/40000/250  -o1 T = tmp_z
  	gmt math -T0/1000000/5000 -o1 T = tmp_z
gmt end
EOF

# 2B. Archivos previos
cat << 'EOF' > main.sh
	REGION=-78/-18/-60/-20
	W=15c
	PROJ=M$W
	FAA=@earth_faa_01m_p
	DEM=tmp_faa.nc
	CUT=tmp_faa_U.nc
gmt begin
#	Establecer Region, Proyeccion y grafico centrado (no dibuja nada)
   	gmt basemap -R$REGION -J$PROJ -B+n -Yf0.2c -Xf0.2c
	gmt grdcut $FAA -R$REGION -G$DEM
#	Upward Continuation
	gmt grdfft $DEM -C${MOVIE_COL0} -G$CUT -fg
	gmt grd2cpt $DEM -Z
	gmt grdimage $CUT -C -I
   	gmt colorbar -DJMR+0/0.1c+w95%/0.618c+e -Crainbow -Ba+l"Anomal\355as Aire Libre (mGal)" -I
	gmt coast -Dl -W1/thinner
	gmt coast -Dl -N1
	gmt grdcontour $CUT -C50 -Wblack,- -A100 -GLZ-/Z+
	gmt basemap -Byf -Bxf -BWsNe
	gmt basemap -Ln0.15/0.075+c+w800k+f+l
	echo $MOVIE_COL0 m | gmt text -F+cTR+jTR+f18p -Dj0.1i -Gwhite -W0.25p
#	*******************************************************
	DOMINIO=2/7000/1e-14/1e3
 	PROJ=X-${W}l/5.2cl
#	Establecer variables y desplazamiento en Y
 	gmt basemap -R$DOMINIO -J$PROJ -B+n -Yh+1.5
# 	Calcular FFT de man docs +wk: Longitudes de onda en km. +n: Normalizado
 	gmt grdfft $CUT -fg -Er+wk -Gtmp_fft_r.txt
 	gmt grdfft $CUT -fg -Ex+wk -Gtmp_fft_x.txt
	gmt grdfft $CUT -fg -Ey+wk -Gtmp_fft_y.txt
# 	Ejes X e Y
 	gmt basemap -BSn -Bxa2f3g3+l"Wavelengths (km)" 
	gmt basemap -BwE -Bya0.5pfg0.5+l"Power Spectrum"
# 	Plotear linea
 	gmt plot tmp_fft_x.txt -W0.5p,blue 	-lX
 	gmt plot tmp_fft_y.txt -W0.5p,red	-lY
 	gmt plot tmp_fft_r.txt -W0.5p,green -lR
 	gmt legend -DjBL+o0.3c/0.3c -F+p1p+glightgray+s
gmt end
EOF

#	3. Movie: Crear animacion
#	Opciones C: Canvas Size. -Agif -N: Nombre de la carpeta con archivos temporales -T
	gmt movie main.sh -Sbpre.sh -N$title -Ttmp_z -C21.62cx24.44cx100 -V -Ml,png -D12 -Gyellow -Fmp4  

#	Borrar Temporales
# rm tmp_* gmt.*