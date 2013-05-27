#
# $Id: plotAVHRRsig.R,v 1.10 2013-05-27 15:17:18 steingod Exp $
#

plotAVHRRsig <- function(dataset,
                         feature="a1/soz",
                         suncor=FALSE,
                         image=FALSE,
                         soztv=90,
                         sky="NA",
                         ppsclass=0,
                         mylevels=20) {

    if (missing(dataset)) {
        cat("Husk at objektnavn må oppgis...\n")
        return;
    }

    # Check that this element can be used in filtering
    if ("N" %in% names(dataset)) {
        if (sky == "oc") {
            dataset$soz[dataset$N < 7]<-NA
            dataset$raz[dataset$N < 7]<-NA
            dataset$saz[dataset$N < 7]<-NA
            dataset$k1[is.na(dataset$soz)]<-NA
            dataset$k2[is.na(dataset$soz)]<-NA
            dataset$k3a[is.na(dataset$soz)]<-NA
            dataset$k3b[is.na(dataset$soz)]<-NA
            dataset$k4[is.na(dataset$soz)]<-NA
            dataset$k5[is.na(dataset$soz)]<-NA
        } else if (sky == "cl") {
            dataset$soz[dataset$N > 1]<-NA
            dataset$raz[dataset$N < 7]<-NA
            dataset$saz[dataset$N < 7]<-NA
            dataset$k1[is.na(dataset$soz)]<-NA
            dataset$k2[is.na(dataset$soz)]<-NA
            dataset$k3a[is.na(dataset$soz)]<-NA
            dataset$k3b[is.na(dataset$soz)]<-NA
            dataset$k4[is.na(dataset$soz)]<-NA
            dataset$k5[is.na(dataset$soz)]<-NA
        }
    }
    if ("cm" %in% names(dataset)) {
        if (ppsclass > 0) {
            dataset$soz[dataset$cm != ppsclass]<-NA
            dataset$raz[dataset$cm != ppsclass]<-NA
            dataset$saz[dataset$cm != ppsclass]<-NA
            dataset$k1[is.na(dataset$soz)]<-NA
            dataset$k2[is.na(dataset$soz)]<-NA
            dataset$k3a[is.na(dataset$soz)]<-NA
            dataset$k3b[is.na(dataset$soz)]<-NA
            dataset$k4[is.na(dataset$soz)]<-NA
            dataset$k5[is.na(dataset$soz)]<-NA
        }
    }

    sozgroups <- seq(min(dataset$soz,na.rm=T)-2,max(dataset$soz,na.rm=T)+2,2)
    soztics <- seq(min(dataset$soz,na.rm=T),max(dataset$soz,na.rm=T)+2,2)
    a1groups <- seq(min(dataset$k1,na.rm=T)-2,max(dataset$k1,na.rm=T)+2,2)
    a1tics <- seq(min(dataset$k1,na.rm=T),max(dataset$k1,na.rm=T)+2,2)
    a2groups <- a1groups
    a2tics <- a1tics
    a3groups <- a1groups
    a3tics <- a1tics
    a2da1groups <- seq(min(dataset$k2/dataset$k1,na.rm=T)-0.05,
                       max(dataset$k2/dataset$k1,na.rm=T)+0.05,
                       0.05)
    a2da1tics <- seq(min(dataset$k2/dataset$k1,na.rm=T),
                       max(dataset$k2/dataset$k1,na.rm=T)+0.05,
                       0.05)
    a3da1groups <- a2da1groups
    a3da1tics <- a2da1tics
    t4groups <- seq((min(dataset$k4,na.rm=T)-2),(max(dataset$k4,na.rm=T)+2),2)
    t4tics <- seq(min(dataset$k4,na.rm=T),max(dataset$k4,na.rm=T)+2,2)
    tmp <- dataset$k4-dataset$k5
    t4mt5groups <- seq(min(tmp,na.rm=T)-0.2,max(tmp,na.rm=T)+0.2,length.out=101)
    t4mt5tics <- seq(min(tmp,na.rm=T),max(tmp,na.rm=T)+0.2,length.out=100)
    tmp <- dataset$k3b-dataset$k4
    t3mt4groups <- seq(min(tmp,na.rm=T)-0.2,max(tmp,na.rm=T)+0.2,length.out=101)
    t3mt4tics <- seq(min(tmp,na.rm=T),max(tmp,na.rm=T)+0.2,length.out=100)

    if (feature=="a1/soz") {
        dataset$soz[dataset$soz>soztv]<-NA
        dataset$k1[is.na(dataset$soz)]<-NA
        myxlim <- c(min(soztics),max(soztics))
        myylim <- c(min(a1tics),max(a1tics))
        if (suncor) {
            dataset$k1 <- dataset$k1/cos((dataset$soz)*pi/180.)
        }
        myhist1 <- hist(dataset$k1,breaks=a1groups,probability=T)
        myhist2 <- hist(dataset$soz,breaks=sozgroups,probability=T)
        mymatrix <- as.matrix(table(
                        cut(dataset$soz,sozgroups),
                        cut(dataset$k1,a1groups)))
        myxlab <- "soz"
        myylab <- "A1"
        xtic <- soztics
        ytic <- a1tics
    } else if (feature=="a2/soz") {
        dataset$soz[dataset$soz>soztv]<-NA
        dataset$k2[is.na(dataset$soz)]<-NA
        myxlim <- c(min(soztics),max(soztics))
        myylim <- c(min(a2tics),max(a2tics))
        if (suncor) {
            dataset$k2 <- dataset$k2/cos((dataset$soz)*pi/180.)
        }
        myhist1 <- hist(dataset$k2,breaks=a2groups,probability=T)
        myhist2 <- hist(dataset$soz,breaks=sozgroups,probability=T)
        mymatrix <- as.matrix(table(
                        cut(dataset$soz,sozgroups),
                        cut(dataset$k2,a2groups)))
        myxlab <- "soz"
        myylab <- "A2"
        xtic <- soztics
        ytic <-  a2tics
    } else if (feature=="a3/soz") {
        dataset$soz[dataset$soz>soztv]<-NA
        if (suncor) {
            dataset$k3a <- dataset$k3a/cos((dataset$soz)*pi/180.)
        }
        myhist1 <- hist(dataset$k3a,breaks=a3groups,probability=T)
        myhist2 <- hist(dataset$soz,breaks=sozgroups,probability=T)
        myxlim <- c(min(a3tics),max(a3tics))
        myylim <- c(min(soztics),max(soztics))
        mymatrix <- as.matrix(table(
                        cut(dataset$soz,sozgroups),
                        cut(dataset$k3a,a3groups)))
        myxlab <- "soz"
        myylab <- "A3"
        xtic <- soztics
        ytic <- a3tics
    } else if (feature=="a2da1/soz") {
        dataset$soz[dataset$soz>soztv]<-NA
        dataset$k1[is.na(dataset$soz)]<-NA
        dataset$k2[is.na(dataset$soz)]<-NA
        tmp <- dataset$k2/dataset$k1
        myxlim <- c(min(soztics),max(soztics))
        myylim <- c(min(a2da1tics),max(a2da1tics))
        myhist1 <- hist(tmp,breaks=a2da1groups,probability=T)
        myhist2 <- hist(dataset$soz,breaks=sozgroups,probability=T)
        mymatrix <- as.matrix(table(
                        cut(dataset$soz,sozgroups),
                        cut(tmp,a2da1groups)))
        myxlab <- "soz"
        myylab <- "A2/A1"
        xtic <- soztics
        ytic <- a2da1tics
    } else if (feature=="a3da1/soz") {
        dataset$soz[dataset$soz>soztv]<-NA
        tmp <- dataset$k3a/dataset$k1
        myhist1 <- hist(tmp,breaks=a3da1groups,probability=T)
        myhist2 <- hist(dataset$soz,breaks=sozgroups,probability=T)
        myxlim <- c(min(soztics),max(soztics))
        myylim <- c(min(a3da1tics),max(a3da1tics))
        mymatrix <- as.matrix(table(
                        cut(dataset$soz,sozgroups),
                        cut(tmp,a3da1groups)))
        myxlab <- "soz"
        myylab <- "A3/A1"
        xtic <- soztics
        ytic <- a3da1tics
    } else if (feature=="a3da1/t4") {
        dataset$soz[dataset$soz>soztv]<-NA
        tmp <- dataset$k3a/dataset$k1
        myhist1 <- hist(tmp,breaks=a3da1groups,probability=T)
        myhist2 <- hist(dataset$k4,breaks=t4groups,probability=T)
        myxlim <- c(min(t4tics),max(t4tics))
        myylim <- c(min(a3da1tics),max(a3da1tics))
        mymatrix <- as.matrix(table(
                        cut(dataset$k4,t4groups),
                        cut(tmp,a3da1groups)))
        myxlab <- "T4"
        myylab <- "A3/A1"
        xtic <- t4tics
        ytic <- a3da1tics
    } else if (feature=="a3/a1") {
        dataset$soz[dataset$soz>soztv]<-NA
        if (suncor) {
            dataset$k1 <- dataset$k1/cos((dataset$soz)*pi/180.)
            dataset$k3a <- dataset$k3a/cos((dataset$soz)*pi/180.)
        }
        myhist1 <- hist(dataset$k3a,breaks=a3groups,probability=T)
        myhist2 <- hist(dataset$k1,breaks=a1groups,probability=T)
        myxlim <- c(min(a1tics),max(a1tics))
        myylim <- c(min(a3tics),max(a3tics))
        mymatrix <- as.matrix(table(
                        cut(dataset$k1,a1groups),
                        cut(dataset$k3,a3groups)))
        myxlab <- "A1"
        myylab <- "A3"
        xtic <- a1tics
        ytic <- a3tics
    } else if (feature=="t4mt5/t4") {
        tmp<-dataset$k4-dataset$k5
        myxlim <- c(min(t4tics),max(t4tics))
        myylim <- c(min(t4mt5tics),max(t4mt5tics))
        myhist1 <- hist(tmp,breaks=t4mt5groups,probability=T)
        myhist2 <- hist(dataset$k4,breaks=t4groups,probability=T)
        mymatrix <- as.matrix(table(
                        cut(dataset$k4,t4groups),
                        cut(tmp,t4mt5groups)))
        myxlab <- "T4"
        myylab <- "T4-T5"
        xtic <- t4tics
        ytic <- t4mt5tics
    } else if (feature=="t3mt4/t4") {
        tmp <- dataset$k3b-dataset$k4
        myxlim <- c(min(t4tics),max(t4tics))
        myylim <- c(min(t3mt4tics),max(t3mt4tics))
        myhist1 <- hist(tmp,breaks=t3mt4groups,probability=T)
        myhist2 <- hist(dataset$k4,breaks=t4groups,probability=T)
        mymatrix <- as.matrix(table(
                        cut(dataset$k4,t4groups),
                        cut(tmp,t3mt4groups)))
        myxlab <- "T4"
        myylab <- "T3-T4"
        xtic <- t4tics
        ytic <- t3mt4tics
    } else if (feature=="t3mt4/soz") {
        tmp <- dataset$k3b-dataset$k4
        myxlim <- c(min(soztics),max(soztics))
        myylim <- c(min(t3mt4tics),max(t3mt4tics))
        myhist1 <- hist(tmp,breaks=t3mt4groups,probability=T)
        myhist2 <- hist(dataset$soz,breaks=sozgroups,probability=T)
        mymatrix <- as.matrix(table(
                        cut(dataset$soz,sozgroups),
                        cut(tmp,t3mt4groups)))
        myxlab <- "soz"
        myylab <- "T3-T4"
        xtic <- soztics
        ytic <- t3mt4tics
    }
    
    def.par <- par(no.readonly = TRUE)
    par("mar" = c(4,4,1,1))

    layout(matrix(c(2,1,1,2,1,1,4,3,3),3,3,byrow=T))
    if (length(mylevels)>1) {
        if (image) {
            image(xtic,ytic,mymatrix,levels=mylevels,
                    xlab=myxlab,ylab=myylab,xlim=myxlim,ylim=myylim)
        } else { 
            contour(xtic,ytic,mymatrix,levels=mylevels,
                    xlab=myxlab,ylab=myylab,xlim=myxlim,ylim=myylim)
        }
    } else {
        if (image) {
            image(xtic,ytic,mymatrix,nlevels=mylevels,
                  xlab=myxlab,ylab=myylab,xlim=myxlim,ylim=myylim)
        } else {
            contour(xtic,ytic,mymatrix,nlevels=mylevels,
                    xlab=myxlab,ylab=myylab,xlim=myxlim,ylim=myylim)
        }
    }
    barplot(-(myhist1$intensities),horiz=TRUE)
    barplot(-(myhist2$intensities))
    plot(0,0, type="n",axes=F,ann=F)
    mytext <- paste("NOBS: ",sum(dataset$noobs),
                "\nTime span: ",format(min(dataset$tid),"%d.%m.%Y")," - ",
                format(max(dataset$tid),"%d.%m.%Y"),
                "\nPPS Class: ",ppsclass,collapse="\n")
    text(0,0,labels=mytext)
    title(paste(feature,"for",dataset$classname[1],sep=" "))
    par(def.par)

    return
}
