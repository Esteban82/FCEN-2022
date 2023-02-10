#!/usr/bin/env bash

# Script original elaborado originlamente por Paul Wessel. Modificado por F. Esteban. 
# Este script descarga datos de sismicidad del NEIC del USGS (US Geological Service).
# Permite definir una region geografica y un intervalo de tiempo
# IMPORTANTE: Se pueden descargar hasta 20 mil eventos. 

#REGION
REGION=AR,BO+r3
REGION=IT+r3
REGION=TR,SY+r10


# Datos para los sismos
## Datos a modificar:
# Fechas
Start=1950-01-01%2000:00:00
End=2023-12-31%2000:00:00

# Magnitud minima de los sismos
MAG="minmagnitude=2.5"  

# NO modificar
SITE="https://earthquake.usgs.gov/fdsnws/event/1/query.csv"
TIME="starttime=$Start&endtime=$End"
ORDER="orderby=time-asc"

gmt begin sismos png

# Dibujar frame 
    gmt basemap -R$REGION -Baf -JW15c

#   Obterner region geografica
    REGION=$(gmt mapproject -WR)

# Convertir region en array
    R=( $(echo $REGION | sed 's/-R//' | tr '/' '\t'))

# Region Geografica
    ymin="minlatitude=${R[2]}"
    ymax="maxlatitude=${R[3]}"
    xmin="minlongitude=${R[0]}"
    xmax="maxlongitude=${R[1]}"

# Crear URL
URL="${SITE}?${TIME}&${MAG}&${ORDER}&${xmin}&${xmax}&${ymin}&${ymax}"
#URL="${SITE}?${TIME}&${MAG}&${ORDER}&minlongitude=${R[0]}&maxlongitude=${R[1]}&minlatitude=${R[2]}&maxlatitude=${R[3]}"
#echo $URL

# Descargar los datos y ver informacion
#gmt which ${URL} -G -Ve
curl -s $URL > query_curl.txt  # Funciona si se excede el maximo de datos
#gmt convert $URL -h1 -i2,1,4,0 > query_convert.txt -Qe
#gmt info query.csv -h1 -i2,1,4,0

# Warming message if N > 20001 (only 20000 can be download, +1 due to the header)
if (( $(wc --lines < query.csv) > 20001 )); then
		echo "The query.csv has $N events (which is the limit of records that can be download from the USGS). ."
#	else
#		echo "NO ERROR"
	fi
#


gmt plot query.csv -Sc0.3c -W0.1 -Gred -fg -h -i2,1

gmt end 

#rm query.csv
# 2. Descargar Mecanismos focales y reformatearlos
#URL="https://www.ldeo.columbia.edu/~gcmt/projects/CMT/catalog/jan76_dec20.ndk"
#gmt which $URL -G
#gawk '/^PDE/ {Date=$2; Time=$3; Lat=$4; Long=$5; Depth=$6; getline; Name=$1; getline; getline; Exp=$1; getline; mant=$11; strike1=$12; dip1=$13; rake1=$14; strike2=$15; dip2=$16; rake2=$17; print Long, Lat, Depth, strike1, dip1, rake1, strike2, dip2, rake2, mant, Exp, Date "T" Time, Name}' jan76_dec20.ndk | sed 's/\//-/g' > meca.gmt
# gmt select meca.gmt -R-75.1/-63/-34.44/-30.35 > GCMT_1976-2017_meca.gmt
