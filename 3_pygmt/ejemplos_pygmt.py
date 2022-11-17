# -*- coding: utf-8 -*-
"""
Created on Tue Nov 15 14:25:17 2022

@author: sebap
"""

#%%


import pygmt
import rioxarray as rxr
import geopandas as gpd


#%%

ruta_dem=r'C:\Users\usuario\Downloads\MarsHRSCMOLA_MAP2_SIMP_lat_lon.tif'
ruta_shp=r"C:\Users\usuario\Downloads\poligono_ubicacion.shp"

#%%

dem=rxr.open_rasterio(ruta_dem,masked=True).squeeze()

shp=gpd.read_file(ruta_shp)

#%%

fig = pygmt.Figure()

pygmt.makecpt(
    cmap='roma',
    series=[int(dem.min()),int(dem.max()),1],
    continuous=True,
    reverse=True
    )


fig.grdimage(
    grid=dem,
    projection='M12c',
    shading='+a0+nt1',
    dpi=300,
    frame=True,
    cmap=True,
    nan_transparent=True
    )

fig.colorbar(frame=["x+lElevacion [m]"])

fig.grdcontour(
    interval=100,
    grid=dem,
    transparency="40",
    pen="0.1p"
    )

fig.plot(data= shp,
         pen="1p,black"
         )

fig.basemap(
    frame=True,
    map_scale="n0.8/0.1+w200k+f+l",
    rose=["n0.85/0.9+w1.5c+f"],
    )

    
fig.savefig("mars_v2.png", crop=True, dpi=300)  
fig.show()


#%%

# fig = pygmt.Figure()


# pygmt.makecpt(
#     cmap='roma',
#     series=[int(grid.min()),int(grid.max()),1],
#     continuous=True,
#     reverse=True
#     )


# fig.grdview(grid=grid,
#             surftype='i',
#             projection='M12c',
#             perspective=[150,45],
#             zsize='2c',
#             plane="0+ggrey",
#             frame=['xa','yaf','z1000+lmeters','wSEnZ'],shading='+a50+nt1')

# fig.colorbar(perspective=True,frame=['x+lElevacion','y+lm'])

# fig.savefig("mars_3d.png", crop=True, dpi=300)  

# fig.show()
