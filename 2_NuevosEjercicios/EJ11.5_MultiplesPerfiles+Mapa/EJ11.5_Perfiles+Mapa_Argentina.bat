ECHO OFF
cls

REM	Definir variables del mapa
REM	-----------------------------------------------------------------------------------------------------------

REM	Titulo del mapa
	SET	title=EJ11.5_Perfiles+Mapa_Argentina
	echo %title%

	SET	DEM=GMRTv3_5.grd

REM	Region: Argentina
rem	SET	REGION=-88/-18/-57/15
	SET	REGION=-88/-42/-56/-21
rem	SET	REGION=-88/-56/-42/-21r
	
REM	Proyeccion Mercator (M)
	SET	PROJ=M15c
rem	SET	PROJ=U-20/15c
rem	SET	PROJ=S-53/-21/45/15c
rem	SET	PROJ=S-65/-30/90/15c
	SET	GRA="E:\Facultad\Datos_Geofisicos\Gravimetria\Sandwell-Smith\27.1\grav.img.27.1"

REM 	Nombre archivo de salida
	SET	OUT=%title%.ps
	SET	CUT=temp_%title%.nc
	SET	TGRA=temp_Grav.nc
	SET	color=temp_%title%.cpt
	SET	SHADOW=temp_%title%_shadow.nc

	gmtset MAP_FRAME_AXES WesN
	gmtset GMT_VERBOSE 1

REM	Dibujar mapa
REM	-----------------------------------------------------------------------------------------------------------
REM	Abrir archivo de salida (ps)
	gmt psxy -R%REGION% -J%PROJ% -T -K -P > %OUT%

REM	Recortar Grilla
	gmt grdcut "GMRTv3_5.grd" -G%CUT% -R

REM	Extraer informacion de la grilla recortada para determinar rango de CPT
rem	grdinfo %CUT%
rem	grdinfo %CUT% -T50
rem	pause

REM	Combinacion 2
rem	gmt makecpt -Cibcso      -T-8400/0/10 -Z -N >  %color%
rem	gmt makecpt -Celevation  -T0/6050/50  -Z    >> %color%

REM	Grilla para sombreado
	gmt grdgradient %CUT% -A270 -G%SHADOW% -Ne0.5

REM	Crear Imagen a partir de grilla con sombreado y cpt
	gmt grdimage -R -J -O -K %CUT% -C%color%  -I%SHADOW% >> %OUT%

REM	Agregar escala de colores a partir de CPT (-C). Posición (x,y) +wlargo/ancho. Anotaciones (-Ba). Leyenda (+l). 
	gmt psscale -R -J -O -K -DJRM+o0.3c/0+w15/0.618c -C%color% -Ba1+l"Elevaciones (km)"  -I >> %OUT% -W0.001

REM	Dibujar Trench
	gmt psxy -R -J -O -K >> %OUT% "Trench_PlateProject.txt" -W1,red

REM	Crear Grillas de Anomalias de Aire Libre
REM	***********************************************************
REM	Grilla Aire Libre
	gmt img2grd %GRA% -R -G%TGRA% -T1 -I1 -E -S0.1

REM	Perfil: Crear archivo para dibujar perfil (Long Lat)
	echo -65 10  >  "temp_line"
	echo -65 -56 >> "temp_line"

REM	Crear Periles Perdendiculares -Clongitud perfil/intervalo de datos/espaciado entre perfiles
rem	gmt grdtrack -ELB/RT+i1k+d -G%TGRA% -je > profiles.txt
rem	gmt grdtrack "temp_line" -G%TGRA% -C5000k/50k/200k > "temp_data"
rem	gmt grdtrack "temp_line" -G%TGRA% -C2000k/100k/500k > "temp_data"
rem	gmt grdtrack "temp_line" -G%TGRA% -C2000k/100k/1000k > "temp_data"
rem	gmt grdtrack "temp_line" -G%TGRA% -C2000k/50k/1000k > "temp_data"
rem	gmt grdtrack "temp_line" -G%TGRA% -C2000k/10k/1000k > "temp_data"
rem	gmt grdtrack "temp_line" -G%TGRA% -C2000k/10k/500k > "temp_data"
rem	gmt grdtrack "temp_line" -G%TGRA% -C2000k/10k/200k > "temp_data"
rem	gmt grdtrack "temp_line" -G%TGRA% -C5000k/10k/500k > "temp_data"
rem	gmt grdtrack "temp_line" -G%TGRA% -C5000k/10k/200k > "temp_data"
rem	gmt grdtrack "temp_line" -G%TGRA% -C5000k/1k/200k > "temp_data"
rem	gmt grdtrack "temp_line" -G%TGRA% -C5000k/1k/100k > "temp_data"
rem	gmt grdtrack "temp_line" -G%TGRA% -C5000k/1k/50k > "temp_data"
rem	gmt grdtrack "Trench_PlateProject.txt" -G%TGRA% -C1000k/1k/100k > "temp_data"
rem	gmt grdtrack "Trench_PlateProject.txt" -G%TGRA% -C1000k/1k/200k > "temp_data"
	gmt grdtrack "Trench_PlateProject.txt" -G%TGRA% -C1000k/1k/500k > "temp_data"

rem	gmt pswiggle -R -J -O -K "temp_data" -i0,1,4 >> %OUT% -Gred@50+p -Gblue@50+n -Z500 -DjRB+o0.5/0.5+w100+lmGal -F+gwhite+p+s -T -W 
rem	gmt pswiggle -R -J -O -K "temp_data" -i0,1,4 >> %OUT% -Gred@50+p -Gblue@50+n -Z500 -DjRB+o0.5/0.5+w100+lmGal -F+gwhite+p+s -T
	gmt pswiggle -R -J -O -K "temp_data" -i0,1,4 >> %OUT% -Gred@50+p -Gblue@50+n -Z500 -DjRB+o0.5/0.5+w100+lmGal -F+gwhite+p+s
rem	gmt pswiggle -R -J -O -K "temp_data" -i0,1,4 >> %OUT% -Gwhite@50+p -Gblack@50+n -Z500 -DjRB+o0.5/0.5+w100+lmGal -F+gwhite+p+s

REM	-----------------------------------------------------------------------------------------------------------
REM	Dibujar frame
	gmt psbasemap -R -J -O -K -Bxaf -Byaf >> %OUT%

REM	Dibujar Linea de Costa (W1)
	gmt pscoast -R -J -O -K -Df -W1/faint >> %OUT%

REM	Dibujar Limites Paises
	gmt pscoast -R -J -O -K >> %OUT% -N1/

REM	-----------------------------------------------------------------------------------------------------------
REM	Cerrar el archivo de salida (ps)
	gmt psxy -R -J -T -O >> %OUT%

REM	Convertir ps en otros formatos: EPS (e), PDF (f), JPEG (j), PNG (g), TIFF (t)
	gmt psconvert %OUT% -Tg -A

rem	pause
rem	del temp_*
	del %OUT%
