#
# NAME:
# createAVHRRimage
#
# PURPOSE:
# To create an image on the graphical device provided and overlay map.
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
# Øystein Godøy, METNO/FOU, 10.09.2007: Added palette dependency on
# channel selection.
#
# CVS_ID:
# $Id: createAVHRRimage.R,v 1.4 2013-04-11 20:29:04 steingod Exp $
#
#
createAVHRRimage <- function(dataset, channel=1, method="N", 
	colorspace=c("black","white"), colorbias=1, map=TRUE, ...) {

    if (missing(dataset)) {
	cat("Remember to provide an object from readosisaf.\n")
	return;
    }

    eastings <- dataset$header$ucs_ul_x+
	(dataset$header$ucs_dx*(0:(dataset$header$xsize-1)))
    northings <- dataset$header$ucs_ul_y-
	(dataset$header$ucs_dy*(0:(dataset$header$ysize-1)))

    eastings <- sort(eastings)
    northings <- sort(northings)

    if (length(channel) == 2) {
	if (method == "D") {
	    t <- matrix(dataset$data[,channel[1]]-dataset$data[,channel[2]],
		    ncol=dataset$header$ysize,nrow=dataset$header$xsize)
	} else if (method == "R") {
	    t <- matrix(dataset$data[,channel[1]]/dataset$data[,channel[2]],
		    ncol=dataset$header$ysize,nrow=dataset$header$xsize)
	} else {
	    return("Method chosen is not supported")
	}
    } else if (length(channel) == 1) {
	t <- matrix(dataset$data[,channel],
		ncol=dataset$header$ysize,nrow=dataset$header$xsize)
    } else {
	return("Incorrect parameter specification")
    }

    aspectratio <- dataset$header$ysize/dataset$header$xsize
    par(fin=c(5,5*aspectratio))

    mypalette <- colorRampPalette(colors=colorspace,bias=colorbias)

    if (map==TRUE) {
	data(gshhsmapdata)
        mapdata <- milatlon2ucs(gshhsmapdata$lat,gshhsmapdata$lon)
        ##lines(mapdata$eastings,mapdata$northing)
	filled.contour(eastings,northings,t[,dataset$header$ysize:1],
		asp=aspectratio,
		plot.axes={axis(1);axis(2);
		lines(mapdata$eastings,mapdata$northing)},
		color.palette=mypalette, ...)
    } else {
	filled.contour(eastings,northings,t[,dataset$header$ysize:1],
		asp=aspectratio,color.palette=mypalette, ...)
    }

    if (method=="D") {
	chcomb = "Difference between AVHRR channels"
    } else if (method == "R") {
	chcomb = "Ratio between AVHRR channels"
    }
    
    if (length(channel) == 2) {
	title(paste(chcomb,
		dataset$header$channelid[channel[1]],
		"and",
		dataset$header$channelid[channel[2]]),
	    sub=sprintf("%4d-%02d-%02d %02d:%02d UTC",
		dataset$header$year,dataset$header$month,dataset$header$day,
		dataset$header$hour,dataset$header$minute),
		cex.main=0.75,cex.sub=0.8)
    } else {
	title(paste("AVHRR channel ",dataset$header$channelid[channel]),
	    sub=sprintf("%4d-%02d-%02d %02d:%02d UTC",
		dataset$header$year,dataset$header$month,dataset$header$day,
		dataset$header$hour,dataset$header$minute),
		cex.main=0.75, cex.sub=0.8)
    }

}
