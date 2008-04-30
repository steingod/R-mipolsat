#
# NAME:
# NA
#
# PURPOSE:
# Generic FMCOL read function.
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
# Øystein Godøy, METNO/FOU, 29.04.2008 
#
# MODIFIED:
# NA
#
# CVS_ID:
# $Id: readfmcol.R,v 1.2 2008-04-30 19:37:33 steingod Exp $

readfmcol <- function(path, pattern=NULL, method, classname="cloud",
station="NA",start="NA",end="NA") {

    if (length(pattern) == 0) {
	cat("No pattern was specified, using all files in directory\n")
    }

    filelist <- list.files(path,pattern,full.names=TRUE)

    t <- vector(mode="list", length=length(filelist))

    for (i in 1:length(filelist)) {
	cat(paste("Reading file:",filelist[i],"\n"))
	if (method == "read124") {
	    t[[i]] <- read124(filelist[i],classname,station,start,end)
	} else if (method == "read123") {
	    t[[i]] <- read123(filelist[i],classname,station,start,end)
	} else {
	    return("Unknown method\n")
	}
    }

    mydata <- fmcolcat(t)

    return(mydata)
}
