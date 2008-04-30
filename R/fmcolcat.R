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
# $Id: fmcolcat.R,v 1.1 2008-04-30 19:37:33 steingod Exp $
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
    for (j in 1:length(mynames)) {
	myresult[[j]] <- do.call("c",lapply(mylists, function(u) u[[j]]))
    }

    names(myresult) <- mynames

    return(myresult)
}
