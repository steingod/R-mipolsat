#
# $Id: plotAVHRRsig.R,v 1.3 2013-05-08 11:03:29 steingod Exp $
#

plotAVHRRsig <- function(dataset,feature="a1/soz",suncor=FALSE,soztv=90,sky="NA",mylevels=20) {

    if (missing(dataset)) {
        cat("Husk at objektnavn må oppgis...\n")
        return;
    }

    if (sky == "oc") {
        dataset$soz[dataset$N < 7]<-NA
        dataset$k1[is.na(dataset$soz)]<-NA
        dataset$k2[is.na(dataset$soz)]<-NA
        dataset$k3[is.na(dataset$soz)]<-NA
        dataset$k4[is.na(dataset$soz)]<-NA
        dataset$k5[is.na(dataset$soz)]<-NA
    } else if (sky == "cl") {
        dataset$soz[dataset$N > 1]<-NA
        dataset$k1[is.na(dataset$soz)]<-NA
        dataset$k2[is.na(dataset$soz)]<-NA
        dataset$k3[is.na(dataset$soz)]<-NA
        dataset$k4[is.na(dataset$soz)]<-NA
        dataset$k5[is.na(dataset$soz)]<-NA
    }

    sozgroups <- c(seq(0,90,2),100,200)
    soztics <- c(seq(1,90,2),95,150)
    a1groups <- c(seq(0,100,2), 200)
    a1tics <- c(seq(1,100,2),150)
    a2groups <- a1groups
    a2tics <- a1tics
    a3groups <- a1groups
    a3tics <- a1tics
    a2da1groups <- c(0.,0.05,0.1,0.15,0.2,0.25,0.3,0.35,0.4,0.45,0.5,
                     0.55,0.6,0.65,0.7,0.75,0.8,0.85,0.9,0.95,1.0,
                     1.05,1.1,1.15,1.2,1.25,1.3,1.35,1.4,1.45,1.5,1.6,1.7,
                     1.8,1.9,2.0,2.5,3.0,4.0,5.0,6.0,10.0,15)
    a2da1tics <- c(seq(0.025,1.5,0.05),
                   seq(1.55,2.0,0.1),2.25,2.75,seq(3.5,6.,1.),8,12.5)
    a3da1groups <- a2da1groups
    a3da1tics <- a2da1tics
    t4groups <- seq((min(dataset$k4)-2),(max(dataset$k4)+2),2)
    t4tics <- seq(min(dataset$k4),max(dataset$k4)+2,2)
    tmp <- dataset$k4-dataset$k5
    t4mt5groups <- seq(min(tmp)-0.2,max(tmp)+0.2,length.out=101)
    t4mt5tics <- seq(min(tmp),max(tmp)+0.2,length.out=100)
    tmp <- dataset$k3b-dataset$k4
    t3mt4groups <- seq(min(tmp)-0.2,max(tmp)+0.2,length.out=101)
    t3mt4tics <- seq(min(tmp),max(tmp)+0.2,length.out=100)

    if (feature=="a1/soz") {
        dataset$soz[dataset$soz>soztv]<-NA
        dataset$k1[is.na(dataset$soz)]<-NA
        myxlim <- c(min(a1tics),max(a1tics))
        myylim <- c(min(soztics),max(soztics))
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
        myxlim <- c(min(a2tics),max(a2tics))
        myylim <- c(min(soztics),max(soztics))
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
        myxlim <- c(0,100)
        myylim <- c(0,2)
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
        #dataset$k3c[dataset$k3c==1]<-NA
        #dataset$k1[is.na(dataset$k3c)]<-NA
        #dataset$k1[is.na(dataset$soz)]<-NA
        #dataset$k3[is.na(dataset$k3c)]<-NA
        #dataset$k3[is.na(dataset$soz)]<-NA
        tmp <- dataset$k3a/dataset$k1
        myhist1 <- hist(tmp,breaks=a3da1groups,probability=T)
        myhist2 <- hist(dataset$soz,breaks=sozgroups,probability=T)
        myxlim <- c(0,100)
        myylim <- c(0,2)
        mymatrix <- as.matrix(table(
                        cut(dataset$soz,sozgroups),
                        cut(tmp,a3da1groups)))
        myxlab <- "soz"
        myylab <- "A3/A1"
        xtic <- soztics
        ytic <- a3da1tics
    } else if (feature=="a3da1/t4") {
        dataset$soz[dataset$soz>soztv]<-NA
        #dataset$k3c[dataset$k3c==1]<-NA
        #dataset$k1[is.na(dataset$k3c)]<-NA
        #dataset$k1[is.na(dataset$soz)]<-NA
        #dataset$k3[is.na(dataset$k3c)]<-NA
        #dataset$k3[is.na(dataset$soz)]<-NA
        #dataset$k4[is.na(dataset$k3c)]<-NA
        #dataset$k4[is.na(dataset$k1)]<-NA
        #dataset$k4[dataset$k4<250]<-NA
        tmp <- dataset$k3a/dataset$k1
        myhist1 <- hist(tmp,breaks=a3da1groups,probability=T)
        myhist2 <- hist(dataset$k4,breaks=t4groups,probability=T)
        myxlim <- c(200,300)
        myylim <- c(0,2)
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
    }
    
    def.par <- par(no.readonly = TRUE)
    par("mar" = c(4,4,1,1))

    layout(matrix(c(2,1,1,2,1,1,4,3,3),3,3,byrow=T))
    if (length(mylevels)>1) {
        contour(xtic,ytic,mymatrix,levels=mylevels,
                xlab=myxlab,ylab=myylab,xlim=myxlim,ylim=myylim)
    } else {
        contour(xtic,ytic,mymatrix,nlevels=mylevels,
                xlab=myxlab,ylab=myylab,xlim=myxlim,ylim=myylim)
    }
    barplot(-(myhist1$intensities),horiz=TRUE)
    barplot(-(myhist2$intensities))
    plot(0,0, type="n",axes=F,ann=F)
    mytext <- paste("NOBS: ",sum(dataset$noobs),
                "\nTime span: ",format(min(dataset$tid),"%d.%m.%Y")," - ",
                format(max(dataset$tid),"%d.%m.%Y"),collapse="\n")
    text(0,0,labels=mytext)
    title(paste(feature,"for",dataset$classname[1],sep=" "))
    par(def.par)

    return
}
