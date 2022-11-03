#!/usr/bin/env bash

#	Temas a ver:
#	1. Clasificar grillas.
#	2. Combinar grillas.

#	Definir variables del mapa
#	-----------------------------------------------------------------------------------------------------------
#	Titulo del mapa
	title=42_Pendiente_Aspecto
	echo $title

#	Proyeccion y Region
	PROJ=M15c
	REGION=-72/-64/-35/-30
#	REGION=-68.5/-67.5/-32/-31

	
#	Grilla	
	DEM=@earth_relief_30s_p

#	CPT creadas ad-hoc
#	CPT=Aspect-Slope_Brewer
	CPT=Aspect-Slope_Esteban

# 	Nombre archivo de salida
	CUT=tmp_$title.nc
	CUT2=tmp_$title-2.nc

#	Dibujar mapa
#	-----------------------------------------------------------------------------------------------------------
#	Iniciar sesion y tipo de figura
gmt begin $title png
	
#	Setear la region y proyeccion
	gmt basemap -R$REGION -J$PROJ -B+n

#	Calcular Grillas con modulo del pendiente (-D -S) y aspecto (-Da)
	gmt grdgradient $DEM -R$REGION -fg -D  -S$CUT
	gmt grdgradient $DEM -R$REGION -fg -Da -G$CUT2

#	Convertir modulo del gradiente a inclinacion (pendiente) en grados (ATAND).
	gmt grdmath $CUT ATAND = $CUT

#	Reclasificar grilla de pendiente en 4 clases.
# 	Pendiente muy baja (menor a A), baja (entre A y B), moderada (entre B y C) y alta (mayor a C).
	A=3 ; B=12 ; C=22	# Valores originales definidos por Bewer (1993)	
#	A=1 ; B=10 ; C=20
#	A=1 ; B=05 ; C=10
	gmt grdclip $CUT -G$CUT -Sb$A/10 -Si$A/$B/20 -Si$B/$C/30 -Sa$C/40

#	Reclasificar grilla de Aspecto en 8 clases 
#	En rangos de 45º en cada direccion (N, NE, E, SE, S, SO, O, NO)
	gmt grdclip $CUT2 -G$CUT2 -Sb22.5/1 -Si22.5/67.5/2 -Si67.5/112.5/3 -Si112.5/157.5/4 -Si157.5/202.5/5 \
	-Si202.5/247.5/6 -Si247.5/292.5/7 -Si292.5/337.5/8 -Sa337.5/1

#	-------------------------------------------------------------------------------
#	Sumar Grillas
	gmt grdmath $CUT $CUT2 ADD = $CUT

#	Crear Imagen
	gmt grdimage $CUT -C$CPT.cpt

#	-----------------------------------------------------------------------------------------------------------
#	Dibujar frame
	gmt basemap -Bxaf -Byaf 

#	Pintar areas húmedas: Oceanos (-S) y Lagos (-Cl/)f
	gmt coast -Sdodgerblue2

#	Dibujar Linea de Costa (W1), de paises (N1) y provincias/regiones (N2)
	gmt coast -W1/thinner
	gmt coast -N1/thin -N2/dashed

#	Escala de colores
#	gmt colorbar -DJRM+w11c+o0.5/0c -C -L0.1
	gmt image $CPT.png -DjBRM+w3c+o0.2/0.2c -F+p+gwhite

#	-----------------------------------------------------------------------------------------------------------
#	Cerrar el archivo de salida (ps)
	gmt end

	rm tmp_*

#	Ejercicios sugeridos
#	1. Probar otras combinaciones para reclasificar las pendientes (lineas 47 a 49).
#	2. Definir nuevos valores para reclasificar las pendientes.