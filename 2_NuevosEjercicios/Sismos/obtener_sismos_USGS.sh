#!/usr/bin/env bash
# Script original elaborado originlamente por Paul Wessel.
# Este script descarga datos de sismicidad del NEIC del USGS (US Geological Service)

# Datos a modificar:
# Se pueden editar las fechas y magnitudes. 
SITE="https://earthquake.usgs.gov/fdsnws/event/1/query.csv"
TIME="starttime=2021-01-01%2000:00:00&endtime=2021-12-31%2000:00:00"
#TiempoInicial=2021-01-01%2000:00:00
#TiempoFinal=2021-12-31%2000:00:00
#Region=

MAG="minmagnitude=5"
#Magnitud minima=
ORDER="orderby=time-asc"
# Se puede modificar??
URL="${SITE}?${TIME}&${MAG}&${ORDER}"

# Descargar los datos y reformatearlos.
#curl ${URL} > test.txt
gmt convert ${URL} -i2,1,3,4,0 -hi1 > quakes.txt
#gmt which ${URL} -G
#gmt which @usgs_quakes_22.txt -G
wc quakes.txt

gmt plot quakes.txt -Sc0.1c -W0.1 -Gred -Baf -Ra -png sismos -fg 

URL="https://www.ldeo.columbia.edu/~gcmt/projects/CMT/catalog/jan76_dec17.ndk"
gmt which $URL -G
