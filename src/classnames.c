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
 * Calls getclassnames in libfmcol.
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
 * $Id: classnames.c,v 1.3 2013-04-12 10:29:24 steingod Exp $
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

void classnames(char **infile, int *noobs, char **classes) {

    char *where="classnames";
    cnames cn;
    int i;

    *noobs=getclassnames(*infile, &cn);
    if (*noobs <= 0) {
	fmlogmsg(where,"File trouble, or no data found (%d)...", *noobs);
    }
    for (i=0;i<cn.noobs;i++) {
	sprintf(classes[i],"%s",cn.name[i]);
    }
    *noobs = cn.noobs;

    return;
}


#endif
