/*
 * NAME:
 * checkrec.c
 *
 * PURPOSE:
 * To get the number of records within the file.
 *
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
 * Øystein Godøy, METNO/FOU, 2013-04-12: Changed usage of header files.
 *
 * CVS_ID:
 * $Id: checkrec.c,v 1.5 2013-05-07 08:37:11 steingod Exp $
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

void checkrec(char **infile, int *noobs, 
        char **classname, char **station,
        int *start, int *end) {

    char *where="checkrec";
    skeys scrit = {"cloud","NA",0,0};

    sprintf(scrit.classname,"%s",*classname);
    sprintf(scrit.station,"%s",*station);
    scrit.t_start = (time_t) *start;
    scrit.t_end = (time_t) *end;
    fmlogmsg(where,"Searching for class %s and time period %d - %d",
            scrit.classname, (int) scrit.t_start, (int) scrit.t_end);

    *noobs=checknorec(*infile, &scrit);
    if (*noobs <= 0) {
        fmlogmsg(where,"File trouble, or no data found (%d)...", *noobs);
    }

    return;
}


#endif
