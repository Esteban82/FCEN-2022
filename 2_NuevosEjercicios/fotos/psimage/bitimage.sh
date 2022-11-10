#!/usr/bin/env bash
#

gmt begin bitimage2 png

# Raw, plus just change fore or background
    gmt image @vader1.png -Dx0/0+w2i     -F+pfaint
    gmt image @vader1.png -Dx2.25i/0+w2i -F+pfaint -Gred+b
    gmt image @vader1.png -Dx4.5i/0+w2i  -F+pfaint -Gred+f

# Change both,then set transparent back or foreground
# The middle will show all white in PS but white and transparent in PNG
    gmt image @vader1.png -Dx0i/2i+w2i    -F+pfaint -Gred+f -Gyellow+b
    gmt image @vader1.png -Dx2.25i/2i+w2i -F+pfaint -G+b
    gmt image @vader1.png -Dx4.5i/2i+w2i  -F+pfaint -G+f

# Finally, mix transparency and change of color
    gmt image @vader1.png -Dx0i/4i+w2i    -F+pfaint -G+f      -Gyellow+b
    gmt image @vader1.png -Dx2.25i/4i+w2i -F+pfaint -G+b      -Gred+f
    gmt image @vader1.png -Dx4.5i/4i+w2i  -F+pfaint -Gwhite+b -Gblack+f
gmt end #show

