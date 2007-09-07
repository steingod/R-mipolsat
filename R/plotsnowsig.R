#
# NAME:
# plotsnowsig
#
# PURPOSE:
# NA 
#
# NOTES:
# Not fully finished... 
#
# BUGS:
# Probably in the underlying C-function...
# C functions does not transfer strings back properly...
#
# AUTHOR:
# Øystein Godøy, MET/FOU, 30.01.2003
#

plotsnowsig <- function(myobject,type="a1/soz",correction=FALSE,soztv=90,sky="NA",mylevels=20) {

    if (missing(myobject)) {
	cat("Husk at objektnavn må oppgis...\n")
	return;
    }

    if (sky == "oc") {
	myobject$soz[myobject$N < 7]<-NA
	myobject$k1[is.na(myobject$soz)]<-NA
	myobject$k2[is.na(myobject$soz)]<-NA
	myobject$k3[is.na(myobject$soz)]<-NA
	myobject$k4[is.na(myobject$soz)]<-NA
	myobject$k5[is.na(myobject$soz)]<-NA
    } else if (sky == "cl") {
	myobject$soz[myobject$N > 1]<-NA
	myobject$k1[is.na(myobject$soz)]<-NA
	myobject$k2[is.na(myobject$soz)]<-NA
	myobject$k3[is.na(myobject$soz)]<-NA
	myobject$k4[is.na(myobject$soz)]<-NA
	myobject$k5[is.na(myobject$soz)]<-NA
    }

    sozgroups <- c(seq(0,90,2),100,200)
    soztics <- c(seq(1,90,2),95,150)
    a1groups <-c(0.,5.,10.,15.,20.,25.,30.,35.,40.,45.,50.,55.,
		60.,65.,70.,75.,80.,85.,90.,95.,100.,200.)
    a1tics <- c(seq(2.5,100,5),150)
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
    t4groups <- seq(200,300,2)
    t4tics <- seq(201,300,2)
    t4mt5groups <- seq(-20,20,0.2)
    t4mt5tics <- seq(-19.8,20,0.2)
    t3mt4groups <- seq(-20,20,0.2)
    t3mt4tics <- seq(-19.8,20,0.2)

    if (type=="a1/soz") {
	myobject$soz[myobject$soz>soztv]<-NA
	myobject$k1[is.na(myobject$soz)]<-NA
	myxlim <- c(0,100)
	myylim <- c(0,120)
	if (correction) {
	    myobject$k1 <- myobject$k1/cos((myobject$soz)*pi/180.)
	}
	mymatrix <-
	    as.matrix(table(
		cut(myobject$soz,sozgroups),
		cut(myobject$k1,a1groups)))
	myxlab <- "soz"
	myylab <- "A1"
	xtic <- soztics
	ytic <- a1tics
    } else if (type=="a2/soz") {
	myobject$soz[myobject$soz>soztv]<-NA
	myobject$k2[is.na(myobject$soz)]<-NA
	myxlim <- c(0,100)
	myylim <- c(0,120)
	if (correction) {
	    myobject$k2 <- myobject$k2/cos((myobject$soz)*pi/180.)
	}
	mymatrix <-
	    as.matrix(table(
		cut(myobject$soz,sozgroups),
		cut(myobject$k2,a2groups)))
	myxlab <- "soz"
	myylab <- "A2"
	xtic <- soztics
	ytic <-  a2tics
    } else if (type=="a3/soz") {
	myobject$soz[myobject$soz>soztv]<-NA
	myobject$k3[is.na(myobject$soz)]<-NA
	myobject$k3c[myobject$k3c==1]<-NA
	myobject$k3[is.na(myobject$k3c)]<-NA
	if (correction) {
	    myobject$k3 <- myobject$k3/cos((myobject$soz)*pi/180.)
	}
	myxlim <- c(0,100)
	myylim <- c(0,120)
	mymatrix <-
	    as.matrix(table(
		cut(myobject$soz,sozgroups),
		cut(myobject$k3,a3groups)))
	myxlab <- "soz"
	myylab <- "A3"
	xtic <- soztics
	ytic <- a3tics
    } else if (type=="a2da1/soz") {
	myobject$soz[myobject$soz>soztv]<-NA
	myobject$k1[is.na(myobject$soz)]<-NA
	myobject$k2[is.na(myobject$soz)]<-NA
	tmp<-myobject$k2/myobject$k1
	myxlim <- c(0,100)
	myylim <- c(0,2)
	mymatrix <-
	    as.matrix(table(
		cut(myobject$soz,sozgroups),
		cut(tmp,a2da1groups)))
	myxlab <- "soz"
	myylab <- "A2/A1"
	xtic <- soztics
	ytic <- a2da1tics
    } else if (type=="a3da1/soz") {
	myobject$soz[myobject$soz>soztv]<-NA
	myobject$k3c[myobject$k3c==1]<-NA
	myobject$k1[is.na(myobject$k3c)]<-NA
	myobject$k1[is.na(myobject$soz)]<-NA
	myobject$k3[is.na(myobject$k3c)]<-NA
	myobject$k3[is.na(myobject$soz)]<-NA
	tmp<-myobject$k3/myobject$k1
	#hist(tmp,breaks=a3da1groups,xlim=c(0,5))
	#return(tmp)
	myxlim <- c(0,100)
	myylim <- c(0,2)
	mymatrix <-
	    as.matrix(table(
		cut(myobject$soz,sozgroups),
		cut(tmp,a3da1groups)))
	myxlab <- "soz"
	myylab <- "A3/A1"
	xtic <- soztics
	ytic <- a3da1tics
    } else if (type=="a3da1/t4") {
	myobject$soz[myobject$soz>soztv]<-NA
	myobject$k3c[myobject$k3c==1]<-NA
	myobject$k1[is.na(myobject$k3c)]<-NA
	myobject$k1[is.na(myobject$soz)]<-NA
	myobject$k3[is.na(myobject$k3c)]<-NA
	myobject$k3[is.na(myobject$soz)]<-NA
	myobject$k4[is.na(myobject$k3c)]<-NA
	myobject$k4[is.na(myobject$k1)]<-NA
	myobject$k4[myobject$k4<250]<-NA
	tmp<-myobject$k3/myobject$k1
	#hist(tmp,breaks=a3da1groups,xlim=c(0,5))
	#return(tmp)
	myxlim <- c(200,300)
	myylim <- c(0,2)
	mymatrix <-
	    as.matrix(table(
		cut(myobject$k4,t4groups),
		cut(tmp,a3da1groups)))
	myxlab <- "T4"
	myylab <- "A3/A1"
	xtic <- t4tics
	ytic <- a3da1tics
    } else if (type=="a3/a1") {
	myobject$soz[myobject$soz>soztv]<-NA
	myobject$k3c[myobject$k3c==1]<-NA
	myobject$k1[is.na(myobject$k3c)]<-NA
	myobject$k1[is.na(myobject$soz)]<-NA
	myobject$k3[is.na(myobject$k3c)]<-NA
	myobject$k3[is.na(myobject$soz)]<-NA
	#hist(tmp,breaks=a3da1groups,xlim=c(0,5))
	#return(tmp)
	if (correction) {
	    myobject$k1 <- myobject$k1/cos((myobject$soz)*pi/180.)
	    myobject$k3 <- myobject$k3/cos((myobject$soz)*pi/180.)
	}
	myxlim <- c(0,100)
	myylim <- c(0,100)
	mymatrix <-
	    as.matrix(table(
		cut(myobject$k1,a1groups),
		cut(myobject$k3,a3groups)))
	myxlab <- "A1"
	myylab <- "A3"
	xtic <- a1tics
	ytic <- a3tics
    } else if (type=="t4-t5/t4") {
	tmp<-myobject$k4-myobject$k5
	myxlim <- c(200,300)
	myylim <- c(-20,20)
	mymatrix <-
	    as.matrix(table(
		cut(myobject$k4,t4groups),
		cut(tmp,t4mt5groups)))
	myxlab <- "T4"
	myylab <- "T4-T5"
	xtic <- t4tics
	ytic <- t4mt5tics
    } else if (type=="t3-t4/t4") {
	myobject$k3c[myobject$k3c==0]<-NA
	myobject$k3[is.na(myobject$k3c)]<-NA
	tmp<-myobject$k3-myobject$k4
	myxlim <- c(200,300)
	myylim <- c(-20,20)
	mymatrix <-
	    as.matrix(table(
		cut(myobject$k4,t4groups),
		cut(tmp,t3mt4groups)))
	myxlab <- "T4"
	myylab <- "T3-T4"
	xtic <- t4tics
	ytic <- t3mt4groups
    }
    return

    if (length(mylevels)>1) {
	contour(xtic,ytic,mymatrix,levels=mylevels,
	    xlab=myxlab,ylab=myylab,xlim=myxlim,ylim=myylim)
    } else {
	contour(xtic,ytic,mymatrix,nlevels=mylevels,
	    xlab=myxlab,ylab=myylab,xlim=myxlim,ylim=myylim)
    }
    title(paste("Station id: ",myobject$station,
	", NOBS: ",myobject$noobs,
	"\nTime span: ",format(min(myobject$tid),"%d.%m.%Y")," - ",
	format(max(myobject$tid),"%d.%m.%Y")))

    return(mymatrix)
}
