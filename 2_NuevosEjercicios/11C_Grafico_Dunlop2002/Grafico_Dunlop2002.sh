#!/usr/bin/env bash

# Temas a ver:
# 1. Usar archivo con distintos simbolos y colores

#	Variables del Mapa
#	-----------------------------------------------------------------------------------------------------------
#	Titulo de la figura
	title=Grafico_Dunlop2002
	echo $title

#	Dominio de datos (eje X e Y)
	REGION=1/100/0.005/1

#	Proyeccion Lineal (X). Ancho y alto (en cm)
	PROJ=X15cl/10cl

#	Parametros GMT
#	-----------------------------------------------------------------------------------------------------------
#	Parametros de Fuentes: Titulo del grafico, del eje (label) y unidades del eje (ANNOT_PRIMARY)
	gmt set	FONT_TITLE 16,4,Black
	gmt set	FONT_LABEL 10p,19,Red
	gmt set	FONT_ANNOT_PRIMARY 8p,Helvetica,Blue

	gmt set PS_CHAR_ENCODING ISOLatin1+
	gmt set IO_SEGMENT_MARKER B

#	Dibujar mapa
#	-----------------------------------------------------------------------------------------------------------
#	Iniciar sesion y tipo de figura
	gmt begin $title png
	
#	Setear la region y proyeccion
	gmt basemap -R$REGION -J$PROJ -B+n

#	Tìtulo de la figura (-B+t)
	gmt basemap -B+t"Diagrama de Dunlop 2002"

#	Color de fondo del grafico (-B+g"color")
	gmt basemap -B+g200

#	Titulo de los ejes (X Y) por separado: (a)notacion), (f)rame y (l)abel. @- Inicio/Fin Subindice. 
	gmt basemap -Bxa2f3+l"H@-RC@-/H@-C@-" -Bya2f3+l"J@-RS@-/J@-S@-" -BWS
 
#	Graficar Lineas del Grafico Dunlop 2002
	gmt plot -Wthin <<- END 
	1,0.02
	100,0.02
	
	1,0.5
	100,0.5
	
	2,0.005
	2,1
	
	5,0.005
	5,1
	END

#	Poner Nombre de los Campos
	gmt text -F+f12 <<-END
	1.50,0.75,SD
	3.75,0.20,PSD
	10.00,0.10,SP+SD
	15.00,0.01,MD
	END

#	Graficar Datos como símbolos. Color (-G), Borde (-W) y forma (-S)
#	**************************************************************
	gmt plot "Datos.txt" -: -Wthinnest -S0.2 -Ccategorical
	
#	Dibujar Leyenda
 	gmt legend -DjTR+w3/0+o-1.7/0.2+jTC -F+gwhite+p+i+r+s <<- END
	N 1
	S 0.25c c 0.25c green thinnest 0.5c Rabot
	S 0.25c s 0.25c blue  thinnest 0.5c Hamilton
	S 0.25c t 0.25c red   thinnest 0.5c Sanctuary
	S 0.25c d 0.25c cyan  thinnest 0.5c Haslum Craig	
	END
		
#	---------------------------------------------------------------------------
#	Cerrar la sesion y mostrar archivo
gmt end

	rm gmt.*
