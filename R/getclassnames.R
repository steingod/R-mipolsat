#
# NAME:
# NA
#
# PURPOSE:
# NA
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
# NA
#
# MODIFIED:
# Øystein Godøy, METNO/FOU, 2013-05-10 
#
# CVS_ID:
# $Id: getclassnames.R,v 1.4 2013-05-27 13:14:20 steingod Exp $
#

getclassnames <- function(filename) {

    if (! file.exists(filename)) {
        return("Could not find requested file\n")
    }
    noobs <- 0
    classes <- character(length=500)

    cat("Checking number of records in the file...\n")
    tmp <- .C("checkrec",
              filename=as.character(filename),
              noobs=as.integer(noobs),
              classname=as.character(classname),
              station=as.character(station),
              start=as.integer(start),end=as.integer(end),
              package="mipolsat")
    cat(paste("Number of records found:",tmp$noobs,"\n"))
    if (tmp$noobs <= 0) {
        return(cat("Bailing out...\n"))
    }

    tmp <- .C("classnames",
              filename=as.character(filename),
              noobs=as.integer(noobs),classes=as.character(classes),
              package="mipolsat"
              )

    return(c(tmp$classes[1:tmp$noobs]))
}
