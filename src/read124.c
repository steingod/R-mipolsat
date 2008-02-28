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
 *
 * CVS_ID:
 * $Id: read124.c,v 1.1 2008-02-28 18:51:48 steingod Exp $
 */

#ifdef HAVE_LIBHDF5

#include <readctval.h>
#include <unistd.h>
#include <dirent.h>
#include <time.h>
#include <utime.h>
#include <sys/types.h>
#include <sys/stat.h>

/*
int sm_debug=1;
*/

void Rread124(char **infile, int *n, int *p, 
	char **classname, char **station, 
	int *start, int *end,
	int *mytime,
	double *k1, double *k2, 
	double *k3a, double *k3b, 
	double *k4, double *k5,
	double *soz, double *saz, double *raz,
	int *cm
	) {

    /* General variables */
    char *where="readsig";
    int i, j, k;
    int status, noobs;
    int allmissing=0;
    as_data *asdata=NULL;
    ns_data *nsdata=NULL;
    safcm_data2 *cmdata=NULL;
    skeys scrit = {"cloud","NA",0,0};
    struct tm ut;
    time_t vt, mymax=0, mymin=INT_MAX;

    if (*p != BOXSIZE2D) {
	fmerrmsg(where,"BOXSIZE (%d) differs from default (%d)...",
	*p, BOXSIZE2D);
	return;
    }

    sprintf(scrit.classname,"%s",*classname);
    sprintf(scrit.station,"%s",*station);
    scrit.t_start = (time_t) *start;
    scrit.t_end = (time_t) *end;
    fmlogmsg(where,"Searching for class %s and time period %d - %d",
	    scrit.classname, (int) scrit.t_start, (int) scrit.t_end);

    if ((noobs=read124(*infile, &scrit, &asdata, &nsdata, &cmdata)) <= 0) {
	fmerrmsg(where,"Trouble reading group or file");
	return;
    }
    if (noobs != *n) {
	fmerrmsg(where,
	"Something is wrong in memory allocation, asks for %d records and found %d", 
	*n, noobs);
	return;
    }

    /*
     * Retrieve data for analysis within R
     */
    j=0;
    for (k=0;k<noobs;k++) {
	/*
	ut.tm_year = ((sobs[k].year)-1900);
	ut.tm_mon = ((sobs[k].month)-1);
	ut.tm_mday = sobs[k].day;
	ut.tm_hour = sobs[k].hour;
	ut.tm_min = sobs[k].min;
	ut.tm_sec = 0;
	ut.tm_isdst = 0;
	vt = mktime(&ut);
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
	    mytime[j] = (int) asdata[k].vtime;
	    k1[j] = (double) asdata[k].ch1[i];
	    k2[j] = (double) asdata[k].ch2[i];
	    k3a[j] = (double) asdata[k].ch3a[i];
	    k3b[j] = (double) asdata[k].ch3b[i];
	    k4[j] = (double) asdata[k].ch4[i];
	    k5[j] = (double) asdata[k].ch5[i];
	    soz[j] = (double) asdata[k].ang.soz;
	    saz[j] = (double) asdata[k].ang.saz;
	    raz[j] = (double) asdata[k].ang.raz;
	    cm[j] = (int) cmdata[k].data[i];
	    if (cmdata[k].data[i] == 0) allmissing++;
	    j++;
	}
	if (allmissing == cmdata[k].nopix) {
	    fmlogmsg(where,"No valid pixels in this tile %d\n", j);
	    j -= allmissing;
	    printf(" %d\n", j);
	    (*n)--;
	}
	allmissing = 0;
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
    if (cmdata != NULL) {
	printf("Freeing FMCOL's CMDATA data structure.\n");
	free(cmdata);
    }

    return;
}

#endif
