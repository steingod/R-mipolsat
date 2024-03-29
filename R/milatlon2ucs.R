#
# NAME:
# NA
#
# PURPOSE:
# NA
#
# REQUIREMENTS:
# NA
#
# INPUT:
# NA
#
# OUTPUT:
# NA
#
# NOTES:
# NA
#
# BUGS:
# NA
#
# AUTHOR:
# Ãystein GodÃ¸y, METNO/FOU, 2013-04-11 
#
# MODIFIED:
# NA
#
# CVS_ID:
# $Id: milatlon2ucs.R,v 1.3 2013-04-11 20:29:04 steingod Exp $

milatlon2ucs <- function(lat,lon) {
    
    rearth <- 6371.

    deg2rad <- pi/180.

    lattruerad <- 60.*deg2rad

    vr <- (90.+0)*deg2rad

    lat <- lat*deg2rad
    lon <- lon*deg2rad

    distpoleq <- rearth*(1.+sin(lattruerad))

    rr <- distpoleq*cos(lat)/(1.+sin(lat))
    xr <- rr*sin(lon)
    yr <- -rr*cos(lon)

    eastings <- xr*sin(vr)-yr*cos(vr)
    northings <- yr*sin(vr)+xr*cos(vr)

    return(data.frame(northings=northings,eastings=eastings))
}
