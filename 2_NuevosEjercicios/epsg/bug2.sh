gmt begin bug2 png
gmt set MAP_FRAME_PEN faint
#   OK
    gmt coast -Bafg2 -W1/faint     -JU-20/15c        -RAR.B+r6
    gmt coast -Bafg2 -W1/faint,red -JEPSG:32720/15c  --MAP_FRAME_PEN=red --MAP_GRID_PEN=green

#   WRONG. 
    gmt coast -Bafg2 -W1/faint      -JU-20/15c        -RAR.B+r7 -Xw+2c               # FAILED
    gmt coast -Bafg2 -W1/faint,red  -JEPSG:32720/15c  --MAP_FRAME_PEN=red --MAP_GRID_PEN=green
gmt end