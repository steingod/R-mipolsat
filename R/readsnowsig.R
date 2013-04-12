#
# NAME:
# readsnowsig
#
# PURPOSE:
# To read collocate HDF4 files containing validation data for signature
# studies.
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
# MODIFIED:
# Øystein Godøy, met.no/FOU, 20.11.2004
# Added extraction of NWP and slightly modified data reduction...
#
# CVS_ID:
# $Id: readsnowsig.R,v 1.3 2013-04-12 10:29:24 steingod Exp $
#

readsnowsig <- function(filename,classname="snow",station="NA",start="NA",end="NA") {

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
                    if (tmp$noobs <= 0) return

                        nopix <- 13*13
                            size <- tmp$noobs*nopix
                            tid <- vector(mode="integer",length=size)
                            stid <- vector(mode="integer",length=size)
                            N <- vector(mode="integer",length=size)
                            CL <- vector(mode="integer",length=size)
                            CM <- vector(mode="integer",length=size)
                            CH <- vector(mode="integer",length=size)
                            E <- vector(mode="integer",length=size)
                            sss <- vector(mode="integer",length=size)
                            k1 <- real(length=size)
                            k2 <- real(length=size)
                            k3a <- real(length=size)
                            k3b <- real(length=size)
                            k4 <- real(length=size)
                            k5 <- real(length=size)
                            soz <- real(length=size)
                            saz <- real(length=size)
                            raz <- real(length=size)
                            t0m <- real(length=size)
                            t2m <- real(length=size)

                            tmp <- .C("readsnowsig",
                                    filename=as.character(filename),
                                    noobs=as.integer(tmp$noobs),nopix=as.integer(nopix),
                                    station=as.character(station),
                                    start=as.integer(start),end=as.integer(end),
                                    stid=as.integer(stid),tid=as.integer(tid),
                                    N=as.integer(N),
                                    CL=as.integer(CL), CM=as.integer(CM), CH=as.integer(CH),
                                    E=as.integer(CL), sss=as.integer(CM),
                                    k1=as.real(k1), k2=as.real(k2), k3a=as.real(k3a),
                                    k3b=as.real(k3b),
                                    k4=as.real(k4), k5=as.real(k5), 
                                    soz=as.real(soz), saz=as.real(saz), raz=as.real(raz),
                                    t0m=as.real(t0m), t2m=as.real(t2m)
                                    )

# Perform data transformations
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
                            tmp$N[tmp$N < 0] <- NA
                            tmp$CL[tmp$CL < 0] <- NA
                            tmp$CM[tmp$CM < 0] <- NA
                            tmp$CH[tmp$CH < 0] <- NA
                            tmp$E[tmp$E < 0] <- NA
                            tmp$sss[tmp$sss < 0] <- NA

# Create data.frame for easier data handling during analysis
                            dafr <- data.frame(
                                    tid=tmp$tid[tmp$soz<85.],
                                    N=tmp$N[tmp$soz<85.],
                                    CL=tmp$CL[tmp$soz<85.],
                                    CM=tmp$CM[tmp$soz<85.],
                                    CH=tmp$CH[tmp$soz<85.],
                                    E=tmp$E[tmp$soz<85.],
                                    sss=tmp$sss[tmp$soz<85.],
                                    k1=tmp$k1[tmp$soz<85.],
                                    k2=tmp$k2[tmp$soz<85.],
                                    k3=tmp$k3[tmp$soz<85.],
                                    k4=tmp$k4[tmp$soz<85.],
                                    k5=tmp$k5[tmp$soz<85.],
                                    soz=tmp$soz[tmp$soz<85.],
                                    saz=tmp$saz[tmp$soz<85.],
                                    raz=tmp$raz[tmp$soz<85.],
                                    t0m=tmp$t0m[tmp$soz<85.],
                                    t2m=tmp$t2m[tmp$soz<85.])

                            return(dafr)
}
