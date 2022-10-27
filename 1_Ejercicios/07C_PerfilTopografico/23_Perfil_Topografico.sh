#!/bin/bash
clear

# 	Temas a ver:
#	1. Definer una linea e interpolarla 
#	2. Agregar al perfil datos extraidos de una grilla.
#	3. Graficar los datos en un perfil.

#	Define map
#	-----------------------------------------------------------------------------------------------------------
#	Titulo del mapa
	title=23_Perfil_Topografico
	echo $title
	
#	Dimensiones del Grafico: Longitud (L), Altura (H).
	L=15
	H=5

#	Resolucion de la grilla (y del perfil)
	RES=15s

#	Base de datos de GRILLAS
	DEM=@earth_relief_$RES

#	Dibujar mapa
#	-----------------------------------------------------------------------------------------------------------
#	Iniciar sesion y tipo de figura
gmt begin $title png

#	Calcular Distancia a lo largo de la linea y agregar datos geofisicos
#	-----------------------------------------------------------------------------------------------------------
#	Perfil: Crear archivo para dibujar perfil (Long Lat)
	cat > tmp_line <<- END
	-76 -32
	-46 -32
	END

#	Interpolar: agrega datos en el perfil cada 15 seg km (-I).
#	gmt sample1d tmp_line -I0.2k > tmp_sample1d -fg
	gmt sample1d tmp_line -I$RES > tmp_sample1d -fg

#	Crear variable con region geografica del perfil
	REGION=$(gmt info tmp_sample1d -I+e0.1)
	echo $REGION

#	Distancia: Agrega columna (3a) con distancia del perfil en km (-G+uk)
	gmt mapproject tmp_sample1d -G+uk > tmp_track

#	Agrega columna (4) con datos extraidos de la grilla -G (altura) sobre el perfil
	gmt grdtrack tmp_track -G$DEM $REGION > tmp_data

#	Hacer Grafico y dibujar perfil
#	-----------------------------------------------------------------------------------------------------------
#	Informacion para crear el grafico. 3a Columna datos en km. 4a Columna datos de Topografia.
	gmt info tmp_data

#   Definir dominio de los datos para el perfil
#	-------------------------------------------------
    D=e         # Dominio exacto de los datos
#   D=a         # Dominio automatico (con valores redondeados ligeramente mayores)

#	Dibujar datos de columnas 3a y 4a (-i2,3)
	gmt plot tmp_data -JX$L/$H -R$D -W0.5,blue -i2,3  

#	Dibujar Eje X (Sn)
	gmt basemap -BSn -Bxaf+l"Distancia (km)"

#   Dibujar Eje Y (eW)
	gmt basemap -BwE -Byafg+l"Altura (m)"

#	Coordenadas Perfil (E, O)
	echo O | gmt text -F+cTL+f14p -Gwhite -W1
	echo E | gmt text -F+cTR+f14p -Gwhite -W1

#	Agregar Escala (grafica) Horizontal y Vertical (+v) -LjCB+w40+lkm+o0/0.5i
	gmt basemap -LjCB+w1000+lm+o1.2/0.67+v
	gmt basemap -LjCB+w200+lkm+o0/0.5

# 	Obtener informacion de la escala en la terminal y de la exageracion vertical.
	gmt basemap -B+n -Vi

#	Ver informacion de la exageracion vertical en la terminal y graficarla en el perfil	
	echo E.V.: 0.08 | gmt text -F+cBR+f10p -Gwhite -W1

#   ----------------------------------------------------------------------------------
#	Cerrar la sesion y mostrar archivo
gmt end

#	Borrar archivos temporales
#	-----------------------------------------------------------------------------------------------------------
	rm tmp_* gmt.*

# Ejercicios sugeridos
# 1. Modificar los puntos que definen el perfil.
# 2. Agregar mas puntos.