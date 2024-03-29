#
# NAME:
# readAVHRR
#
# PURPOSE:
# To read AVHRR imagery stored in standard AVHRR files at the Norwegian
# Meteorological Institute.
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
# Øystein Godøy, METNO/FOU
#
# MODIFIED:
# Øystein Godøy, METNO/FOU, 2013-04-11 
#
# CVS_ID:
# $Id: readAVHRR.R,v 1.3 2013-04-11 20:29:04 steingod Exp $
#
#
readAVHRR <- function(filename,nomiss=TRUE) {

    if (missing(filename)) {
	cat("Filename is missing!\n")
	return;
    }
    
    description <- character(length=1)
    satellite <- character(length=1)
    areaname <- character(length=1)
    projection <- character(length=1)
    year <- integer(length=1)
    month <- integer(length=1)
    day <- integer(length=1)
    hour <- integer(length=1)
    minute <- integer(length=1)
    xsize <- integer(length=1)
    ysize <- integer(length=1)
    zsize <- integer(length=1)
    channelid <- vector(mode="numeric",length=6)
    ucs_ul_x <- double(length=1)
    ucs_ul_y <- double(length=1)
    ucs_dx <- double(length=1)
    ucs_dy <- double(length=1)
    
    header <- .C("readAVHRRheader",
	filename=as.character(filename),description=as.character(description),
	satellite=as.character(satellite),areaname=as.character(areaname),
	year=as.integer(year),month=as.integer(month),day=as.integer(day),
	hour=as.integer(hour),minute=as.integer(minute),
	xsize=as.integer(xsize),ysize=as.integer(ysize),
	zsize=as.integer(zsize),channelid=as.integer(channelid),
	ucs_ul_x=as.double(ucs_ul_x),ucs_ul_y=as.double(ucs_ul_y),
	ucs_dx=as.double(ucs_dx),ucs_dy=as.double(ucs_dy),
	package="mipolsat")

    size <- header$xsize*header$ysize
    #mydata <- vector(mode="numeric",length=size)
    mydata <- array(0,dim=c(size,header$zsize))
    
    tmp <- .C("readAVHRRdata",
	filename=as.character(filename),
	data=mydata,package="mipolsat")
    if (nomiss) {
	tmp$data[tmp$data < -50] <- NA
    }

    return(list(header=header,data=tmp$data))
}
