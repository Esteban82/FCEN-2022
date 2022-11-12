# Definir proyeccion segun codigo EPSG
EPSG=4326       # WGS84, LONG LAT
EPSG=32720      # UTM 20S, WGS84
gmt begin bug png
#    gmt basemap -Bafg -JU-20/15c        -R-72/-60/-85/-20
#    gmt basemap -Bafg -JEPSG:$EPSG/15c  --MAP_GRID_PEN=red

    gmt basemap -Bafg -JU-20/15c        -RAR+r1    -Xw
    gmt basemap -Bafg -JEPSG:$EPSG/15c  --MAP_GRID_PEN=red
gmt end
