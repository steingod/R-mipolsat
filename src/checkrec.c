/*
 * NAME:
 * checkrecdli.c
 *
 * PURPOSE:
 * REQUIREMENTS:
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
 * $Id: checkrec.c,v 1.2 2008-02-28 18:51:48 steingod Exp $
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

void checkrec(char **infile, int *noobs, 
	char **classname, char **station,
	int *start, int *end) {

    char *where="checkrec";
    skeys scrit = {"cloud","NA",0,0};

    sprintf(scrit.classname,"%s",*classname);
    sprintf(scrit.station,"%s",*station);
    scrit.t_start = (time_t) *start;
    scrit.t_end = (time_t) *end;
    /*
    printf(" > %d %d\n", (int) scrit.t_start,(int) scrit.t_end);
    printf(" > %s\n",scrit.classname);
    */
    fmlogmsg(where,"Searching for class %s and time period %d - %d",
    scrit.classname, (int) scrit.t_start, (int) scrit.t_end);

    if ((*noobs=checknorec(*infile, &scrit)) <= 0) {
	error(where,"File trouble, or no data found...");
	printf(" Return value: %d\n", *noobs);
    }

    fmlogmsg(where,"Number of matching recoords retrieved");

    return;
}


#endif
