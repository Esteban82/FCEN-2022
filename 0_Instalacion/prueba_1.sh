#!/usr/bin/env bash

# Proxy de la FCEN (direccion de proxy:numero de puerto).
# Descomentar si se esta en FCEN
export http_proxy="http://proxy.fcen.uba.ar:8080"

# Probar prueba_1: Asegurar que la instalación de GMT es correcta.
gmt begin prueba1 png
	gmt grdimage @earth_relief_20m -R-85/-20/-56/15 -JM15c -I+d
	gmt coast -W -N1 -B
gmt end show
