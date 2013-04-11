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
# Ãystein GodÃ¸y, METNO/FOU, 2013-04-11 
#
# CVS_ID:
# $Id: getclassnames.R,v 1.3 2013-04-11 20:29:04 steingod Exp $
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
