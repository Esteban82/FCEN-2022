#!/usr/bin/env bash
clear

#	Titulo de la animación
title=FAA_Upward
Z=400
REGION=-78/-18/-60/-20
PROJ=M20c
FAA=@earth_faa_01m_p
DEM=tmp_faa.nc
CUT=tmp_faa_U.nc

gmt begin $title png

#	Establecer Region, Proyeccion y grafico centrado (no dibuja nada)
   	gmt basemap -R$REGION -J$PROJ -B+n

	gmt grdcut @earth_faa_02m_p -R$REGION -G$DEM

#	Upward Continuation
	gmt grdfft $DEM -C800 -G$CUT

	gmt grd2cpt $DEM -Z

	gmt grdimage $CUT -C -I

   	gmt colorbar -DJMR+0/0.2c+w95%/0.618c+e -C -Ba+l"Anomal\355as Aire Libre (mGal)" -I

	gmt coast -Dl -W1/thinner
	gmt coast -Dl -N1
	gmt grdcontour $CUT -C50 -Wblack,- -A100 -GLZ-/Z+
	gmt basemap -Byf -Bxf -BWSne

	gmt basemap -Ln0.15/0.075+c+w800k+f+l

	echo $Z m | gmt text -F+cTR+jTR+f18p -Dj0.1i -Gwhite -W0.25p

#	*******************************************************
	DOMINIO=2/7000/1e-14/1e3
 	PROJ=X-15cl/5.2cl

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

#	Borrar Temporales
# rm tmp_* gmt.*