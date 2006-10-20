compareAVHRRimages <- function(dataset1, dataset2, channel=1, map=TRUE) {

    if (missing(dataset1) || missing(dataset2)) {
	cat("Remember to provide an object from readosisaf.\n")
	return;
    }

    if ((dataset1$header$ucs_ul_x != dataset2$header$ucs_ul_x) || 
	(dataset1$header$ucs_ul_y != dataset2$header$ucs_ul_y) || 
	(dataset1$header$ucs_dx != dataset2$header$ucs_dx) || 
	(dataset1$header$ucs_dy != dataset2$header$ucs_dy)) {
	return("Datasets do not match geographically")
    }
    if ((dataset1$header$xsize != dataset2$header$xsize) || 
	(dataset1$header$ysize != dataset2$header$ysize)) {
	return("Datasets do not match in size")
    }
    if ((dataset1$header$year != dataset2$header$year) || 
	(dataset1$header$month != dataset2$header$month) || 
	(dataset1$header$day != dataset2$header$day) || 
	(dataset1$header$hour != dataset2$header$hour) || 
	(dataset1$header$minute != dataset2$header$minute)) {
	return("Datasets do not match in time")
    }

    eastings <- dataset1$header$ucs_ul_x+
	(dataset1$header$ucs_dx*(0:(dataset1$header$xsize-1)))
    northings <- dataset1$header$ucs_ul_y-
	(dataset1$header$ucs_dy*(0:(dataset1$header$ysize-1)))

    eastings <- sort(eastings)
    northings <- sort(northings)

    t <- matrix(dataset1$data[,channel]-dataset2$data[,channel],
	    ncol=dataset1$header$ysize,nrow=dataset1$header$xsize)

    aspectratio <- dataset1$header$ysize/dataset1$header$xsize
    par(fin=c(5,5*aspectratio))

    ##image(eastings,northings,t[,dataset1$header$ysize:1])

    if (map==TRUE) {
	data(gshhsmapdata)
        mapdata <- milatlon2ucs(gshhsmapdata$lat,gshhsmapdata$lon)
        ##lines(mapdata$eastings,mapdata$northing)
	filled.contour(eastings,northings,t[,dataset1$header$ysize:1],
		asp=aspectratio,
		plot.axes={axis(1);axis(2);
		lines(mapdata$eastings,mapdata$northing)},
		color.palette=topo.colors)
    } else {
	filled.contour(eastings,northings,t[,dataset1$header$ysize:1],
		asp=aspectratio,color.palette=topo.colors)
    }

    
    title(paste("Comparison of channel",
	    channel,
	    "for products","\n",
	    dataset1$header$filename,
	    "and","\n",
	    dataset2$header$filename),
	sub=sprintf("%4d-%02d-%02d %02d:%02d UTC",
	    dataset1$header$year,dataset1$header$month,dataset1$header$day,
	    dataset1$header$hour,dataset1$header$minute),
	    cex.main=0.75, cex.sub=0.8)

}
