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
Start=2023-01-01
Start=1950-01-01
End=2023-12-31

# Magnitud minima de los sismos
MAG="minmagnitude=2.5"  

# NO modificar
SITE="https://earthquake.usgs.gov/fdsnws/event/1/query.csv"
#TIME="starttime=$Start&endtime=$End"
TIME="starttime=$Start%2000:00:00&endtime=$End%2000:00:00"
ORDER="orderby=time-asc"


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
curl -s $URL > query.csv  # Funciona si se excede el maximo de datos
#gmt convert $URL -h1 -i2,1,4,0 > query_convert.txt -Qe
#gmt info query.csv -h1 -i2,1,4,0


gmt begin sismos png

# Dibujar frame 
    gmt basemap -R$REGION -Baf -JW15c

# Warming message if N > 20001 (only 20000 can be download, +1 due to the header)
if (( $(wc --lines < query.csv) > 20001 )); then
    grep "Error" query.csv -A2
	else
		echo "NO ERROR"
	fi
# grep "Error" query_curl.txt -A2


# Mapa
    gmt plot query.csv -Sc0.3c -W0.1 -Gred -fg -h -i2,1

gmt end