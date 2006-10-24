
\name{compareAVHRRchains}
\alias{compareAVHRRchains}

\title{
    Compares several AVHRR images from different processing chains
}

\description{
    Given paths to the results from two different processing chains that
    share the common file naming convention and format, files are read,
    statistics are generated and results are presented. This function
    relies on time specification and area specification for identification
    of the data. Files from the two directories are listed and compared
    based upon an expected naming convention for filenames. Statistics are
    generated for all channels, results are plotted for channels 1,2, 4
    and 5 (due to size considerations when dividing the plotting device).
}

\usage{
    compareAVHRRchains(chain1, chain2, area="ns")  
}

\arguments{
    \item{chain1}{path to files for first processing chain}
    \item{chain2}{path to files for second processing chain}
    \item{area}{area keyword, used for file listing}
}
\value{
    A \link{matrix} containing the results for each channel in the rows.
    The columns represents the differences between the two processing
    chains.
}

\seealso{
    \link{readAVHRR}, \link{createAVHRRimage}, \link{compareAVHRRimages}
}

\author{
    Øystein Godøy (\email{o.godoy@met.no})
}
\note{
    At present this function is adapted for some variations in naming
    conventions used within the processing chains for AVHRR data at the
    Norwegian Meteorological Institute. Orbit number is not required to be
    part of the filename, else filenames are expected to be of the type:
    \code{avhrr_noaa18_20061024_0636_43910_ns.aha}, the generic
    description is \code{avhrr_<satellite name>_<date>_<time>_<orbit
    number>_<areaname>.aha}.
}

\examples{
    # Specify directories which contain METSAT files
    t <- compareAVHRRchains("/data/noaa/","/data/noaa_old/","ns")
}

\keyword{}
