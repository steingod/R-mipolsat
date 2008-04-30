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
# $Id: getclassnames.R,v 1.1 2008-04-30 19:38:45 steingod Exp $
#

getclassnames <- function(filename) {

    if (! file.exists(filename)) {
	return("Could not find requested file\n")
    }
    noobs <- 0

    tmp <- .C("classnames",
	filename=as.character(filename),
	noobs=as.integer(noobs),
	package="mipolsat"
	)
    
    return
}
