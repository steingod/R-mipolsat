\name{fm_temp2rad}

\alias{fm_temp2rad}

\title{
    Estimate the radiance.
}

\description{
    Given a brightness temperature in Kelvin, returns the radiance
    adjusted for the instrument response of the sensor being used.
}

\usage{
    fm_temp2rad(bt, satname)
}

\arguments{
    \item{bt}{Brightness temperature of an AVHRR channel}
    \item{satname}{Identification of the satellite being used, e.g.
    NOAA-18}
}

\value{
    A value or vector, depending on input.
}

\seealso{
    \link{fm_rad2temp}
}

\author{
    Øystein Godøy (\email{o.godoy@met.no})
}

\examples{
}

\keyword{
}
