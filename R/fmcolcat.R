#
# NAME:
# NA
#
# PURPOSE:
# To concatenate lists returned by other FMCOL read functions.
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
# Øystein Godøy, METNO/FOU, 30.04.2008
#
# MODIFIED:
# NA
#
# CVS_ID:
# $Id: fmcolcat.R,v 1.2 2008-05-02 21:37:55 steingod Exp $
#

fmcolcat <- function(mylists) {

    listlength <- length(mylists)
    if (listlength < 2) {
	return("Nothing to concatenate\n")
    }

    mynames1 <- names(mylists[[1]])
    for (i in 2:listlength) {
	mynames <- names(mylists[[i]])
	if (! all(mynames1 == mynames)) {
	    return("Input lists are not of the same type\n")
	}
    }
    mynames <- names(mylists[[1]])
    myresult <- list()
    # Concatenate objects 
    for (j in 1:length(mynames)) {
	myresult[[j]] <- do.call("c",lapply(mylists, function(u) u[[j]]))
    }

    # Sort data vectors
    # First create a temporary list of the datavectors...
    datavectornames <- c("tid","k1","k2","k3a","k3b","k4","k5",
	    "soz","saz","raz","cm")
    i <- 1
    mytmplist <- list()
    tmpnames <- vector()
    for (j in 1:length(mynames)) {
	if (any(mynames[j] == datavectornames)) {
	    mytmplist[[i]] <- myresult[[j]] 
	    tmpnames <- c(tmpnames,mynames[j])
	    i <- i+1
	}
    }
    names(mytmplist) <- tmpnames

    # Then sort...
    myorder <- order(mytmplist$tid)
    tmp <- lapply(mytmplist, function(u) u[myorder])
    names(tmp) <- tmpnames

    # Put it back together as the standard list returned again...
    for (j in 1:length(mynames)) {
	if (any(mynames[j] == tmpnames)) {
	    myresult[[j]] <- tmp[[mynames[j]]]
	}
    }
    names(myresult) <- mynames

    return(myresult)
}
