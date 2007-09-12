/*
 * NAME:
 * readdlidev.h
 *
 * PURPOSE:
 * Header file for readdlidev.c software.
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
 * Øystein Godøy, DNMI/FOU, 21/12/2001
 *
 * MODIFIED:
 * NA
 *
 * CVS_ID:
 * $Id: readdlidev.h,v 1.2 2007-09-12 13:36:55 steingod Exp $
 */

#ifdef HAVE_LIBHDF5

#ifndef _COLDUMP_H
#define _COLDUMP_H

/*
 * The main header file of libcollocate is required... 
 * Use undef statements to change definitions made in libcollocate...
 */
#include <fmutil.h>
#include <fmcol.h>
#include <hdfaccess.h>
/*
#include <avhrr_stdat.h>
#include <nwp_stdat.h>
#include <std_stdat.h>
#include <mifield.h>
#include <pps_cloudproducts_io.h>
#include <safcm_stdat.h>
#include <safssi_stdat.h>
*/

#endif /* _COLDUMP_H */

#endif
