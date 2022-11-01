#!/usr/bin/env bash

#	Region geografica del mapa (W/E/S/N)
	REGION="-79/-20/-63/-20"

#	Crear arregle	
#	IFS='/'; R=( $REGION )
#	echo "value = ${R[0]}"
#	echo "value = ${R[1]}"
#	echo "value = ${R[2]}"
#	echo "value = ${R[3]}"
#	echo -e '\a'

# Ver TR para convertir el / a un separador estandar de ITF^
 
 R=(echo "-79/-20/-63/-20" | tr '/' '\t')
 echo $REGION |tr '/' ' ' 		# Convertir / a espacios en blanco.
 echo $REGION | tr '/' '\t'		# Convertir / a tabulaciones.
	#IFS='/'; R=( $REGION )
	echo "value = ${R[0]}"
	echo "value = ${R[1]}"
	echo "value = ${R[2]}"
	echo "value = ${R[3]}"
	echo -e '\a'
