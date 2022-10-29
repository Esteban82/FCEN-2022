#!/usr/bin/env bash

# Script original elaborado originlamente por Paul Wessel.
# Este script descarga datos de sismicidad del NEIC del USGS (US Geological Service)

#	Region geografica del mapa (W/E/S/N)
#	REGION=-79/-20/-63/-20
    W=-79
    E=-20
    S=-63
    N=-20

#   Datos para los sismos
MinMag=4.5      # Magnitud minima de los sismos
# Fechas (año-mes-dia)
Inicio=1901-01-01
Fin=2022-10-31

# Crear URL
SITE="https://earthquake.usgs.gov/fdsnws/event/1/query.csv"
TIME="starttime=$Inicio%2000:00:00&endtime=$Fin%2000:00:00"
REGION="minlongitude=$W&maxlongitude=$E&minlatitude=$S&maxlatitude=$N"
URL="${SITE}?${TIME}&minmagnitude=$MinMag&"orderby=time-asc"&$REGION"

# Descargar los datos y reformatearlos.
gmt convert ${URL} -i2,1,3,4,0 -hi1 > quakes.txt

#wc quakes.txt
# Ver informacion de los datos
gmt info quakes.txt
#gmt begin USGS png
#gmt plot quakes.txt -Sc0.05c -W0.1 -Gred -Baf -Rd -fg
#gmt end 

# 2. Descargar Mecanismos focales y reformatearlos
#URL="https://www.ldeo.columbia.edu/~gcmt/projects/CMT/catalog/jan76_dec20.ndk"
#gmt which $URL -G
#gawk '/^PDE/ {Date=$2; Time=$3; Lat=$4; Long=$5; Depth=$6; getline; Name=$1; getline; getline; Exp=$1; getline; mant=$11; strike1=$12; dip1=$13; rake1=$14; strike2=$15; dip2=$16; rake2=$17; print Long, Lat, Depth, strike1, dip1, rake1, strike2, dip2, rake2, mant, Exp, Date "T" Time, Name}' jan76_dec20.ndk | sed 's/\//-/g' > meca.gmt
# gmt select meca.gmt -R-75.1/-63/-34.44/-30.35 > GCMT_1976-2017_meca.gmt
