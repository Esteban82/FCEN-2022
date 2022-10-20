#!/usr/bin/env bash
#		GMT EXAMPLE 28
#
# Purpose:	Illustrates how to mix UTM data and UTM gmt projection
# GMT modules:	makecpt, grdimage, coast, text, basemap
#

IMG=Malvinas_UTM.tif

gmt begin Imagen_UTM png
	gmt grdimage $IMG -Jx1:2000000 --FONT_ANNOT_PRIMARY=9p 
#	gmt mapproject -W
#	gmt grdimage $IMG -JX14.1/8.825c --FONT_ANNOT_PRIMARY=9p 
#	gmt mapproject -W

	# Overlay geographic data and coregister by using correct region and gmt projection with the same scale
	gmt coast -R$IMG -Ju-21/1:2000000 -Df+ -Slightblue -W0.5p -Byafg -Bxafg -BNE \
		--FONT_ANNOT_PRIMARY=12p --FORMAT_GEO_MAP=ddd:mmF
#	echo 155:16:20W 19:26:20N KILAUEA | gmt text -F+f12p,Helvetica-Bold+jCB
#	gmt basemap --FONT_ANNOT_PRIMARY=9p -LjRB+c19:23N+f+w5k+l1:160,000+u+o0.5c --FONT_LABEL=10p
	# Annotate in km but append ,000m to annotations to get customized meter labels
	gmt basemap -R$IMG+Uk -Jx1:2000 -Bg+u"@:8:000m@::" -BWSne --FONT_ANNOT_PRIMARY=10p \
		--MAP_GRID_CROSS_SIZE_PRIMARY=0.25c --FONT_LABEL=10p
gmt end #show
