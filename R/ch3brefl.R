fm_ch3brefl <- function(bt3b, bt4, solang, satname) {

    lumch3b <- fm_temp2rad(bt3b,satname)

    ch3bthermrad <-  fm_temp2rad(bt4,satname)

    lumsolar <- findsollum(solang)

    ch3brefl <- (lumch3b - ch3bthermrad)/(lumsolar - ch3bthermrad)

    ch3brefl <- ch3brefl*100. 

    return(ch3brefl)
} 

fm_temp2rad <- function(bt,satname) {

    satCs <- fm_ch3b_identsat(satname)

    efftemp <-  satCs$Aval+satCs$Bval*bt
    radiance <- powf(satCs$cwn,3.)*FM_PLANCKC1/
	(expf(FM_PLANCKC2*satCs$cwn/efftemp)-1.)

    return(radiance)
}

fm_rad2temp <- function(radiance,satname) { 

    satCs <- fm_ch3b_identsat(satname)
    efftemp <- FM_PLANCKC2*satCs$cwn/
	logf(FM_PLANCKC1*powf(satCs$cwn,3.)/radiance+1.)
    temp <- (efftemp - satCs$Aval)/satCs$Bval

    return(temp)
} 

fm_findsollum <- function(solang) {

    solangrad <- solang*pi/180.
    sollum <- FM_SOLCONSTCH3B*cosf(solangrad) 

    return(sollum) 
}  

fm_ch3b_identsat <- function(satname) {

    satCs$satID <- satname
    if (satCs$satID == "NOAA-15") {
	satCs.Aval <- 1.621256
	satCs.Bval <- 0.998015
	satCs.cwn <- 2695.9743
    } else if (satCs$satID == "NOAA-16"){ 
	satCs$Aval <- 1.592459
	satCs$Bval <- 0.998147
	satCs$cwn <- 2700.1148
    } else if (satCs$satID == "NOAA-17"){ 
	satCs$Aval <- 1.702380
	satCs$Bval <- 0.997378
	satCs$cwn <- 2669.3554
    } else if (satCs$satID == "NOAA-18"){ 
	satCs$Aval <- 1.698704
	satCs$Bval <- 0.996960
	satCs$cwn <- 2659.7952
    } else {
	return("Could not recognise satellite")
    }

    return(satCs)
}


