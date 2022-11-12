# Definir proyeccion segun codigo EPSG
EPSG=4326       # WGS84, LONG LAT
EPSG=32720      # UTM 20S, WGS84


gmt begin $EPSG png
    gmt basemap -RAR -JEPSG:$EPSG/15c -Bafg
    gmt basemap -RAR -JU-20/15c -Bafg
gmt end
