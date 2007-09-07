/*
 * NAME:
 * readssidev.c
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
 * The same files as for DLI are used, thus the DLIDEV keyword is used
 * herein.
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
 * $Id: readssidev.c,v 1.1 2007-09-07 17:03:00 steingod Exp $
 */

#ifdef HAVE_LIBHDF5

#include <readdlidev.h>
#include <unistd.h>
#include <dirent.h>
#include <time.h>
#include <utime.h>
#include <sys/types.h>
#include <sys/stat.h>

/*
int sm_debug=1;
*/

void readssidev(char **infile, int *n, int *p, char **station, 
	int *start, int *end,
	int *mytime,
	double *k1, double *k2, 
	double *k3a, double *k3b, 
	double *k4, double *k5,
	double *soz, double *saz, double *raz,
	double *t2m, double *ps, double *pw,
	int *cm,
	double *ssi) {

    /* General variables */
    char *where="readssidev";
    int i, j, k;
    int status, noobs;
    as_data *asdata;
    ns_data *nsdata;
    safcm_data2 *cmdata;
    safssi_data *ssidata;
    skeys scrit = {"DLIDEV","NA",0,0};
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

    if ((noobs=read1245(*infile, &scrit, 
		    &asdata, &nsdata, &cmdata, &ssidata)) <= 0) {
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
    printf(" noobs: %d, p: %d\n", noobs, *p);
    j=0;
    for (k=0;k<noobs;k++) {
	for (i=0;i<*p;i++) {
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
	    t2m[j] = (double) nsdata[k].t2m[0];
	    ps[j] = (double) nsdata[k].ps[0];
	    pw[j] = (double) nsdata[k].pw[0];
	    cm[j] = (int) cmdata[k].data[i];
	    ssi[j] = (double) ssidata[k].data[i];
	    j++;
	}
    }
    /*
    printf(" Max utime: %d\n Min utime: %d\n",(int) mymax,(int) mymin);
    */

    return;
}

#endif
