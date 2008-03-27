\name{fm_esd}

\alias{fm_esd}

\title{
    Correction factor for the varying distance between Earth and Sun
}

\description{
    Given the day of the year, the correction factor for the varying
    distance between the Earth and the Sun is returned according to the
    specification of Paltridge and Platt (1976) at page 57.
}

\usage{
    fm_esd(doy)
}

\arguments{
    \item{doy}{Day of year (0-365)}
}

\value{
    The correction factor as a number or vector
}

\seealso{
    \link{fm_ch3brefl}, \link{fm_bidirref}
}

\author{
    Øystein Godøy (\email{o.godoy@met.no})
}

\examples{
}

\keyword{
}
