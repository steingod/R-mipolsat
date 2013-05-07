\name{fm_bidirref}

\alias{fm_bidirref}

\title{
    Estimate the bidirectional reflectance.
}

\description{
    Given the reflectance, day of year and solar zenith angle, the
    bi-directional reflectance is returned. This reflectance is adjusted
    for the variation of the Earth-Sun distance through the year and
    transformed from the assumption of Sun at zenith to the actual
    solar zenith angle used.
}

\usage{
    fm_bidirrefl(refl,doy,solang)
}

\arguments{
    \item{refl}{The normalised reflectance under the assumption of Sun at
    zenith}
    \item{date}{Time identification as POSIXct object}
    \item{solang}{Solar zenith angle in degrees}
}

\value{
    The bi-directional reflectance as a value or a vector depending on the
    input
}

\seealso{
    \link{fm_ch3brefl}, \link{fm_esd}
}

\author{
    Øystein Godøy (\email{o.godoy@met.no})
}

\examples{
}

\keyword{
}
