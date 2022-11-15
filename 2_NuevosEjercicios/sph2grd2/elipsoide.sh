
# Radios Tierra. WGS84
A=6378137.0
B=6356752.3142

# Radios de Marte. https://spatialreference.org/ref/iau2000/49964/
A=3396190
B=3376200

# Copiar 
# Seems like a grdmath macro you create and stick in ~/.gmt/grdmath,macros, e.g.gm 

#ELLIPSOID = STO@b POP STO@a POP RCL@a 2 POW Y COSD MUL 2 POW RCL@b 2 POW Y SIND MUL 2 POW ADD RCL@a Y COSD MUL 2 POW RCL@b Y SIND MUL 2 POW ADD DIV SQRT

#gmt grdmath -Rg -I1 6378137.0 6356752.3142 ELLIPSOID = my.grd
#gmt grdimage my.grd -JW15c -png elipsoide
gmt grdmath -Rg -I1 $A $B ELLIPSOID = my.grd
#gmt grdimage my.grd -JW15c -png elipsoide2

gmt begin Marte png
    gmt grdimage my.grd -JW15c
    gmt colorbar
    gmt basemap -Baf
gmt end 
