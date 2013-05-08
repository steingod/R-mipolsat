\name{plotAVHRRsig}
\alias{plotAVHRRsig}

\title{
    Plot AVHRR radiometric signatures
}

\description{
    Creates various types of contour plots and histograms for AVHRR data
    collected using libfmcol. If information on the synoptic cloud cover
    from a visual observation is available, this is used as well.

    The objects currently stored in FMCOL files and their numbering is:
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
    plotAVHRRsig(dataset,feature="a1/soz", suncor=FALSE,soztv=90,sky="NA",mylevels=20)
}

\arguments{
    \item{dataset}{object to plot, must be created by \link{readfmcol} and
    contain at least AVHRR and possibly STDAT information}
    \item{feature}{which radiometric feature to plot. The options
    available are a1/soz, a2/soz, a3/soz, a2da1/soz, a3da1/soz, a3da1/t4,
    a3/a1, t4mt5/t4, t3mt4/t4.}
    \item{suncor}{logical telling whether visible information should be
    cosinus corrected for solar elevation}
    \item{soztv}{threshold value to truncate visible channels at}
    \item{sky}{string identifying whether cloud cover cinditions should be
    incurred from STDAT information and used to filter information.
    Possible values are "NA", "oc" and "cl" representing No filtering,
    overcast and clear respectively.}
    \item{mylevels}{the number of groups to divide data in when creating
    contours}
}

\value{
    A \link{data.frame} if histogram was chosen. 
}

\seealso{
    \link{readfmcol}
}

\author{
    Øystein Godøy (\email{o.godoy@met.no})
}

\examples{
    t <- plotAVHRRsig(dataset="/disk2/collocate/output/cloud_20070831.hdf5")
}

\keyword{
}

\note{
}
