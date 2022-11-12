
# Funciona
#coast -Rd -W0.5 -Bg -J”+proj=bertin1953+R=1.0000000+width=10c” -png
gmt coast -W -Rd -J"+proj=longlat +ellps=WGS84 +datum=WGS84+no_defs" -png mapa


#Cannot find coordinate operations from `GEOGCRS["unknown",DATUM["World Geodetic System 1984",ELLIPSOID["WGS 84",6378137,298.257223563,LENGTHUNIT["metre",1]],ID["EPSG",6326]],PRIMEM["Greenwich",0,ANGLEUNIT["degree",0.0174532925199433],ID["EPSG",8901]],CS[ellipsoidal,2],AXIS["longitude",east,ORDER[1],ANGLEUNIT["degree",0.0174532925199433,ID["EPSG",9122]]],AXIS["latitude",north,ORDER[2],ANGLEUNIT["degree",0.0174532925199433,ID["EPSG",9122]]]]' to `+proj=bertin1953 +R=1 +units=m +no_defs +type=crs'
#coast [ERROR]: Failed to create coordinate transformation between the following
#coordinate systems. This may be because they are not transformable,
#or because projection services (PROJ.4 DLL/.so) could not be loaded.
#coast [ERROR]: Source:

GEOGCS["unknown",
    DATUM["WGS_1984",
        SPHEROID["WGS 84",6378137,298.257223563,
            AUTHORITY["EPSG","7030"]],
        AUTHORITY["EPSG","6326"]],
    PRIMEM["Greenwich",0,
        AUTHORITY["EPSG","8901"]],
    UNIT["degree",0.0174532925199433,
        AUTHORITY["EPSG","9122"]],
    AXIS["Longitude",EAST],
    AXIS["Latitude",NORTH]]

PROJCS["unknown",
    GEOGCS["unknown",
        DATUM["unknown",
            SPHEROID["unknown",1,0]],
        PRIMEM["Reference meridian",0],
        UNIT["degree",0.0174532925199433,
            AUTHORITY["EPSG","9122"]]],
    PROJECTION["custom_proj4"],
    UNIT["metre",1,
        AUTHORITY["EPSG","9001"]],
    AXIS["Easting",EAST],
    AXIS["Northing",NORTH],
    EXTENSION["PROJ4","+proj=bertin1953 +R=1 +wktext +no_defs"]]

#ERROR 1: PROJ: proj_create_operations: Source and target ellipsoid do not belong to the same celestial body
