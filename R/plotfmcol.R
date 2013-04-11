#
# NAME:
# NA
#
# PURPOSE:
# To plot various features of the collocated satellite data.
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
# Øystein Godøy, METNO/FOU, 08.05.2008 
#
# MODIFIED:
# Øystein Godøy, METNO/FOU, 2013-04-11 
#
# CVS_ID:
# $Id: plotfmcol.R,v 1.2 2013-04-11 20:29:04 steingod Exp $
#

plotfmcol <- function(dataset, feature="T4", xaxis="tid", suncor=FALSE,
satid="NOAA-18", ...) {

    if (feature == "T4") {
	ypar <- dataset$k4
	ylab <- "Brightness temperature of channel 4"
    } else if (feature == "T5") {
	ypar <- dataset$k5
	ylab <- "Brightness temperature of channel 5"
    } else if (feature == "T3B") {
	ypar <- dataset$k3b
	ylab <- "Brightness temperature of channel 3B"
    } else if (feature == "R1") {
	ypar <- dataset$k1
	if (suncor) {
	    ypar <- ypar/cos(dataset$soz*(pi/180))
	}
	ylab <- "Bi-directional reflectivity of channel 1"
    } else if (feature == "R2") {
	ypar <- dataset$k2
	if (suncor) {
	    ypar <- ypar/cos(dataset$soz*(pi/180))
	}
	ylab <- "Bi-directional reflectivity of channel 2"
    } else if (feature == "R3A") {
	ypar <- dataset$k3a
	if (suncor) {
	    ypar <- ypar/cos(dataset$soz*(pi/180))
	}
	ylab <- "Bi-directional reflectivity of channel 3A"
    } else if (feature == "R3B") {
	ypar <-	fm_ch3brefl(dataset$k3b,dataset$k4,
		dataset$soz,date=dataset$tid,satname=satid)
	if (suncor) {
	    ypar <- ypar/cos(dataset$soz*(pi/180))
	}
	ylab <- "Bi-directional reflectivity of channel 3B"
    } else if (feature == "R2/R1") {
	ypar <- dataset$k2/dataset$k1
	ylab <- "Ratio of bi-directional reflectivities of channels 2 and 1"
    } else if (feature == "R3A/R1") {
	ypar <- dataset$k3a/dataset$k1
	ylab <- "Ratio of bi-directional reflectivities of channels 3A and 1"
    } else if (feature == "R3B/R1") {
	ypar <- fm_ch3brefl(dataset$k3b,dataset$k4,
		dataset$soz,date=dataset$tid,satname=satid)/dataset$k1
	ylab <- "Ratio of bi-directional reflectivities of channels 3B and 1"
    } else if (feature == "T4-T5") {
	ypar <- dataset$k4-dataset$k5
	ylab <- "Difference between brightness tempoeratures of channels 4 and 5"
    } else if (feature == "T3B-T5") {
	ypar <- dataset$k3b-dataset$k5
	ylab <- "Difference between brightness tempoeratures of channels 3B and 5"
    } else {
	return("Could not recognize the specified feature...\n")
    }

    if (xaxis == "tid" || xaxis == "soz" || xaxis == "saz") {
	xpar <- dataset[[xaxis]]
	if (xaxis == "tid") {
	    xlab <- "Time"
	} else if (xaxis == "soz") {
	    xlab <- "Solar zenith angle"
	} else if (xaxis == "saz") {
	    xlab <- "Satellite zenith angle"
	}
    } else {
	return("Could not recognize the specified x-coordinate...\n")
    }

    ##plot(snow_in_grassland$soz,fm_ch3brefl(snow_in_grassland$k3b,snow_in_grassland$k4,snow_in_grassland$soz,date=snow_in_grassland$tid,satname="NOAA-18"),xlab="Solar zenith angle", ylab="Channel 3B reflectance")

    plot(xpar, ypar, xlab=xlab, ylab=ylab, ...)
    #title(main=main)

    return
}
