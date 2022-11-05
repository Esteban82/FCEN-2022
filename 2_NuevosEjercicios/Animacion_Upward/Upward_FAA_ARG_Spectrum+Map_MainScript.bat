ECHO OFF
REM cls
 
REM	Define map
REM	-----------------------------------------------------------------------------------------------------------
REM	Titulo del mapa
	SET	title=Upward_FAA_ARG_Spectrum+Map
    	echo %title%

REM	Region: Sudamerica y Atlantico Sur
	SET	REGION=-78/-18/-60/-20

REM	Proyeccion Mercator (M)
	SET	PROJ=M15c
    	SET 	DEM="Mapa_ARG_AireLibre.nc"

REM 	Nombre archivo de salida
	SET	CUT=temp_%title%.nc
	SET	SHADOW=temp_%title%_shadow.nc

REM	Sub-seccion FUENTE
	gmtset FONT_ANNOT_PRIMARY 10,Helvetica,black
	gmtset FONT_LABEL 12,Helvetica,black

REM	-----------------------------------------------------------------------------------------------------------
REM 	Iniciar Sesion
    	gmt begin %title% png

REM	Establecer Region, Proyeccion y grafico centrado (no dibuja nada)
    	gmt basemap -R%REGION% -J%PROJ% -B0 -Yf0.2c -Xf1.2c

REM	Upward Continuation
	gmt grdfft %DEM% -C%MOVIE_COL0% -G%CUT% -fg

	REM grdinfo %CUT%
REM 	pause

REM	Dibujar mapa
REM	-----------------------------------------------------------------------------------------------------------
REM	Crear Paleta de Colores. Paleta Maestra (-C), Definir rango (-Tmin/max/intervalo), CPT continuo (-Z)
	gmt grd2cpt %DEM% -Z

REM	Crear Grilla de Pendientes para Sombreado (Hill-shaded). Definir azimuth del sol (-A)
	gmt grdgradient %CUT% -A0/270 -G%SHADOW% -Ne0.5

REM	Crear Imagen a partir de grilla con  paleta de colores y sombreado
	gmt grdimage %CUT% -C -I%SHADOW%

REM	Agrega escala de colores. (-E triangles). Posicion (-D) (horizontal = h)
    	gmt psscale -Dx15.5/0.3+w13.7/0.618c+e -C -Ba+l"Anomal\355as Aire Libre (mGal)" -I

REM	Dibujar Linea de Costa (W1)
	gmt coast -Dl -W1/thinner

	gmt coast -Dl -N1

REM 	Curvas de Nivel
	gmt grdcontour %CUT% -C50 -Wblack,- -A100 -GLZ-/Z+

REM	Dibujar frame
	gmt basemap -Byaf -Bxaf -BWsNe

REM	Escala calculada en meridiano (+c), ancho (+w).
	gmt basemap -Ln0.15/0.075+c-54:00+w800k+f+l

REM 	Agregar texto 
	echo %MOVIE_COL0% m | gmt text -F+cTR+jTR+f18p -Dj0.1i -Gwhite -W0.25p
    
REM 	***************************************************************
REM	Dominio de Datos
	SET	REGION=2/7000/1e-14/1e3
REM	Proyeccion Cartesiana Logaritmico
	SET	PROJ=X-15cl/5.2cl

REM	Establecer variables y desplazamiento en Y
	gmt basemap -R%REGION% -J%PROJ% -B0 -Y15.935

REM	Calcular FFT de man docs +wk: Longitudes de onda en km. +n: Normalizado
	gmt grdfft %CUT% -fg -Er+wk -G"temp_fft_r.txt"
	gmt grdfft %CUT% -fg -Ex+wk -G"temp_fft_x.txt"
	gmt grdfft %CUT% -fg -Ey+wk -G"temp_fft_y.txt"

REM	Ejes X e Y
	gmt basemap -Bxa2f3g3+l"Wavelengths (km)" -Bya0.5pfg0.5+l"Power Spectrum" -BwSnE

REM	Plotear linea
	gmt plot "temp_fft_x.txt" -W0.5p,blue
	gmt plot "temp_fft_y.txt" -W0.5p,red
	gmt plot "temp_fft_r.txt" -W0.5p,green
	
REM	Dibujar Leyenda
	echo N 1 >  "temp_leyenda"

	echo S 0.2c - 0.5c - 1p,blue 0.5c    X >> "temp_leyenda"
	echo S 0.2c - 0.5c - 1p,red, 0.5c    Y >> "temp_leyenda"
	echo S 0.2c - 0.5c - 1p,green, 0.5c  R >> "temp_leyenda"

	gmt legend "temp_leyenda" -DjBL+w1.0c+o0.3c/0.3c -F+p1p+glightgray+s

REM	-----------------------------------------------------------------------------------------------------------
REM	Finalizar sesion y mostrar figura
	gmt end
