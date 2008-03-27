\name{fm_ch3brefl}

\alias{fm_ch3brefl}

\title{
    Estimate the reflectance of AVHRR channel 3b (3.7 micrometer).
}

\description{
    Given the brightness temperatures of AVHRR channels 3B and 4, the
    solar zenith angle and the satellite identification, the
    reflectance of AVHRR channel 3B is being returned.

    The reflectivity returned is adjusted for the instrument response of
    the actual satellite being used. Currently support is added for
    NOAA-15 through NOAA-18, no support is added for METOP yet.
}

\usage{
    fm_ch3brefl(bt3b,bt4, solang, date, satname)
}

\arguments{
    \item{bt3b}{brightness temperature of AVHRR channel 3B}
    \item{bt4}{brightness temperature of AVHRR channel 4}
    \item{solang}{the solar zenith angle in degrees}
    \item{date}{the corresponding dates as POSIXct objects} 
    \item{satname}{name of the satellite e.g. "NOAA-18"}
}

\value{
    The reflectivity (0-100\%) as a value or a vector
}

\seealso{
    \link{fm_bidirrefl}, \link{fm_temp2rad}, \link{fm_rad2temp}, \link{fm_findsollum}
}

\author{
    Øystein Godøy (\email{o.godoy@met.no})
}

\examples{
    # Plotting AVHRR channel 3B reflectances against solar zenith angle
    plot(t$soz,fm_ch3brefl(t$k3b,t$k4,t$soz,t$tid,"NOAA-18"))
}

\keyword{
}
