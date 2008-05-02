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
# NA
#
# CVS_ID:
# $Id: getclassnames.R,v 1.2 2008-05-02 21:37:55 steingod Exp $
#

getclassnames <- function(filename) {

    if (! file.exists(filename)) {
	return("Could not find requested file\n")
    }
    noobs <- 0
    classes <- character(length=500)

    tmp <- .C("classnames",
	filename=as.character(filename),
	noobs=as.integer(noobs),classes=as.character(classes),
	package="mipolsat"
	)
    
    return(c(tmp$classes[1:tmp$noobs]))
}
