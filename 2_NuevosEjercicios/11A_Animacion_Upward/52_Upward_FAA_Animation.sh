#!/usr/bin/env bash
clear

#	Titulo de la animación
title=52_Upward_Animacion

# 2. Crear archivos para la animacion
# 2A. Include
cat << 'EOF' > in.sh
gmt begin
    FAA=@earth_faa_01m_p
	REGION=-78/-18/-60/-20
	W=18.9c
	PROJ=M$W
	GRD=tmp_faa.nc
	CUT=tmp_faa_U.nc
gmt end
EOF

# 2A. Archivos previos
cat << 'EOF' > pre.sh
gmt begin
# Lista de Valores: Archivo con los valores que se usaran para el script principal 
  	gmt math -T0/40000/250    -o1 T = tmp_z
#	gmt math -T0/40000/240+n  -o1 T = tmp_z
#	gmt math -T0/40000/240+n  -o1 T = tmp_z --FORMAT_FLOAT_OUT=%0.0f # SIN decimales
#  	gmt math -T0/1000000/5000 -o1 T = tmp_z

#	Recortar grilla
	gmt grdcut $FAA -R$REGION -G$GRD

#	Crear CPT
	gmt grd2cpt $GRD -Z -H > cpt
gmt end
EOF

# 2B. Archivos previos
cat << 'EOF' > main.sh
gmt begin
#	Establecer Region, Proyeccion y grafico centrado (no dibuja nada)
   	gmt basemap -R$REGION -J$PROJ -B+n -Yf0.2c -Xf0.2c

#	Upward Continuation
	gmt grdfft $GRD -C${MOVIE_COL0} -G$CUT -fg

#	Dibujar grilla
	gmt grdimage $CUT -Ccpt -I 

#	Colobar
	gmt colorbar -DJRM+o0.3c/0c+w95%/0.618c+e -Ccpt -Ba+l"Anomal\355as Aire Libre (mGal)" -I

#	Linea de costa
	gmt coast -W1/thinner

#	Limite paises
	gmt coast -N1

#	Curvas de nivel	
	gmt grdcontour $CUT -C50 -Wblack,- -A100 -GLZ-/Z+

#	Mapa base
	gmt basemap -Byf -Bxf -BWsNe

#	Escala
	gmt basemap -Ln0.15/0.075+c+w800k+f+l

	echo $MOVIE_COL0 m | gmt text -F+cTR+jTR+f18p -Dj0.1i -Gwhite -W0.25p --FORMAT_FLOAT_OUT=%0.0f

#	*******************************************************
	DOMINIO=2/7000/1e-14/1e3
 	PROJ=X-${W}l/5.2cl

#	Establecer variables y desplazamiento en Y
 	gmt basemap -R$DOMINIO -J$PROJ -B+n -Yh+1.5

# 	Calcular FFT. -Er+wk: Longitudes de onda en km.
	gmt grdfft $CUT -fg -Er+wk -Gtmp_fft_r.txt
 	gmt grdfft $CUT -fg -Ex+wk -Gtmp_fft_x.txt
	gmt grdfft $CUT -fg -Ey+wk -Gtmp_fft_y.txt

# 	Ejes X e Y
 	gmt basemap -BSn -Bxa2f3g3+l"Wavelengths (km)" 
	gmt basemap -BwE -Bya0.5pfg0.5+l"Power Spectrum"

# 	Plotear linea (y agregar leyenda)
	gmt plot tmp_fft_x.txt -W0.5p,blue 	-lX
 	gmt plot tmp_fft_y.txt -W0.5p,red	-lY
	gmt plot tmp_fft_r.txt -W0.5p,green -lR

#	Defenir posición de la Leyenda
	gmt legend -DjBL+o0.3c/0.3c -F+p1p+glightgray+s
gmt end
EOF

#	3. Movie: Crear animacion
#	Opciones C: Canvas Size. -Agif -N: Nombre de la carpeta con archivos temporales -T
	gmt movie main.sh -Sbpre.sh -Iin.sh -N$title -Ttmp_z -C21.62cx24.44cx100 -V -M0,png -D12 -Zs -Fmp4  

#	Borrar Temporales
# rm tmp_* gmt.*