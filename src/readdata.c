/*
 * NAME:
 * readdata.c
 *
 * PURPOSE:
 * To read the actual data of various remote sensing file formats.
 *
 * NOTES:
 * NA
 *
 * BUGS:
 * Lots, no checking of product type would generate core dump etc....
 *
 * AUTHOR:
 * Øystein Godøy, METNO/FOU, 27.04.2006 
 *
 * CVS_ID:
 * $Id: readdata.c,v 1.3 2007-09-07 17:03:00 steingod Exp $
 */

#include <readdata.h>

void readAVHRRdata(char **infile, double *mymatrix) {

    char *where="readdata";
    char what[250];
    int i, j, k, l, imgsize, status;
    fmio_img img;

    img.track = NULL;
    for (i=0;img.z;i++) {
	img.image[i] = NULL;
    }

    printf("\tReading data from:\n\t %s\n",*infile);

    /*
     * Open input file.
     */
    fm_init_fmio_img(&img);
    if ((status = fm_readdata(*infile, &img)) != FM_OK) {
	sprintf(what,
		"Could not access file %s, code [status] returned\n", 
		*infile);
	fmerrmsg(where,what);
	return;
    }

    imgsize = img.iw*img.ih;

    /*
     * Fill R interface with data and unpack data simultaneously...
     */
    for (l=0;l<img.z;l++) {
	i = 0;
	for (j=0;j<img.ih;j++) {
	    for (k=0;k<img.iw;k++) {
		if (img.ch[l] >= 3 && img.ch[l] <= 5) {
		    mymatrix[l*imgsize+i] = 
			img.rit+(img.rgt* (float) img.image[l][i]);
		} else {
		    mymatrix[l*imgsize+i] = 
			img.ria+(img.rga* (float) img.image[l][i]);
		}
		i++;
	    }
	}
    }

    /*
     * Do some cleaning
     */
    /*
    if (img.track != NULL) free(img.track);
    for (i=0;i<img.z;i++) {
	if (img.image[i] != NULL) free(img.image[i]);
    }
    */
    if (fm_clear_fmio_img(&img)) {
	sprintf(what,"Could not free image structure");
	fmerrmsg(where,what);
	return;
    }

    return;
}

