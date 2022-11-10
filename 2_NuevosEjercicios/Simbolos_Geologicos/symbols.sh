#!/usr/bin/env bash
# Examples of symbols with different filling and outline pens

# Ver carpeta del usuario
userdir=$(gmt --show-userdir)
echo $userdir/cache

# Copiar arhivos .def a carpeta del usuario
#cp geology/*.def $userdir/cache

gmt begin symbols png
	echo 0 0 | gmt plot -R-1/6/-1/6 -JX15/15 -BWSen+t"Símbolos" -Ba+e -Ggreen -Sc0.75c
	echo 1 0 | gmt plot -Ggreen -W1,black -Sc0.75c
	echo 2 0 | gmt plot -Ggreen -W1,0/130/0 -Sc0.75c
	echo 3 0 | gmt plot -Ggreen -W1,black,dashed -Sc0.75c
	echo 4 0 | gmt plot -Ggreen -W1,black,-. -Sc0.75c
	echo 5 0 | gmt plot -G- -W1,0/130/0 -Sc0.75c
	echo 0 1 | gmt plot -Gred -W1,black -Sa0.75c
	echo 1 1 | gmt plot -Gred -W1,black,dashed -Sc0.75c
	echo 2 1 | gmt plot -Gred -Sd0.75c
	echo 3 1 | gmt plot -Gred -W0.5,black -Sh0.75c
	echo 4 1 | gmt plot -W2,red -S+0.75c
	echo 5 1 | gmt plot -Gred -Ss0.75c
	echo 0 3 | gmt plot -Gbrown -W1 -Skflash/1.5c
	echo 1 3 | gmt plot -Gblue -W1 -Skhurricane/1.5c
	echo 2 3 | gmt plot -Ggray -W1 -Skpacman/1.5c
	echo 3 3 | gmt plot -Gbrown -W1 -Skstar3/1.5c
	echo 4 3 | gmt plot -Gyellow -W1 -Sksun/1.5c
	echo 5 3 | gmt plot -Gred -W1 -Skvolcano/1.5c
	echo 0 5 | gmt plot -Sk@gallo/3c
	echo 2 5 | gmt plot -Sk@sardinha/3c

	# Simbolos geologicos*
	# Solo ubicacion
	echo 3 5 | gmt plot -Skgeo-lineation_vert/3c -Gred

	# Con 1 parametro (linemiento horizontal de azimuth 45º)
	echo 4 5 85 | gmt plot -Skgeo-lineation_hor/2c -Gblack

	# Con 2 parametros (azimut 45º e inclinacion 30º)
	echo 5 5 45 30| gmt plot -Skgeo-foliation-2/2c -Gblack
gmt end #show

# *Links con mas informacion
# Otros simbolos customs
# https://docs.generic-mapping-tools.org/dev/cookbook/custom-symbols.html#custom-symbols

# Simbolos estructurales
# https://docs.generic-mapping-tools.org/dev/users-contrib-symbols/geology/Geology.html
# https://docs.generic-mapping-tools.org/dev/users-contrib-symbols.html#structural-geology-symbols