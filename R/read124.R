#
# NAME:
# readsig
#
# PURPOSE:
# To read collocate HDF5 files containing validation data for signature
# studies.
#
# NOTES:
# Not fully finished... 
#
# BUGS:
# Probably in the underlying C-function...
# C functions does not transfer strings back properly...
#
# CVS_ID:
# $Id: read124.R,v 1.4 2013-04-11 20:29:04 steingod Exp $
#
# AUTHOR:
# Øystein Godøy, MET/FOU, 30.01.2003
#
# MODIFIED:
# Øystein Godøy, met.no/FOU, 12.10.2004 
# Reduce the number of vectors to read in order to be able to handle data
# within memory bounds.
# Øystein Godøy, METNO/FOU, 2013-04-11 
#
# CVS_ID:
# $Id: read124.R,v 1.4 2013-04-11 20:29:04 steingod Exp $
#

read124 <- function(filename,classname="cloud",station="NA",start="NA",end="NA") {

    if (missing(filename)) {
	cat("Husk at filnavn må oppgis...\n")
	return;
    }

    start <- as.POSIXct(strptime(start,format="%d%b%Y"))
    end <- as.POSIXct(strptime(end,format="%d%b%Y"))
    if (is.na(start)) start <- 0
    if (is.na(end)) end <- 0

    noobs <- 0

    cat("Checking number of records in the file...\n")
    tmp <- .C("checkrec",
	filename=as.character(filename),
	noobs=as.integer(noobs),
	classname=as.character(classname),
	station=as.character(station),
	start=as.integer(start),end=as.integer(end),package="mipolsat")
    cat(paste("Number of records found:",tmp$noobs,"\n"))
    if (tmp$noobs <= 0) {
	return(cat("Bailing out...\n"))
    }

    nopix <- 13*13
    size <- tmp$noobs*nopix
    tid <- vector(mode="integer",length=size)
    k1 <- real(length=size)
    k2 <- real(length=size)
    k3a <- real(length=size)
    k3b <- real(length=size)
    k4 <- real(length=size)
    k5 <- real(length=size)
    soz <- real(length=size)
    saz <- real(length=size)
    raz <- real(length=size)
    cm <- real(length=size)
    cat("\nThe necessary vectors are allocated...\n")
    
    cat("Reading data...\n")
    tmp <- .C("Rread124",
	filename=as.character(filename),
	noobs=as.integer(tmp$noobs),nopix=as.integer(nopix),
	classname=as.character(classname),
	station=as.character(station),
	start=as.integer(start),end=as.integer(end),
	tid=as.integer(tid),
	k1=as.real(k1), k2=as.real(k2), k3a=as.real(k3a),
	k3b=as.real(k3b),
	k4=as.real(k4), k5=as.real(k5), 
	soz=as.real(soz), saz=as.real(saz), raz=as.real(raz),
	cm=as.integer(cm),
	package="mipolsat"
	)

    tmp$tid <- ISOdate(1970,1,1)+tmp$tid 
    tmp$k1[tmp$k1 < -100] <- NA
    tmp$k2[tmp$k2 < -100] <- NA
    tmp$k3a[tmp$k3a < -100] <- NA
    tmp$k3b[tmp$k3b < -100] <- NA
    tmp$k4[tmp$k4 < -100] <- NA
    tmp$k5[tmp$k5 < -100] <- NA
    tmp$soz[tmp$soz < -100] <- NA
    tmp$saz[tmp$saz < -100] <- NA
    tmp$raz[tmp$raz < -100] <- NA
    tmp$cm[tmp$cm < 0] <- NA
    return(tmp)
}
