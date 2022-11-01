#!/usr/bin/env bash

#	Region geografica del mapa (W/E/S/N)
	REGION="-79/-20/-63/-20"

#	Convertir $REGION in un array (vector)
#	Usar tr para convertir / a tabulaciones (valor de Internal Field Separator (IFS))
 R=( $(echo $REGION | tr '/' '\t'))
 #echo $R
 #echo $REGION |tr '/' ' ' 		# Convertir / a espacios en blanco.
 #echo $REGION | tr '/' '\t'		# Convertir / a tabulaciones.

#	Comprobar la conversion
	echo "W = ${R[0]}"
	echo "E = ${R[1]}"
	echo "S = ${R[2]}"
	echo "N = ${R[3]}"
	#echo -e '\a'
