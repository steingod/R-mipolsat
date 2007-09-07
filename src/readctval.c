/*
 * NAME:
 * readctval.c
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
 * NA
 *
 * AUTHOR:
 * Øystein Godøy, MET/FOU, 21.01.2003
 *
 * MODIFIED:
 * NA
 *
 * CVS_ID:
 * $Id: readctval.c,v 1.1 2007-09-07 17:03:00 steingod Exp $
 */

#ifdef HAVE_LIBHDF5

#include <readctval.h>
#include <unistd.h>
#include <dirent.h>
#include <time.h>
#include <utime.h>
#include <sys/types.h>
#include <sys/stat.h>

int sm_debug=1;

void readctval(char **infile, int *n, int *p, char **station, 
	int *start, int *end,
	int *stid, int *mytime,
	int *N, int *CL, int *CM, int *CH, 
	int *E, int *sss, int *cm) {

    /* General variables */
    char *where="readctval";
    int i, j, k;
    int status, noobs;
    int allmissing=0;
    obsstruct *sobs=NULL;
    as_data *asdata=NULL;
    ns_data *nsdata=NULL;
    safcm_data2 *cmdata=NULL;
    safssi_data *ssidata=NULL;
    /*skeys scrit = {"CTVAL","NA",0,0};*/
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

    if ((noobs=read34(*infile, &scrit, &sobs, &cmdata)) <= 0) {
	error(where," File trouble...");
    }
    if (noobs != *n) {
	error(where,"Allocated space differs...");
	printf(" %d %d\n", noobs, *n);
	return;
    }
    printf("Data read from HDF5 file...\n");

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
	if (sobs[k].N < 0 || sobs[k].N > 8) {
	    (*n)--;
	    continue;
	}
	if (cmdata[k].nopix < 0 || cmdata[k].nopix > 169) {
	    (*n)--;
	    continue;
	}
	for (i=0;i<cmdata[k].nopix;i++) {
	    stid[j] = atoi(sobs[k].stID);
	    mytime[j] = (int) vt;
	    N[j] = (int) sobs[k].N;
	    CL[j] = (int) sobs[k].Cl;
	    CM[j] = (int) sobs[k].Cm;
	    CH[j] = (int) sobs[k].Ch;
	    E[j] = (int) sobs[k].E;
	    sss[j] = (int) sobs[k].sss;
	    cm[j] = (int) cmdata[k].data[i];
	    if (cmdata[k].data[i] == 0) allmissing++;
	    j++;
	}
	if (allmissing == cmdata[k].nopix) {
	    printf("No valid pixels in this tile\n");
	    printf(" %d", j);
	    j -= allmissing;
	    printf(" %d\n", j);
	    (*n)--;
	}
	allmissing = 0;
    }
    printf(" Max utime: %d\n Min utime: %d\n",(int) mymax,(int)mymin);

    if (cmdata != NULL) {
	printf("Freeing FMCOL's CMDATA data structure.\n");
	free(cmdata);
    }
    if (sobs != NULL) {
	printf("Freeing FMCOL's SYNOP data structure.\n");
	free(sobs);
    }

    printf(" noobs: %d n: %d\n", noobs, (*n));

    return;
}

#endif
