
\name{createAVHRRimage}
\alias{createAVHRRimage}

\title{Create image of AVHRR data}

\description{
This function reads the output from \link{readAVHRR} and creates an image
on the graphical device used. Some basic channel combination is also
supported.
}
\usage{
createAVHRRimage(x, channel=1, map=TRUE, method="N", ...)  
}

\arguments{
    \item{x}{R object (\link{list}) returned by \link{readAVHRR}}
    \item{channel}{channel identification}
    \item{map}{logical telling whether coast lines should be added}
    \item{method}{letter specifying how to combine channels ("D" is
    difference, "R" is ratio, "N" is none)}
    \item{...}{options to \link{filled.contour}}
}
\value{None}

\seealso{\link{readAVHRR}}

\author{
    Øystein Godøy (\email{o.godoy@met.no})
}
\note{
    The current version supports map overlay only for the standard map
    projection of the OSISAF HL centre. That is Polar Stereographic
    correct at 60 degrees North and not rotated.
}

\examples{
    # Read a sea ice concentration field
    t <- readAVHRR(file="/data/avhrr/noaa18_03452_200610191134.h5")
    # Generate image on graphical device
    createAVHRRimage(t)
}

\keyword{}
