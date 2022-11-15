# Definir proyeccion segun codigo EPSG
EPSG=4326       # WGS84, LONG LAT
#EPSG=3857      # Web Mercator projection 
#EPSG=32720      # UTM 20S, WGS84
echo $EPSG

gmt begin $EPSG png
    gmt basemap -RAR -Jepsg:$EPSG -Baf -V
    gmt coast -W -N1
gmt end #show

# Mas info:
# https://en.wikipedia.org/wiki/EPSG_Geodetic_Parameter_Dataset
# https://epsg.io/