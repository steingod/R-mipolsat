#
# NAME:
# plotctval
#
# PURPOSE:
# NA 
#
# NOTES:
# Not fully finished... 
#
# BUGS:
# Probably in the underlying C-function...
# C functions does not transfer strings back properly...
#
# AUTHOR:
# Øystein Godøy, MET/FOU, 30.01.2003
#
# CVS_ID:
# $Id: plotctval.R,v 1.1 2007-09-07 17:02:59 steingod Exp $
#

plotctval <- function(d=NULL,type="N",mylevels=40) {

    if (missing(d)) {
	cat("Husk at objektnavn må oppgis...\n")
	return;
    }
    mybreaks <- c(-0.5,0.5,1.5,2.5,3.5,4.5,5.5,6.5,7.5,8.5,9.5,10.5,
	11.5,12.5,13.5,14.5,15.5,16.5,17.5,18.5,19.5,20.5)

    if (type=="N") {
	mymatrix <- as.matrix(table(factor(d$N,0:10),
	    factor(d$cm,0:20)))
	myxlab <- "N"
    } else if (type=="CL") {
	mymatrix <- as.matrix(table(factor(d$CL,0:10),
	    factor(d$cm,0:20)))
	myxlab <- "CL"
    } else if (type=="CM") {
	mymatrix <- as.matrix(table(factor(d$CM,0:10),
	    factor(d$cm,0:20)))
	myxlab <- "CM"
    } else if (type=="CH") {
	mymatrix <- as.matrix(table(factor(d$CH,0:10),
	    factor(d$cm,0:20)))
	myxlab <- "CH"
    } else if (type=="CLHIST") {
	hist(d$cm[d$cm>0&d$N>=6&d$N<=9&d$CL>0&d$CM<=0&d$CH<=0],
	breaks=mybreaks,dens=14,
	xlab="Cloud types")
    } else if (type=="CMHIST") {
	hist(d$cm[d$cm>0&d$N>=6&d$N<=8&d$CM>0&d$CH<=0],
	breaks=mybreaks,dens=14,
	xlab="Cloud types")
    } else if (type=="CHHIST") {
	hist(d$cm[d$cm>0&d$N>=6&d$N<=8&d$CH>0],
	breaks=mybreaks,dens=14,
	xlab="Cloud types")
    } else if (type=="CLEARHIST") {
	hist(d$cm[d$cm>0&d$N<2&d$CL<=0&d$CM<=0&d$CH<=0],
	breaks=mybreaks,dens=14,
	xlab="Cloud types")
    }

    if (type!="CLHIST"&type!="CMHIST"&type!="CHHIST"&type!="CLEARHIST") {
	contour(0:10,0:20,mymatrix,nlevels=mylevels,xlab=myxlab,ylab="CT")
	title(paste("Station id: ",d$station,
	    ", NOBS: ",d$noobs,
	    "\nTime span: ",format(min(d$tid),"%d.%m.%Y")," - ",
	    format(max(d$tid),"%d.%m.%Y")))
    }

    if (type!="CLHIST"&type!="CMHIST"&type!="CHHIST"&type!="CLEARHIST") {
	return(mymatrix)
    }
}
