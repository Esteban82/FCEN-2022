#!/usr/bin/env bash

# Script original elaborado originalmente por Paul Wessel. Modificado por F. Esteban. 
# Este script descarga datos de sismicidad del NEIC del USGS (US Geological Service).
# Permite definir una region geografica y un intervalo de tiempo
# IMPORTANTE: Se pueden descargar hasta 20 mil eventos. 

# 1. Parameters to modify: 

# 1A. Geographic Region. 
REGION=AR,BO+r3
REGION=IT+r3
REGION=TR,SY+r10
#REGION=-70/-50/-70/-50

# 1B. Dates (yyyy-mm-dd)
Start=2023-01-01
#Start=1950-01-01
End=2023-12-31

# 1C. Magnitud minima de los sismos
MinMag=2.5

# 2. Create URL to download the data from the USGS.
# NO modificar
SITE="https://earthquake.usgs.gov/fdsnws/event/1/query.csv"
TIME="starttime=$Start%2000:00:00&endtime=$End%2000:00:00"
TIME="starttime=$Start&endtime=$End"
MAG="minmagnitude=$MinMag"
ORDER="orderby=time-asc"

#  2A. Obterner region geografica
# Convertir region en array
R=( $(echo $(gmt mapproject -WR -R$REGION) | sed 's/-R//' | tr '/' '\t'))

# Asignar cada valor
ymin="minlatitude=${R[2]}"
ymax="maxlatitude=${R[3]}"
xmin="minlongitude=${R[0]}"
xmax="maxlongitude=${R[1]}"

# Crear URL
URL="${SITE}?${TIME}&${MAG}&${ORDER}&${xmin}&${xmax}&${ymin}&${ymax}"

# 3. Download the data and check it
# Descargar los datos y ver informacion
curl -s $URL > query.csv  # Funciona si se excede el maximo de datos

# Search if there was any "Bad Request" in the query
grep "Bad Request" query.csv -A2


