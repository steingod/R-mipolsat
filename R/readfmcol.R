readfmcol <- function(filelist, method, classname="cloud",
station="NA",start="NA",end="NA") {

    t <- vector(mode="list", length=length(filelist))

    for (i in 1:length(filelist)) {
	cat(paste("Reading file:",filelist[i],"\n"))
	t[[i]] <- read124(filelist[i],classname,station,start,end)
    }

    mydata <- fmcolcat(t)

    return(mydata)
}

fmcolcat <- function(mylists) {

    ##mydata <- c(mylists[[1:length()]])

    return(mydata)
}
