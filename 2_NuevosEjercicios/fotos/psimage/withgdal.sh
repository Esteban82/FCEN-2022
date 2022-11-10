#!/usr/bin/env bash
#
ps=withgdal.ps

gmt begin withgdal2 png

# RGB image. The +b2,1,0 also tests the bands request option
#gmt psimage @needle.jpg+b0,1,2 -Dx0/0+w7c -P -Y15c -K > $ps
gmt image @needle.jpg+b0,1,2 -Dx0/0+w7c -Y15c

# Same image as above but as idexed
gmt image @needle.png -Dx0/0+w7c -X7.5c

# Convert RGB to YIQ
gmt image @needle.jpg -M -Dx0/0+w7c -X-7.5c -Y-7c

# Convert Indexed to YIQ
gmt image @needle.png -M -Dx0/0+w7c -X7.5c

# A gray image (one band, no color map)
gmt image @vader.jpg -Dx0/0+w4c -X-2.5c -Y4.5c

gmt end #show

