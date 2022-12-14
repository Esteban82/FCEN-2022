#!/usr/bin/env bash

#	Definir variables del mapa
#	-----------------------------------------------------------------------------------------------------------
#	Titulo del mapa
	title=Pendiente
	echo $title

#	Region: Argentina
	REGION=-72/-64/-35/-30

#	Proyeccion Mercator (M)
	PROJ=M15c

#	Grilla 
	GRD=@earth_relief_30s_p

# 	Nombre archivo de salida
	CUT=tmp_$title.nc
	color=tmp_$title.cpt
	SHADOW=tmp_$title-shadow.nc

#	Dibujar mapa
#	-----------------------------------------------------------------------------------------------------------
#	Iniciar sesion y tipo de figura
gmt begin $title png
	
#	Setear la region y proyeccion
	gmt basemap -R$REGION -J$PROJ -B+n 

#	Calcular grilla de pendientes
#	---------------------------------------------
#	Recortar Grilla
	gmt grdcut $GRD -G$CUT -R$REGION

#	Calcular Grilla con modulo del gradiente (-D) con datos geograficos (-fg)
	gmt grdgradient $CUT -D -S$CUT -fg

#	Convertir modulo del gradiente a inclinacion (porcentaje)
	gmt grdmath $CUT 100 MUL = $CUT
#	---------------------------------------------

#	Obterner Informacion de la grilla para crear paleta de colores (makecpt)

#	gmt grdinfo $CUT
#	gmt grdinfo $CUT -T2
	max=`gmt grdinfo $CUT -Cn -o5`
	gmt grdinfo $CUT -T 
#	gmt grdinfo $CUT -T+a0.5
#	gmt grdinfo $CUT -T+a5
	
	T=$(gmt grdinfo $CUT -T)
#	echo $T

#	Crear Paleta de Colores. Paleta Maestra (-C), Definir rango (-Tmin/max/intervalo).
#	gmt makecpt -Crainbow -T0/30/2 -I -D
	gmt makecpt -Crainbow $T -I
#	gmt makecpt -Crainbow -I -T0/$max
#	gmt makecpt -Crainbow -I -D -T0/$max
#	gmt makecpt -Crainbow -T6/30/2 -I

#	Crear Imagen a partir de grilla con sombreado (-I%SHADOW%)
	gmt grdimage $CUT -C -I+a270+nt1
#	gmt grdimage $CUT -C

#	Agregar escala de color. Posición (x,y) +wlargo/ancho. Anotaciones (-Ba). Leyenda (+l). 
	gmt colorbar -Dx15.5/0+w10.5/0.618c+ef -C -Ba+l"Inclinaci\363n pendiente (\045)"  # en %

#	Dibujar frame
	gmt basemap -Bxaf -Byaf -BWesN

#	Pintar areas húmedas: Oceanos (-S) y Lagos (-Cl/)f
	gmt coast -Da -Sdodgerblue2

#	Dibujar Linea de Costa (W1)
	gmt coast -Da -W1/faint

#	Dibujar Escala en el mapa centrado en -Lg Lon0/Lat0, calculado en meridiano (+c), 
	gmt basemap -Ln0.88/0.075+c-32:00+w100k+f+l

#	-----------------------------------------------------------------------------------------------------------
#	Cerrar el archivo de salida (ps)
gmt end

#	rm tmp_*
