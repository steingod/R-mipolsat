compareAVHRRchains <- function(chain1, chain2, area="ns") {

    if (missing(chain1) || missing (chain2)) {
	return("Remember to provide paths to chains\n")
    }

    filelist1 <- list.files(chain1,pattern=paste(area,"(\.aha)$",sep=""))
    filelist2 <- list.files(chain2,pattern=paste(area,"(\.aha)$",sep=""))

    tmp_f1 <- substr(filelist1,start=0,stop=26)
    tmp_f2 <- substr(filelist2,start=0,stop=26)

    mymatches <- charmatch(tmp_f1,tmp_f2)

    fl1 <- filelist1[!is.na(mymatches)]
    fl2 <- filelist2[mymatches[!is.na(mymatches)]]

    if (length(fl1) != length(fl2)) 
	return("Different length of filelists")

    maxchannels <- 10
    mydiff <- array(dim=c(maxchannels,length(fl1)))

    for (i in 1:length(fl1)) {
	cat(paste("Processing files:\n", fl1[i],"\nand\n",fl2[i],"\n"))
	d1 <- readAVHRR(paste(chain1,fl1[i],sep="/"))
	d2 <- readAVHRR(paste(chain2,fl2[i],sep="/"))
	for (j in 1:d1$header$z) {
	    if (j>maxchannels) return("Increase maxchannels...")
	    m1 <- mean(d1$data[,j],na.rm=T)
	    m2 <- mean(d2$data[,j],na.rm=T)
	    mydiff[j,i] <- m1-m2
	}
    }

    layout(matrix(c(1,2,3,4),ncol=1,nrow=4))
    plot(mydiff[1,],type="b",xlab="AVHRR channel 1",ylab="")
    abline(h=0)
    plot(mydiff[2,],type="b",xlab="AVHRR channel 2",ylab="")
    abline(h=0)
    plot(mydiff[4,],type="b",xlab="AVHRR channel 4",ylab="")
    abline(h=0)
    plot(mydiff[5,],type="b",xlab="AVHRR channel 5",ylab="")
    abline(h=0)

    return(mydiff)
}
