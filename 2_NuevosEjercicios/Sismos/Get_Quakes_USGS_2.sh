#!/usr/bin/env bash

# Script original elaborado originalmente por Paul Wessel. Modificado por F. Esteban. 
# Este script descarga datos de sismicidad del NEIC del USGS (US Geological Service).
# Permite definir una region geografica y un intervalo de tiempo
# IMPORTANTE: Se pueden descargar hasta 20 mil eventos. 

# 1. Parameters to modify: 
# ------------------------------------------------------------
# 1A. Geographic Region. Define E/W/S/N or isocodes.
#REGION=TR,SY+r10
REGION=-70/-50/-70/-50
# 1B. Dates. (Format: yyyy-mm-dd)
Start=2023-01-01
#Start=1950-01-01
End=2023-12-31

# 1C. Minimum Magnitude
MinMag=2.5

# DO NOT MODIFY
# ------------------------------------------------------------
# 2. Create URL to download the data from the USGS.
# 2A. Default values
SITE="https://earthquake.usgs.gov/fdsnws/event/1/query.csv"
TIME="starttime=$Start&endtime=$End"
MAG="minmagnitude=$MinMag"
ORDER="orderby=time-asc"
#  2B. Get geographic region
R=( $(echo $(gmt mapproject -WR -R$REGION) | sed 's/-R//' | tr '/' '\t')) # Convert REGION in a array
ymin="minlatitude=${R[2]}"
ymax="maxlatitude=${R[3]}"
xmin="minlongitude=${R[0]}"
xmax="maxlongitude=${R[1]}"
# 2C. Create URL
URL="${SITE}?${TIME}&${MAG}&${ORDER}&${xmin}&${xmax}&${ymin}&${ymax}"

# 3. Download the data and save it as query.csv
curl -s $URL > query.csv

# 4. Search if there was any "Bad Request" in the query.
grep "Bad Request" query.csv -A2

# 5. Delete unnecesary files
rm gmt.history