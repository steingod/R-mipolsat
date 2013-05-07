\name{plotctval}
\alias{plotctval}

\title{
    Plot NWCSAF PPS cloud types versus SYNOP observations
}

\description{
    Creates various types of contour plots and histograms.
}

\usage{
    plotctval(d=NULL,type="N",mylevels=40)
}

\arguments{
    \item{d}{object to plot, must be created by \link{readctval}}
    \item{type}{type of plot to generate, available types are: N, CL, CM,
    CH, CLHIST, CMHIST, CHHIST, CLEARHIST (more TBW)}
}

\value{
    A \link{data.frame} if histogram was chosen. 
}

\seealso{
    \link{readctval}
}

\author{
    Øystein Godøy (\email{o.godoy@met.no})
}

\examples{
    t <- plotctval(file="/disk2/collocate/output/cloud_20070831.hdf5")
}

\keyword{
}

\note{
}
