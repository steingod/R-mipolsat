#
# NAME:
# readdlidev
#
# PURPOSE:
# To read collocate HDF5 files containing DLI development database.
#
# NOTES:
# Not fully finished... 
#
# BUGS:
# Probably in the underlying C-function...
# C functions does not transfer strings back properly...
#
# CVS_ID:
# $Id: readdlidev.R,v 1.3 2013-04-11 20:29:04 steingod Exp $
#
# AUTHOR:
# Øystein Godøy, MET/FOU, 30.01.2003
#
# MODIFIED:
# Øystein Godøy, METNO/FOU, 2013-04-11 
#
# CVS_ID:
# $Id: readdlidev.R,v 1.3 2013-04-11 20:29:04 steingod Exp $
#

readdlidev <- function(filename,
    station="NA",start="NA",end="NA",classname="DLIDEV") {

    if (missing(filename)) {
	cat("Husk at filnavn må oppgis...\n")
	return;
    }

    start <- as.POSIXct(strptime(start,format="%d%b%Y"))
    end <- as.POSIXct(strptime(end,format="%d%b%Y"))
    if (is.na(start)) start <- 0
    if (is.na(end)) end <- 0

    noobs <- 0

    cat("Sjekker antall poster som skal leses...\n")
    tmp <- .C("checkrecdli",
	filename=as.character(filename),
	noobs=as.integer(noobs),
	classname=as.character(classname),
	station=as.character(station),
	start=as.integer(start),end=as.integer(end))
    if (tmp$noobs <= 0) return

    cat(paste("Antall poster funnet:",tmp$noobs,"\n"))

    nopix <- 13*13
    size <- tmp$noobs*nopix
    time <- vector(mode="integer",length=size)
    k1 <- real(length=size)
    k2 <- real(length=size)
    k3a <- real(length=size)
    k3b <- real(length=size)
    k4 <- real(length=size)
    k5 <- real(length=size)
    t2m <- real(length=size)
    pw <- real(length=size)
    ps <- real(length=size)
    cm <- vector(mode="integer",length=size)
    ssi <- real(length=size)
    
    cat("Leser poster...\n")
    cat(paste("Har satt av:",size,"elementer\n"))
    tmp <- .C("readdlidev",
	filename=as.character(filename),
	noobs=as.integer(tmp$noobs),nopix=as.integer(nopix),
	station=as.character(station),
	start=as.integer(start),end=as.integer(end),
	time=as.integer(time),
	k1=as.real(k1),k2=as.real(k2),
	k3a=as.real(k3a),k3b=as.real(k3b),
	k4=as.real(k4),k5=as.real(k5),
	t2m=as.real(t2m),ps=as.real(ps),pw=as.real(pw),
	cm=as.integer(cm),
	ssi=as.real(ssi))

    ##tmp$tid <- ISOdate(1970,1,1,0)+tmp$tid 
    return(tmp)
}
