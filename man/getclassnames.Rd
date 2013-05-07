\name{getclasssnames}

\alias{getclassnames}

\title{
    Extracts the classnames used within a specific FMCOL file.
}

\description{
    Using the libfmcol getclassnames routine a character array containing
    the unique classnames found within the file is returned.
}

\details{
    This function calls a C-function within libfmcol. The functionality
    used within libfmcol has been thoroughly examined for memory leaks
    using valgrind. The main uncertainty lies with how the character array
    is transferred from the C-function calling libfmcol and to the
    R-function. Stringent memory handling in that step is not guaranteed
    as this is the first attempt to return a character array.  Please use
    the function with care and do not be surprised if R crashes...
}

\note{
    Beware possible memory leaks and subsequent crashes of R.
}

\usage{
    getclassnames(filename)
}

\arguments{
    \item{filename}{path to and filename to examine}
}

\value{
    Character vector containing the classnames.
}

\seealso{
    \link{readfmcol}, \link{read123}, \link{read124}
}

\author{
    Øystein Godøy (\email{o.godoy@met.no})
}

\examples{
}

\keyword{
}
