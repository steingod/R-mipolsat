dnl Process this file with autoconf to produce a configure script

AC_PREREQ(2.59)

AC_INIT([mipolsat R-package],[0.1],[o.godoy@met.no])

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
      LIBS="$LIBS -L$addlibdir"
      ;;
    *)
      addincdir="$with_$1/include"
      addlibdir="$with_$1/lib"
      CPPFLAGS="$CPPFLAGS -I$addincdir"
      LIBS="$LIBS -L$addlibdir"
      ;;
esac
if test [ $with_$1 != no]; then
    AC_CHECK_LIB([$1],[$2],
    	,[CPPFLAGS="$saved_CPPFLAGS";LIBS="$saved_LIBS";
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
      LIBS="$LIBS -L$addlibdir"
      ;;
    *)
      addincdir="$with_$1/include"
      addlibdir="$with_$1/lib"
      CPPFLAGS="$CPPFLAGS -I$addincdir"
      LIBS="$LIBS -L$addlibdir"
      ;;
esac
if test [ $with_$1 != no]; then
    AC_CHECK_LIB([$1],[$2],
    	,[CPPFLAGS="$saved_CPPFLAGS";LIBS="$saved_LIBS";
	AC_MSG_WARN([Did not find lib$1, building library with lib$1 dependent functions disabled])])
fi
])

FM_REQLIB([fmutil],[fmivec])
FM_REQLIB([fmio],[fm_readheader])
FM_USELIB([tiff],[TIFFOpen])
FM_USELIB([hdf5],[H5Fopen])

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
