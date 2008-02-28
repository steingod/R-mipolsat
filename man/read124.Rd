\name{read124}
\alias{read124}

\title{
    Reads FMCOL HDF5 files containing AVHRR data collocated with other
    data
}

\description{
    FMCOL HDF5 collocation files containing AVHRR data, NWP and NWCSAF
    PPS Cloud Type data are read and the contents (or some of the
    contents) are returned to R for further analysis.
}

\usage{
    read124(filename,classname="cloud",station="NA",start="NA",end="NA")
}

\arguments{
    \item{filename}{file to read}
    \item{classname}{text string to search for in the HDF5 file, defaults
    to "cloud"}
    \item{station}{text string containing station identification}
    \item{start}{start time in the form "12jan2007", month name is locale
    dependent}
    \item{end}{end time, similar form to start time}
}

\value{
    A \link{data.frame} containing the data. Use \link{names} to see the
    variables. 
}

\seealso{
    \link{readctval}, \link{readsnowsig}, \link{read123}
}

\author{
    Øystein Godøy (\email{o.godoy@met.no})
}

\examples{
    t <- readsig(file="/disk2/collocate/output/cloud_20070831.hdf5")
}

\keyword{
}

\note{
}
