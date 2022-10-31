ECHO OFF
cls

#	Definir Variables del mapa
#	-----------------------------------------------------------------------------------------------------------

#	Titulo del mapa
	title=Copa_America
	echo $title

#	Region
	REGION=-85/-33/-58/15
	REGION3D=$REGION/0/35

#	Proyeccion Mercator (M)
	PROJ=M15c
	PROZ=5c
	persp=210/40

#	Nombre archivo de entrada
	INPUT="CopaAmerica.csv"

# 	Nombre archivo de salida y Variables Temporales
	CUT=temp_$title.grd
	COLOR=temp_$title.cpt
	SHADOW=temp_$title-shadow.grd
	OUT=$title.ps  

#	Parametros Generales
#	-----------------------------------------------------------------------------------------------------------
#	Sub-seccion FUENTE
	gmt set FONT_ANNOT_PRIMARY 8,Helvetica,black
	gmt set FONT_LABEL 8,Helvetica,black

#	Sub-seccion FORMATO
	gmt set FORMAT_GEO_MAP ddd:mm:ssF

#	Sub-seccion GMT
	gmt set GMT_VERBOSE w

#	Sub-seccion MAPA
	gmt set MAP_FRAME_TYPE fancy
	gmt set MAP_FRAME_WIDTH 0.1
	gmt set MAP_GRID_CROSS_SIZE_PRIMARY 0
	gmt set MAP_SCALE_HEIGHT 0.1618
	gmt set MAP_TICK_LENGTH_PRIMARY 0.1

#	Sub-seccion PS
	gmt set PS_MEDIA A3

#	Dibujar Figura
#	--------------------------------------------------------------------------------------------------------

#	Abrir archivo de salida (ps)
	gmt psxy -R$REGION3D -J$PROJ -JZ$PROZ -p$persp -T -K -P > $OUT

#	Pintar areas secas (-G). Resolucion datos full (-Df)
	gmt pscoast -R -J -O -K -JZ -p >> $OUT -Df -G200 

#	Pintar areas húmedas: Oceanos (-S) y Lagos y Rios (-C).
	gmt pscoast -R -J -O -K -JZ -p >> $OUT -Sdodgerblue2 -C200 -Df

#	Dibujar Paises (1 paises, 2 estados/provincias en America, 3 limite maritimo)
	gmt pscoast -R -J -JZ -O -K -p -Df >> $OUT -N1

#	Dibujar Ejes Longitud y Latitud
	gmt psbasemap -R -J -JZ -O -K -p >> $OUT -BWSneZ -Ba

#	-----------------------------------------------------------------------------
#	Titulo
	gmt psbasemap -R -J -JZ -O -K -p >> $OUT -B+t"Copas Am\351ricas Ganadas"

#	Eje Z
	gmt psbasemap -R -J -JZ -O -K -p >> $OUT -BWSneZ+b  -Bzafg+l"Cantidad"

#	Dibujar Datos en Columnas Apiladas
#	----------------------------------------------
	gmt psxyz -R -J -JZ -O -K -p >> $OUT $INPUT -So0.5c  -Gblue   -Wthinner -i0,1,2
	gmt psxyz -R -J -JZ -O -K -p >> $OUT $INPUT -So0.5cb -Ggreen  -Wthinner -i0,1,6,2
	gmt psxyz -R -J -JZ -O -K -p >> $OUT $INPUT -So0.5cb -Gyellow -Wthinner -i0,1,7,6
	gmt psxyz -R -J -JZ -O -K -p >> $OUT $INPUT -So0.5cb -Gred    -Wthinner -i0,1,8,7

#	Escribir Numero Total
	gmt convert $INPUT -o0,1,8 | gmt pstext -R$REGION -J -O -K -p -Gwhite@30 -D0/-0.8c -F+f20p,Helvetica-Bold,firebrick=thinner+jCM >> $OUT

#	Leyenda
#	----------------------------------------------------------------------------
#	Archivo auxiliar leyenda
 	echo H 10 Times-Roman Copas Am\351ricas > "temp_leyenda"
	echo N 1 >> "temp_leyenda"
 	echo S 0.25c r 0.5c blue   0.25p 0.75c 1 Puesto	 >> "temp_leyenda"
 	echo S 0.25c r 0.5c green  0.25p 0.75c 2 Puesto	 >> "temp_leyenda"
 	echo S 0.25c r 0.5c yellow 0.25p 0.75c 3 Puesto	 >> "temp_leyenda"
 	echo S 0.25c r 0.5c red    0.25p 0.75c 4 Puesto	 >> "temp_leyenda"

#	Dibujar leyenda	
	gmt pslegend -R -J -JZ -O -K -p >> $OUT "temp_leyenda" -DjLB+o0.2i+w1.35i/0+jBL -F+glightgrey+pthinner+s-4p/-6p/grey20@40

#	-----------------------------------------------------------------------------------------------------------
#	Cerrar el archivo de salida (ps)
	gmt psxy -J -R -JZ -T -O >> $OUT
	
#	Convertir ps en otros formatos: EPS (e), PDF (f), JPEG (j), PNG (g), TIFF (t)	
	gmt psconvert $OUT -A -Tg -Z

#	Borrar archivos temporales
	rm gmt.* temp_*