#
# NAME:
# readctval
#
# PURPOSE:
# To read collocate HDF4 files containing validation data for SAFNWC CM.
#
# NOTES:
# Not fully finished... 
#
# BUGS:
# Probably in the underlying C-function...
# C functions does not transfer strings back properly...
#
# CVS_ID:
# $Id: readctval.R,v 1.2 2008-04-29 16:28:44 steingod Exp $
#
# AUTHOR:
# Øystein Godøy, MET/FOU, 30.01.2003
#

readctval <- function(filename,classname="cloud",station="NA",start="NA",end="NA") {

    if (missing(filename)) {
	cat("Husk at filnavn må oppgis...\n")
	return;
    }

    start <- as.POSIXct(strptime(start,format="%d%b%Y"))
    end <- as.POSIXct(strptime(end,format="%d%b%Y"))
    if (is.na(start)) start <- 0
    if (is.na(end)) end <- 0

    noobs <- 0

    tmp <- .C("checkrec",
	filename=as.character(filename),
	noobs=as.integer(noobs),
	classname=as.character(classname),
	station=as.character(station),
	start=as.integer(start),end=as.integer(end))
    #dyn.unload("/home/steingod/software/R-functions/dumpcol/checkrec.so")

    if (tmp$noobs <= 0) return
    cat(paste("Fant:",tmp$noobs,"lagrede enheter\n"))

    nopix <- 13*13
    size <- tmp$noobs*nopix
    stid <- vector(mode="integer",length=size)
    tid <- vector(mode="integer",length=size)
    N <- vector(mode="integer",length=size)
    CL <- vector(mode="integer",length=size)
    CM <- vector(mode="integer",length=size)
    CH <- vector(mode="integer",length=size)
    E <- vector(mode="integer",length=size)
    sss <- vector(mode="integer",length=size)
    cm <- vector(mode="integer",length=size)
    
    #dyn.load("/home/steingod/software/R-functions/dumpcol/readctval.so")
    tmp <- .C("readctval",
	filename=as.character(filename),
	noobs=as.integer(tmp$noobs),nopix=as.integer(nopix),
	station=as.character(station),
	start=as.integer(start),end=as.integer(end),
	stid=as.integer(stid),tid=as.integer(tid),
	N=as.integer(N),
	CL=as.integer(CL), CM=as.integer(CM), CH=as.integer(CH),
	E=as.integer(E), sss=as.integer(sss),
	cm=as.integer(cm))

    cat(paste("Number of records found:",tmp$noobs,"\n"))
    if (tmp$noobs <= 0) {
	return(cat("Bailing out...\n"))
    }
    cat(paste("Fant:",tmp$noobs,"lagrede enheter etter forkastning\n"))
    validata <- tmp$noobs*169

    tmp$tid <- ISOdate(1970,1,1)+tmp$tid 
    return(data.frame(
	stid=tmp$stid[1:validata],
	noobs=tmp$noobs[1:validata],
	tid=tmp$tid[1:validata],
	N=tmp$N[1:validata],
	CL=tmp$CL[1:validata],
	CM=tmp$CM[1:validata],
	CH=tmp$CH[1:validata],
	E=tmp$E[1:validata],
	sss=tmp$sss[1:validata],
	cm=tmp$cm[1:validata]
	))
}
