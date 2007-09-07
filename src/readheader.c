/*
 * NAME:
 * readheader.c
 *
 * PURPOSE:
 * To read header information of various remote sensing files. See
 * readdata.c for details
 *
 * NOTES:
 * NA
 *
 * BUGS:
 * NA
 *
 * AUTHOR:
 * Øystein Godøy, METNO/FOU, 27.04.2006 
 *
 * CVS_ID:
 * $Id: readheader.c,v 1.3 2007-09-07 17:03:00 steingod Exp $
 */

#include <readdata.h>

void readAVHRRheader(char **infile, char **description, char **satellite, char **areaname, int *year, int *month, int *day, int *hour, int *minute, int *xsize, int *ysize, int *zsize, int *channelid, double *ucs_ul_x, double *ucs_ul_y, double *ucs_dx, double *ucs_dy) {

    char *where="readheader";
    char what[250];
    int status, i;
    fmio_img img;

    img.track = NULL;

    printf("\tReading metadata from:\n\t %s\n",*infile);

    /*
     * Open input file.
     */
    fm_init_fmio_img(&img);
    if ((status = fm_readheader(*infile, &img)) != FM_OK) {
	sprintf(what,
		"Could not access file %s, code [status] returned\n", 
		*infile);
	fmerrmsg(where,what);
	return;
    }

    /*
     * Get metadata
     */
    /*
    sprintf(*description,"%s",img.product);
    */
    sprintf(*description,"Testing...");
    sprintf(*satellite,"%s",img.sa);
    sprintf(*areaname,"%s",img.area);
    *year = img.yy;
    *month = img.mm;
    *day = img.dd;
    *hour = img.ho;
    *minute = img.mi;
    *xsize = img.iw;
    *ysize = img.ih;
    *zsize = img.z;
    for (i=0;i<img.z;i++) {
	channelid[i] = img.ch[i];
    }
    *ucs_ul_x = img.Bx;
    *ucs_ul_y = img.By;
    *ucs_dx = img.Ax;
    *ucs_dy = img.Ay;

    /*
     * Do some cleaning
     */
    /*if (img.track != NULL) free(img.track);*/
    if (fm_clear_fmio_img(&img)) {
	sprintf(what,"Could not free image structure");
	fmerrmsg(where,what);
	return;
    }

    return;
}

