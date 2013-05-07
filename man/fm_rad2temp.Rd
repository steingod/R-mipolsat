\name{fm_rad2temp}

\alias{fm_rad2temp}

\title{
    Estimate the brightness temperature.
}

\description{
    Given a radiance, returns the brightness temperature 
    adjusted for the instrument response of the sensor being used.
}

\usage{
    fm_rad2temp(radiance, satname)
}

\arguments{
    \item{radiance}{Radiance of an AVHRR channel to be converted}
    \item{satname}{Identification of the satellite being used, e.g.
    NOAA-18}
}

\value{
    A value or vector, depending on input.
}

\seealso{
    \link{fm_temp2rad}
}

\author{
    Øystein Godøy (\email{o.godoy@met.no})
}

\examples{
}

\keyword{
}
