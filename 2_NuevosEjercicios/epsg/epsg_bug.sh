# Definir proyeccion segun codigo EPSG
EPSG=4326       # WGS84, LONG LAT
EPSG=32720      # UTM 20S, WGS84
gmt begin bug png

    gmt basemap -Bafg -JU-20/15c        -RAR+r2    -Xw+1c -Vi
#   #gmt basemap -Bafg -JU-20/15c        -R286/308/-56/-20 -Xw+1c
    #gmt basemap -Bafg -JU-20/15c        -R-74/-52/-56/-20 -Xw+1c
    gmt basemap -Bafg -JEPSG:$EPSG/15c  --MAP_GRID_PEN=red

    #gmt basemap -Bafg -JU-20/15c        -R286/308/-56/-20 -Xw+1c
    gmt basemap -Bafg -JU-20/15c        -R-74/-52/-56/-20 -Xw+1c

    #gmt basemap -Bafg -JU-20/15c        -R286/308/-56/-20 -Xw+1c
    #gmt basemap -Bafg -JU-20/15c        -R-80/-50/-60/-20
    gmt basemap -Bafg -JEPSG:$EPSG/15c  --MAP_GRID_PEN=red
    
    

gmt end
