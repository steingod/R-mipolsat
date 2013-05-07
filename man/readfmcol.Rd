\name{readfmcol}
\alias{readfmcol}

\title{
    Reads FMCOL HDF5 files containing AVHRR data collocated with other
    data, and concatenates them.
}

\description{
    FMCOL HDF5 collocation files containing collocated data 
    are read and the contents (or some of the contents) are returned to R
    for further analysis and concatenation. This function is a generic
    function utilise more specialised functions. The specialised
    functions can be hidden or visible for ordinary usage.

    The objects currently supported and their numbering is:
    \enumerate {
        \item AVHRR data, a square box of channel data (reflectances or
        brightness temperature) and auxiliary information like observation
        geometry, time, number of pixels etc.
        \item NWP data, Numerical Weather Prdeiction data, usually from the
        operational model suite.
        \item STDAT, in situ measurements from GTS SYNOP or DRAU files.
        \item SAFCM, NWCSAF PPS cloudtype products.
        \item SAFSSI, OSISAF shortwave estimates.
        \item SAFDLI, OSISAF longwave estimates.
    }
}

\usage{
    readfmcol(path,pattern,method,classname="cloud",station="NA",start="NA",end="NA")
}

\arguments{
    \item{path}{path to the files to read}
    \item{pattern}{optional \link{regular expression} pattern for files to match}
    \item{method}{the read functionality to use e.g. read123, read124.
    remember quotes.}
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
