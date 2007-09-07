/*
 * NAME:
 * checkrecdli.c
 *
 * PURPOSE:
 * To check number of records stored in NCSA HDF5 files by software collocate...
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
 * $Id: checkrecdli.c,v 1.1 2007-09-07 17:03:00 steingod Exp $
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

void checkrecdli(char **infile, int *noobs, 
	char **classname, char **station,
	int *start, int *end) {

    char *where="checkrecdli";
    skeys scrit = {"DLIDEV","NA",0,0};

    sprintf(scrit.classname,"%s",*classname);
    sprintf(scrit.station,"%s",*station);
    scrit.t_start = (time_t) *start;
    scrit.t_end = (time_t) *end;
    printf(" > time period: %d %d\n",(int) scrit.t_start,(int) scrit.t_end);
    printf(" > classname: %s\n",scrit.classname);
    printf(" >   station: %s\n",scrit.station);

    if ((*noobs=checknorec(*infile, &scrit)) <= 0) {
	error(where,"File trouble, or no data found...");
	printf(" Return value: %d\n", *noobs);
    }

    return;
}

#endif
