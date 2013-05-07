
\name{readAVHRR}
\alias{readAVHRR}

\title{Read AVHRR data}

\description{
    Various file formats containing AVHRR data are supported by this
    function.
}
\usage{
    readAVHRR(filename,nomiss=TRUE)
}

\arguments{
    \item{filename}{filename to access}
    \item{nomiss}{logical controlling transformation of missing values}
}
\value{\link{list} containing data and metadata as elements header and
data.}

\seealso{\link{createAVHRRimage}}

\author{
    Øystein Godøy \email{o.godoy@met.no}
}

\examples{

    # Read AVHRR data
    t <- readAVHRR(filename="/data/avhrr/noaa18_02568_200610191134_ns.h5")

}

\keyword{}
