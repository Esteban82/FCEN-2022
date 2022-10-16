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
ORDER="orderby=time-asc" # Se puede modificar??
URL="${SITE}?${TIME}&${MAG}&${ORDER}"

# Descargar los datos y reformatearlos.
# We get the data via the URL and reformat using gmt convert.  Here we use the
# -i option to shuffle the columns, plus scaling the magnitude (col 4) by 50 to
# yield a fake symbol size in km
gmt convert ${URL} -i2,1,3,4+s50,0 -hi1 > quakes.txt
