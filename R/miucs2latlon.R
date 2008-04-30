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
# NA
#
# MODIFIED:
# NA
#
# CVS_ID:
# $Id: miucs2latlon.R,v 1.2 2008-04-30 19:37:33 steingod Exp $

miucs2latlon <- function(northings,eastings) {

    rearth <- 6371.

    deg2rad <- pi/180.

    lattruerad <- 60.*deg2rad
    distpoleq <- rearth*(1.+sin(lattruerad))

    rp <- ((eastings^2)+(northings^2))^0.5

    lat <- 90.-(1./deg2rad)*atan(rp/distpoleq)*2
    lon <- 0+(1./deg2rad)*atan2(eastings,-northings)

    return(data.frame(lat=lat,lon=lon))
}
