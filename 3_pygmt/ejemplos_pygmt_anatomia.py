# -*- coding: utf-8 -*-
"""
Created on Wed Nov 16 16:18:03 2022

@author: usuario
"""


import pygmt #Importo la libreria 


data = pygmt.datasets.load_sample_data(name="japan_quakes")
region = [125, 155, 30, 55] #Determino la región, en este caso como ejemplo, Japón

fig = pygmt.Figure() #creo la figura

fig.coast(
    region=region,
    # land="lightgreen", 
    # water="lightblue",
    shorelines=True,
    frame=True,
)
# pygmt.makecpt(cmap="plasma", series=[data.depth_km.min(), data.depth_km.max()])
# fig.plot(x=data.longitude, y=data.latitude, style="c0.3c", color=data.depth_km, cmap=True)
# fig.basemap(
#     frame=True,
#     map_scale="n0.8/0.1+w500k+f+l",
#     rose=["n0.85/0.9+w1c+f"],
#     )

fig.show()