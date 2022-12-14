#!/usr/bin/env bash

# Script original elaborado originlamente por Paul Wessel.
# Este script descarga datos de sismicidad del NEIC del USGS (US Geological Service)

#   Datos para los sismos
#StartTime=2021-01-01%2000:00:00
#EndTime=2021-12-31%2000:00:00

MAG="minmagnitude=5.5"  # Magnitud minima de los sismos
# Datos a modificar:
# Se pueden editar las fechas y magnitudes. 
SITE="https://earthquake.usgs.gov/fdsnws/event/1/query.csv"
TIME="starttime=2001-01-01%2000:00:00&endtime=2021-12-31%2000:00:00"
ORDER="orderby=time-asc"
ymin="minlatitude=-80"
ymax="maxlatitude=50"
xmin="minlongitude=-150"
xmax="maxlongitude=-10"
#xmin="minlongitude=-70"
#xmax="maxlongitude=-10"
# Se puede modificar??
URL="${SITE}?${TIME}&${MAG}&${ORDER}&${xmin}&${xmax}&${ymin}&${ymax}"
echo $URL > URL.txt
#URL="https://earthquake.usgs.gov/fdsnws/event/1/query.csv?starttime=2021-01-01%2000:00:00&endtime=2021-12-31%2000:00:00&minmagnitude=5&orderby=time-asc"
#echo $URL >> URL.txt

# Descargar los datos y reformatearlos.
#gmt convert ${URL} -i2,1,3,4,0 -hi1 > quakes.txt
gmt which ${URL} -G -Vq

gmt info query.csv -h1 -i2,1,4,0
#gmt info quakes.txt

gmt begin sismos png

gmt plot query.csv -Sc0.05c -W0.1 -Gred -Baf -Rd -fg -h -i2,1

gmt end 
# 2. Descargar Mecanismos focales y reformatearlos
#URL="https://www.ldeo.columbia.edu/~gcmt/projects/CMT/catalog/jan76_dec20.ndk"
#gmt which $URL -G
#gawk '/^PDE/ {Date=$2; Time=$3; Lat=$4; Long=$5; Depth=$6; getline; Name=$1; getline; getline; Exp=$1; getline; mant=$11; strike1=$12; dip1=$13; rake1=$14; strike2=$15; dip2=$16; rake2=$17; print Long, Lat, Depth, strike1, dip1, rake1, strike2, dip2, rake2, mant, Exp, Date "T" Time, Name}' jan76_dec20.ndk | sed 's/\//-/g' > meca.gmt
# gmt select meca.gmt -R-75.1/-63/-34.44/-30.35 > GCMT_1976-2017_meca.gmt
