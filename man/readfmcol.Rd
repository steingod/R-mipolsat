\name{readfmcol}
\alias{readfmcol}

\title{
    Reads FMCOL HDF5 files containing AVHRR data collocated with other
    data, and concatenates them
}

\description{
    FMCOL HDF5 collocation files containing collocated data 
    are read and the contents (or some of the contents) are returned to R
    for further analysis and concatenation.
}

\usage{
    readfmcol(path,pattern,method,classname="cloud",station="NA",start="NA",end="NA")
}

\arguments{
    \item{path}{path to the files to read}
    \item{pattern}{optional \link{regular expression} pattern for files to match}
    \item{method}{the read functionality to use e.g. read123}
    \item{classname}{text string to search for in the HDF5 file, defaults
    to "cloud"}
    \item{station}{text string containing station identification}
    \item{start}{start time in the form "12jan2007", month name is locale
    dependent}
    \item{end}{end time, similar form to start time}
}

\value{
    A \link{list} containing the data. Use \link{names} to see the
    variables. 
}

\seealso{
    \link{readctval}, \link{readsnowsig}, \link{read123}, \link{read124}, \link{fmcolcat}
}

\author{
    Øystein Godøy (\email{o.godoy@met.no})
}

\examples{
    t <- readfmcol(path="/disk2/collocate/output",pattern=".hdf5$")
}

\keyword{
}

\note{
}
