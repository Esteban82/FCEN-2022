#!/usr/bin/env bash

#	Region geografica del mapa (W/E/S/N)
	REGION="-79/-20/-63/-20"

#	Crear arregle	
	IFS='/'; R=( $REGION )
	echo "value = ${R[0]}"
	echo "value = ${R[1]}"
	echo "value = ${R[2]}"
	echo "value = ${R[3]}"
	echo -e '\a'