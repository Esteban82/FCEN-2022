#!/usr/bin/env bash

#	Convertir string de region a valores
#	------------------------------------
#	1. Formato W/E/S/N
#	Region geografica del mapa (W/E/S/N)
	REGION="-79/-20/-63/-20"

#	Convertir $REGION in un array (vector)
#	Usar tr para convertir / a tabulaciones (valor de Internal Field Separator (IFS))
	R=( $(echo $REGION | tr '/' '\t'))

# -----------------------------------------
#	2. Formato -RW/E/S/N
#	Region geografica del mapa (W/E/S/N)
	REGION="-R-79/-20/-63/-20"

#	Convertir $REGION in un array (vector)
#	Usar tr para convertir / a tabulaciones (valor de Internal Field Separator (IFS))
 	R=( $(echo $REGION | sed 's/-R//' | tr '/' '\t'))


#	3. comprobar la conversion
	echo "W = ${R[0]}"
	echo "E = ${R[1]}"
	echo "S = ${R[2]}"
	echo "N = ${R[3]}"
	#echo -e '\a'
