# Definir proyeccion segun codigo EPSG
EPSG=4326       # WGS84, LONG LAT
#EPSG=3857      # Web Mercator projection 
#EPSG_32723
EPSG=32720      # UTM 20S, WGS84
#EPSG=53004      # Mercator
#PROJ=M
#PROJ=EPSG:49964
#PROJ=EPSG:49910

gmt begin $EPSG png
    #gmt set PROJ_ELLIPSOID mars
    gmt basemap -RAR -JEPSG:$EPSG/15c -Baf
    gmt basemap -RAR -JU-20/15c -Baf
    #gmt coast -RAR -JEPSG:$EPSG/15c -Baf -W1.0p,red    -N1/1.0p,red
    #gmt coast -RAR -J$PROJ/15c      -Baf -W0.1p,yellow -N1/0.2p,blue #-Xw

gmt end #show

# Mas info:
# https://en.wikipedia.org/wiki/EPSG_Geodetic_Parameter_Dataset
# https://epsg.io/