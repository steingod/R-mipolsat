#
# NAME:
# configure.ac
#
# PURPOSE:
# Process this file with autoconf to produce a configure script
#
# REQUIREMENTS:
# NA
#
# INPUT:
# NA
#
# OUTPUT:
# NA
#
# NOTES:
# NA
#
# BUGS:
# o Handling of missing HDF5 library is yet not perfectly implemented.
# o PPS library has to be included, even if only reading data, need to
# split hdfaccess.c/.h in several files.
#
# AUTHOR:
# Øystein Godøy, METNO/FOU, 06.09.2007 
#
# MODIFIED:
# NA
#
# CVS_ID:
# $Id: configure.ac,v 1.3 2007-09-12 13:36:55 steingod Exp $
#

AC_PREREQ(2.59)

AC_INIT([mipolsat R-package],[0.2],[o.godoy@met.no])

AC_LANG(C)

AC_DEFUN([FM_REQLIB],[
# Checks for libraries that are required.
saved_CPPFLAGS="$CPPFLAGS"
saved_LIBS="$LIBS"
AC_ARG_WITH([$1],
    AC_HELP_STRING([--with-$1=DIR],
	[the location of mandatory lib$1 files and library either as DIR or INC,LIB]),
	,
	[with_$1=yes])
case $with_$1 in
    yes)
     echo "Using system implementation of lib$1"
     ;;
    no)
    AC_MSG_ERROR([lib$1 is required])
     ;;
    *,*)
      addincdir="`echo $with_$1 | cut -f1 -d,`"
      addlibdir="`echo $with_$1 | cut -f2 -d,`"
      CPPFLAGS="$CPPFLAGS -I$addincdir"
      LIBS=" -L$addlibdir $LIBS"
      ;;
    *)
      addincdir="$with_$1/include"
      addlibdir="$with_$1/lib"
      CPPFLAGS="$CPPFLAGS -I$addincdir"
      LIBS="-L$addlibdir $LIBS"
      ;;
esac
if test [ $with_$1 != no]; then
    AC_CHECK_LIB([$1],[$2],
    	,[CPPFLAGS="$saved_CPPFLAGS";LIBS="$saved_LIBS";
	AC_MSG_RESULT([]);
	AC_MSG_RESULT([]);
	AC_MSG_ERROR([Did not find lib$1])])
fi
])

AC_DEFUN([FM_USELIB],[
# Checks for libraries that could be dropped.
saved_CPPFLAGS="$CPPFLAGS"
saved_LIBS="$LIBS"
AC_ARG_WITH([$1],
    AC_HELP_STRING([--with-$1=DIR],
	[the location of optional lib$1 files and library either as DIR or INC,LIB]),
	,
	[with_$1=yes])
case $with_$1 in
    yes)
     echo "Using system implementation of lib$1"
     ;;
    no)
    AC_MSG_WARN([Building library with lib$1 dependent functions disabled])
     ;;
    *,*)
      addincdir="`echo $with_$1 | cut -f1 -d,`"
      addlibdir="`echo $with_$1 | cut -f2 -d,`"
      CPPFLAGS="$CPPFLAGS -I$addincdir"
      LIBS="-L$addlibdir $LIBS"
      ;;
    *)
      addincdir="$with_$1/include"
      addlibdir="$with_$1/lib"
      CPPFLAGS="$CPPFLAGS -I$addincdir"
      LIBS="-L$addlibdir $LIBS"
      ;;
esac
if test [ $with_$1 != no]; then
    AC_CHECK_LIB([$1],[$2],
    	,[CPPFLAGS="$saved_CPPFLAGS";LIBS="$saved_LIBS";
	AC_MSG_WARN([===================================]);
	AC_MSG_WARN([Did not find lib$1]);
	AC_MSG_WARN([Disabling lib$1 dependent functions]);
	AC_MSG_WARN([===================================]);
	disabled_$1=yes;
	AC_MSG_RESULT([disabled_$1 has the value $disabled_$1])])
fi
])

AC_DEFUN([FM_ADDINC],[
# Add path to include files
saved_CPPFLAGS="$CPPFLAGS"
saved_LIBS="$LIBS"
AC_ARG_WITH([$1],
    AC_HELP_STRING([--with-$1=DIR],
	[the location of include files that are required as DIR]),
	,
	[with_$1=yes])
    addincdir="$with_$1"
    if ! test -x $addincdir; then
	AC_MSG_ERROR([Cannot find directory $addincdir])
    else
	CPPFLAGS="$CPPFLAGS -I$addincdir"
    fi
])

FM_USELIB([tiff],[TIFFOpen])

FM_USELIB([hdf5],[H5Fopen])

FM_REQLIB([fmutil],[fmivec])

##AC_MSG_RESULT([disable_hdf5 has the value x$disabled_hdf5])
if test x$disabled_hdf5 = xyes; then
    AC_MSG_WARN([===================================]);
    AC_MSG_WARN([No HDF5 functionality will be available in libfmio])
    AC_MSG_WARN([===================================]);
fi
FM_REQLIB([fmio],[fm_readheader])

if test  x$disabled_hdf5 = xyes; then
    AC_MSG_WARN([===================================]);
    AC_MSG_WARN([Since libhdf5 is disabled, libfmcol will also be disabled])
    AC_MSG_WARN([===================================]);
else
    #FM_ADDINC([hlhdf])
    #FM_ADDINC([smhi_saf])
    FM_REQLIB([fmcol],[read123])
fi

dnl ########################################################### 
dnl Some R specific tasks...
dnl
: ${R_HOME=`R RHOME`}
if test -z "${R_HOME}"; then
  echo "could not determine R_HOME"
  exit 1
fi
CC=`"${R_HOME}/bin/R" CMD config CC`
CFLAGS=`"${R_HOME}/bin/R" CMD config CFLAGS`

AC_CONFIG_FILES(src/Makevars)
#AC_SUBST(CFLAGS)
#AC_SUBST(LIBS)
AC_OUTPUT
