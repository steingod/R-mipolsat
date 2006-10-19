/*
 * NAME:
 * readdata.h
 *
 * PURPOSE:
 * See readdata.c
 *
 * NOTES:
 * NA
 *
 * BUGS:
 * NA
 *
 * AUTHOR:
 * Øystein Godøy, METNO/FOU, 22.09.2006 
 */

#ifndef _READDATA_H
#define _READDATA_H

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <fmio.h>

void readAVHRRheader(char **infile, char **description, char **satellite,
	char **areaname, 
	int *year, int *month, int *day, int *hour, int *minute, 
	int *xsize, int *ysize, int *zsize, int *channelid,
	double *ucs_ul_x, double *ucs_ul_y,
	double *ucs_dx, double *ucs_dy); 
void readAVHRRdata(char **infile, double *mymatrix); 

#endif /* _READDATA_H */
