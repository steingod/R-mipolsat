#
# NAME:
# NA
#
# PURPOSE:
# NA
#
# REQUIREMENTS:
# NA
#
# INPUT:
# NA
#
# OUTPUT:
# NA
#
# NOTES:
# NA
#
# BUGS:
# NA
#
# AUTHOR:
# NA
#
# MODIFIED:
# Øystein Godøy, METNO/FOU, 2013-04-12 
#
# CVS_ID:
# $Id: ch3brefl.R,v 1.6 2013-04-12 10:29:24 steingod Exp $
#  

FM_PLANCKC1 <- 1.1910427e-5
FM_PLANCKC2 <- 1.4387752

fm_ch3brefl <- function(bt3b, bt4, solang, date, satname) {

    if (length(bt3b) != length(bt4)) {
	return("bt3b and bt4 length differs...")
    }
    satid <- rep(satname,length(bt3b))

    lumch3b <- fm_temp2rad(bt3b,satid)

    ch3bthermrad <-  fm_temp2rad(bt4,satid)

    lumsolar <- fm_findsollum(solang,satid,date)

    ch3brefl <- (lumch3b - ch3bthermrad)/(lumsolar - ch3bthermrad)

    ch3brefl <- ch3brefl*100. 

    return(ch3brefl)
} 

fm_bidirrefl <- function(refl, date, solang) {

    dcorr <- fm_esd(as.numeric(format(date,"%j")))
    bidirref <- (dcorr*refl)/(cos(solang*pi/180.));

    return(bidirref)
}

fm_temp2rad <- function(bt,satname) {

    satCs <- fm_ch3b_identsat(satname)

    efftemp <-  satCs$Aval+satCs$Bval*bt
    radiance <- (satCs$cwn^3.)*FM_PLANCKC1/
	(exp(FM_PLANCKC2*satCs$cwn/efftemp)-1.)

    return(radiance)
}

fm_rad2temp <- function(radiance,satname) { 

    satCs <- fm_ch3b_identsat(satname)
    efftemp <- FM_PLANCKC2*satCs$cwn/
	logf(FM_PLANCKC1*(satCs$cwn^3.)/radiance+1.)
    temp <- (efftemp - satCs$Aval)/satCs$Bval

    return(temp)
} 

fm_esd <- function(doy) {

    theta0 <- (2.*pi*doy)/365.
    d <- (1.000110
	+0.034221*cos(theta0)
	+0.001280*sin(theta0)
	+0.000719*cos(2.*theta0)
	+0.000077*sin(2.*theta0))

    return(d)
}

fm_findsollum <- function(solang, satname, date) {

    satCs <- fm_ch3b_identsat(satname)
    dcorr <- fm_esd(as.numeric(format(date,"%j")))
    solangrad <- solang*pi/180.
    sollum <- dcorr*satCs$solrad*cos(solangrad) 

    return(sollum) 
}  

fm_ch3b_identsat <- function(satname) {

    satCs <- list()
    satCs$satID <- satname
    if (satCs$satID == "NOAA-15") {
	satCs$Aval <- 1.621256
	satCs$Bval <- 0.998015
	satCs$cwn <- 2695.9743
	satCs$solrad <- 5.153
    } else if (satCs$satID == "NOAA-16"){ 
	satCs$Aval <- 1.592459
	satCs$Bval <- 0.998147
	satCs$cwn <- 2700.1148
	satCs$solrad <- 5.099
    } else if (satCs$satID == "NOAA-17"){ 
	satCs$Aval <- 1.702380
	satCs$Bval <- 0.997378
	satCs$cwn <- 2669.3554
	satCs$solrad <- 5.070
    } else if (satCs$satID == "NOAA-18"){ 
	satCs$Aval <- 1.698704
	satCs$Bval <- 0.996960
	satCs$cwn <- 2659.7952
	satCs$solrad <- 5.043
    } else {
	return("Could not recognise satellite")
    }

    return(satCs)
}


