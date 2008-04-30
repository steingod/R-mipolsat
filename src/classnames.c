/*
 * NAME:
 * classnames.c
 *
 * PURPOSE:
 * To get the list of classnames available within the file.
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
 * NA
 *
 * CVS_ID:
 * $Id: classnames.c,v 1.1 2008-04-30 19:37:34 steingod Exp $
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

void classnames(char **infile, int *noobs) {

    char *where="checkrec";
    /*
    skeys scrit = {NULL,"NA",0,0};

    sprintf(scrit.classname,"%s",*classname);
    sprintf(scrit.station,"%s",*station);
    scrit.t_start = (time_t) *start;
    scrit.t_end = (time_t) *end;
    */
    fmlogmsg(where,"Searching for available classnames");

    *noobs=getclassnames(*infile);
    if (*noobs <= 0) {
	fmlogmsg(where,"File trouble, or no data found (%d)...", *noobs);
    }

    return;
}


#endif
