/*
 * NAME:
 * readsig.c
 *
 * PURPOSE:
 * To dump data stored in NCSA HDF5 files by software collocate...
 *
 * REQUIREMENTS:
 * NA
 *
 * INPUT:
 * NA
 *
 * OUTPUT:
 * NA
 *
 * NOTES:
 * NA
 *
 * BUGS:
 * Memory is yet not properly freed...
 *
 * AUTHOR:
 * Øystein Godøy, MET/FOU, 21.01.2003
 *
 * MODIFIED:
 * Øystein Godøy, met.no/FOU, 12.10.2004: See readsig.sl
 * Øystein Godøy, METNO/FOU, 2013-04-12: Changed usage of header files.
 *
 * CVS_ID:
 * $Id: read123.c,v 1.2 2013-04-12 10:29:24 steingod Exp $
 */

#ifdef HAVE_LIBHDF5

#include <readfmcol.h>
#include <unistd.h>
#include <dirent.h>
#include <time.h>
#include <utime.h>
#include <sys/types.h>
#include <sys/stat.h>

/*
int sm_debug=1;
*/

void Rread123(char **infile, int *n, int *p, char **station, 
	int *start, int *end,
	int *stid, int *mytime,
	int *N, 
	int *E, int *sss, 
	double *k1, double *k2, 
	double *k3a, double *k3b, 
	double *k4, double *k5,
	double *soz, double *saz, double *raz
	) {

    /* General variables */
    char *where="readsig";
    int i, j, k;
    int status, noobs;
    obsstruct *sobs=NULL;
    as_data *asdata=NULL;
    ns_data *nsdata=NULL;
    skeys scrit = {"cloud","NA",0,0};
    struct tm ut;
    time_t vt, mymax=0, mymin=INT_MAX;

    if (*p != BOXSIZE2D) {
	error(where,"BOXSIZE differs...");
	return;
    }

    sprintf(scrit.station,"%s",*station);
    scrit.t_start = (time_t) *start;
    scrit.t_end = (time_t) *end;
    printf(">> %d %d\n",(int) scrit.t_start,(int) scrit.t_end);

    if ((noobs=read123(*infile, &scrit, &asdata, &nsdata, &sobs)) <= 0) {
	error(where," File trouble...");
    }
    if (noobs != *n) {
	error(where,"Allocated space differs...");
	printf(" %d %d\n", noobs, *n);
	return;
    }

    /*
     * Retrieve data for analysis within R
     */
    j=0;
    for (k=0;k<noobs;k++) {
	ut.tm_year = ((sobs[k].year)-1900);
	ut.tm_mon = ((sobs[k].month)-1);
	ut.tm_mday = sobs[k].day;
	ut.tm_hour = sobs[k].hour;
	ut.tm_min = sobs[k].min;
	ut.tm_sec = 0;
	ut.tm_isdst = 0;
	vt = mktime(&ut);
	/*
	printf("%03d %d%02d%02d %02d:%02d - %d\n",
		k,
		sobs[k].year,sobs[k].month,sobs[k].day,
		sobs[k].hour,sobs[k].min,
		vt);
	*/
	if (vt<mymin) {
	    mymin=vt;
	}
	if (vt>mymax) {
	    mymax=vt;
	}
	/*
	printf(" AVHRR nopix: %d\n",asdata[k].nopix);
	*/
	for (i=0;i<asdata[k].nopix;i++) {
	    stid[j] = atoi(sobs[k].stID);
	    mytime[j] = (int) vt;
	    N[j] = (int) sobs[k].N;
	    /*
	    CL[j] = (int) sobs[k].Cl;
	    CM[j] = (int) sobs[k].Cm;
	    CH[j] = (int) sobs[k].Ch;
	    */
	    E[j] = (int) sobs[k].E;
	    sss[j] = (int) sobs[k].sss;
	    k1[j] = (double) asdata[k].ch1[i];
	    k2[j] = (double) asdata[k].ch2[i];
	    k3a[j] = (double) asdata[k].ch3a[i];
	    k3b[j] = (double) asdata[k].ch3b[i];
	    k4[j] = (double) asdata[k].ch4[i];
	    k5[j] = (double) asdata[k].ch5[i];
	    soz[j] = (double) asdata[k].ang.soz;
	    saz[j] = (double) asdata[k].ang.saz;
	    raz[j] = (double) asdata[k].ang.raz;
	    j++;
	}
    }
    /*
    printf(" Max utime: %d\n Min utime: %d\n",(int) mymax,(int) mymin);
    */
    
    if (asdata != NULL) {
	printf("Freeing FMCOL's AVHRR data structure.\n");
	free(asdata);
    }
    if (nsdata != NULL) {
	printf("Freeing FMCOL's NWP data structure.\n");
	free(nsdata);
    }
    if (sobs != NULL) {
	printf("Freeing FMCOL's SYNOP data structure.\n");
	free(sobs);
    }

    return;
}

#endif
