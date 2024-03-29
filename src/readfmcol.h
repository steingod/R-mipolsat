/*
 * NAME:
 * readfmcol.h
 *
 * PURPOSE:
 * Header file for fmcol software.
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
 * Øystein Godøy, METNO/FOU, 2013-04-12 
 *
 * MODIFIED:
 * Øystein Godøy, METNO/FOU, 2013-04-12 
 *
 * CVS_ID:
 * $Id: readfmcol.h,v 1.2 2013-05-07 08:37:11 steingod Exp $
 */

#ifdef HAVE_LIBHDF5

#ifndef _RCOLDUMP_H
#define _RCOLDUMP_H

/*
 * The main header file of libcollocate is required... 
 * Use undef statements to change definitions made in libcollocate...
 */
#include <fmutil.h>
#include <fmcol.h>
/*
#include <fmcolaccess.h>
*/
#include <hdf5.h>

void readctval(char **infile, int *n, int *p, char **station, 
        int *start, int *end,
        int *stid, int *mytime,
        int *N, int *CL, int *CM, int *CH, 
        int *E, int *sss, int *cm);
void Rread123(char **infile, int *n, int *p, char **station, 
        int *start, int *end,
        int *stid, int *mytime,
        int *N, 
        int *E, int *sss, 
        double *k1, double *k2, 
        double *k3a, double *k3b, 
        double *k4, double *k5,
        double *soz, double *saz, double *raz
        );
void Rread124(char **infile, int *n, int *p, 
        char **classname, char **station, 
        int *start, int *end,
        int *mytime,
        double *k1, double *k2, 
        double *k3a, double *k3b, 
        double *k4, double *k5,
        double *soz, double *saz, double *raz,
        int *cm
        );
void readsnowsig(char **infile, int *n, int *p, char **station, 
        int *start, int *end,
        int *stid, int *mytime,
        int *N, int *CL, int *CM, int *CH, 
        int *E, int *sss, 
        double *k1, double *k2, 
        double *k3a, double *k3b, 
        double *k4, double *k5,
        double *soz, double *saz, double *raz,
        double *t0m, double *t2m
        );
void readssidev(char **infile, int *n, int *p, char **station, 
        int *start, int *end,
        int *mytime,
        double *k1, double *k2, 
        double *k3a, double *k3b, 
        double *k4, double *k5,
        double *soz, double *saz, double *raz,
        double *t2m, double *ps, double *pw,
        int *cm,
        double *ssi);
void readdlidev(char **infile, int *n, int *p, char **station, 
        int *start, int *end,
        int *mytime,
        double *k1, double *k2, 
        double *k3a, double *k3b, 
        double *k4, double *k5,
        double *t2m, double *ps, double *pw,
        int *cm,
        double *ssi);

#endif /* _RCOLDUMP_H */

#endif
