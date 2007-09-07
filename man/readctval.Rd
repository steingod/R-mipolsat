\name{
    readctval
}

\alias{
    readctval
}

\title{
    Reads FMCOL HDF5 files containing cloud type products
}

\description{
    FMCOL HDF5 collocation files containing NWCSAF Cloud Types objects and
    SYNOP objects are read into a data frame.
}

\usage{
    readctval(filename,classname="cloud",station="NA",start="NA",end="NA")
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
    variables. For interpretation of the cloud mask values, check the
    NWCSAF PPS User Manual or the raw FMCOL HDF5 file where this
    information is stored.
}

\seealso{
    \link{plotctval}, \link{readsig}, \link{readsnowsig}
}

\author{
    Øystein Godøy (\email{o.godoy@met.no})
}

\examples{
    t <- readctval(file="/disk2/collocate/output/cloud_20070831.hdf5")
}

\keyword{
}

\note{
    Check the raw FMCOL HDF5 file or the NWCSAF PPS Users Manual for
    explanation of PPS cloud type codes. Remember that these may change
    between various versions of PPS (and the Users Manual).
}
