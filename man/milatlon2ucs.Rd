
\name{milatlon2ucs}
\alias{milatlon2ucs}

\title{Convert between geographical and UCS coordinates}

\description{
Geographical coordinates (latitude and longitude) are converted to
coordinates within the Cartesian User Coordinate System, northings and
eastings using a spherical Earth and an Earth radius of 6371. km. This is
a very crude approximation, for better accuracy and support of other Earth
models use e.g. PROJ.4 software (\url{http://www.remotesensing.org/proj}).
}
\usage{
milatlon2ucs(latitude, longitude)  
}

\arguments{
    \item{latitude}{decimal degrees, positive in northern hemisphere}
    \item{longitude}{decimal degrees, positive Eastwards, negative
    westwards}
}
\value{Returns a \link{data.frame} with latitude (lat) and longitude (lon)
and metadata.
}

\seealso{\link{miucs2latlon}}

\author{
    Øystein Godøy (\email{o.godoy@met.no})
}
\note{
}

\examples{
    ucs <- miucs2latlon(latitude,longitude)
    ucs$northings
    ucs$eastings
}

\keyword{}
