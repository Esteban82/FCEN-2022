PROJ=EPSG:3857
#EPSG_32723
#PROJ=EPSG:49964
#PROJ=EPSG:49910

gmt begin mapa png
    gmt set PROJ_ELLIPSOID mars

   # gmt basemap 
    gmt coast -R-180/180/-80/80 -J$PROJ -Baf -W1p

gmt end #show