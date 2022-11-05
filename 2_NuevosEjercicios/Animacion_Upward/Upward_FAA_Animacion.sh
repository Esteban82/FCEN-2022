#!/usr/bin/env bash
clear

#	Titulo de la animación
title=39_Animacion04

# 2. Crear archivos para la animacion
# 2A. Archivos previos
cat << 'EOF' > pre.sh
gmt begin
# Lista de Valores: Archivo con los valores que se usaran para el script principal 
#  	gmt math -T0/40000/250  -o1 T = tmp_z
   	gmt math -T0/40000/2500 -o1 T = tmp_z
gmt end
EOF

# 2B. Archivos previos
cat << 'EOF' > main.sh

	REGION=-78/-18/-60/-20
	PROJ=M15c
	DEM=@earth_faa_02m_p

	CUT=tmp_$title.nc
	SHADOW=tmp_$title_shadow.nc

gmt begin

#	Establecer Region, Proyeccion y grafico centrado (no dibuja nada)
   	gmt basemap -R$REGION -J$PROJ -B0 -Yf0.2c -Xf1.2c

#	Upward Continuation
	gmt grdfft $DEM -C${MOVIE_COL0} -G$CUT -fg

	gmt grd2cpt $DEM -Z

#	gmt grdgradient $CUT -A0/270 -G$SHADOW -Ne0.5
#	gmt grdimage $CUT -C -I$SHADOW
	gmt grdimage $CUT -C -I

   	gmt colorbar -Dx15.5/0.3+w13.7/0.618c+e -C -Ba+l"Anomal\355as Aire Libre (mGal)" -I

	gmt coast -Dl -W1/thinner
	gmt coast -Dl -N1
	gmt grdcontour $CUT -C50 -Wblack,- -A100 -GLZ-/Z+
	gmt basemap -Byaf -Bxaf -BWsNe

	gmt basemap -Ln0.15/0.075+c+w800k+f+l

	echo $MOVIE_COL0 m | gmt text -F+cTR+jTR+f18p -Dj0.1i -Gwhite -W0.25p

#	SET	REGION=2/7000/1e-14/1e3
# REM	Proyeccion Cartesiana Logaritmico
# 	SET	PROJ=X-15cl/5.2cl

# REM	Establecer variables y desplazamiento en Y
# 	gmt basemap -R%REGION% -J%PROJ% -B0 -Y15.935
#
# REM	Calcular FFT de man docs +wk: Longitudes de onda en km. +n: Normalizado
# 	gmt grdfft %CUT% -fg -Er+wk -G"temp_fft_r.txt"
# 	gmt grdfft %CUT% -fg -Ex+wk -G"temp_fft_x.txt"
# 	gmt grdfft %CUT% -fg -Ey+wk -G"temp_fft_y.txt"
#
# REM	Ejes X e Y
# 	gmt basemap -Bxa2f3g3+l"Wavelengths (km)" -Bya0.5pfg0.5+l"Power Spectrum" -BwSnE

# REM	Plotear linea
# 	gmt plot "temp_fft_x.txt" -W0.5p,blue
# 	gmt plot "temp_fft_y.txt" -W0.5p,red
# 	gmt plot "temp_fft_r.txt" -W0.5p,green
	
# REM	Dibujar Leyenda
# 	echo N 1 >  "temp_leyenda"

# 	echo S 0.2c - 0.5c - 1p,blue 0.5c    X >> "temp_leyenda"
# 	echo S 0.2c - 0.5c - 1p,red, 0.5c    Y >> "temp_leyenda"
# 	echo S 0.2c - 0.5c - 1p,green, 0.5c  R >> "temp_leyenda"

# 	gmt legend "temp_leyenda" -DjBL+w1.0c+o0.3c/0.3c -F+p1p+glightgray+s
gmt end
EOF

#	3. Movie: Crear animacion
#	Opciones C: Canvas Size. -Agif -N: Nombre de la carpeta con archivos temporales -T
#	gmt movie "Upward_FAA_ARG_Spectrum+Map_MainScript.bat" -N"Upward_FAA_ARG_Espectrum+Map2" -Ttmp_z -C19.22cx21.735cx100 -Fmp4 -D12
	gmt movie main.sh -Sbpre.sh -N$title -Ttmp_z -C19.22cx21.735cx100 -Ml,png -D12 #-Fmp4
#	gmt movie main.sh -Chd -N$title -Iinclude.sh -Tflight_path.txt -Sbpre.sh -H2 -Vi -Ml,png -Zs -Fmp4


#	Borrar Temporales
rm tmp_* gmt.*