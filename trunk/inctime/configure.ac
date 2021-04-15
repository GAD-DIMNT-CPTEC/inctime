# AC_INIT takes two parameters, the package name and a version number.
AC_INIT([inctime], [1.0], [joao.gerd@inpe.br])
#AC_CONFIG_MACRO_DIRS([m4])
# AC_CONFIG_SRCDIR takes one parameter, the path and filename
# for one of the source code files.
AC_CONFIG_SRCDIR([src/inctime.f90])
AM_INIT_AUTOMAKE
AC_PROG_LIBTOOL

# Include debug option to configure file
AC_ARG_ENABLE(debug,
AS_HELP_STRING([--enable-debug],
               [enable debugging, default: no]),
[case "${enableval}" in
             yes) debug=true ;;
             no)  debug=false ;;
             *)   AC_MSG_ERROR([bad value ${enableval} for --enable-debug]) ;;
esac],
[debug=false])

# Include optimization option to configure file
AC_ARG_ENABLE(optiminzation,
AS_HELP_STRING([--enable-optimization],
               [enable optimization, default: no]),
[case "${enableval}" in
             yes) opt=true ;;
             no)  opt=false ;;
             *)   AC_MSG_ERROR([bad value ${enableval} for --enable-optimization]) ;;
esac],
[opt=false])

# Include profile option to configure file
AC_ARG_ENABLE(profile,
AS_HELP_STRING([--enable-profile],
               [enable profile, default: no]),
[case "${enableval}" in
             yes) pro=true ;;
             no)  pro=false ;;
             *)   AC_MSG_ERROR([bad value ${enableval} for --enable-profile]) ;;
esac],
[pro=false])


# AC_PROG_FC This is required if any Fortran 90/95 source is included.
AC_PROG_FC([gfortran ifort])
# Set flags for gfortran
if test "x$FC" == xgfortran;then
   AC_SUBST([FCFLAGS], [""])
   AC_SUBST([LDFLAGS], [""])
   # Debug flags
   if test "x$debug" == xtrue;then
      FCFLAGS="$FCFLAGS -DDEBUG -g -Wall -fbacktrace"
      LDFLAGS="$LDFLAGS -g -ftraceback"
   fi
   # Opt flags
   if test "x$opt" == xtrue;then
      FCFLAGS="$FCFLAGS -O3"
   fi
   # Profile flags
   if test "x$pro" == xtrue;then
      FCFLAGS="$FCFLAGS -pg"
   fi
fi
# Set flags for ifort
if test "x$FC" == xifort;then
   AC_SUBST([FCFLAGS], [""])
   AC_SUBST([LDFLAGS], [""])
   # Debug flags
   if test "x$debug" == xtrue;then
      FCFLAGS="$FCFLAGS -DDEBUG -g -Wall -traceback"
      LDFLAGS="$LDFLAGS -g -traceback"
   fi
   # Opt flags
   if test "x$opt" == xtrue;then
      FCFLAGS="$FCFLAGS -fast"
   fi
   # Profile flags
   if test "x$pro" == xtrue;then
      FCFLAGS="$FCFLAGS -pg"
   fi
fi
# Find the compiler flag to include Fortran 90 module information from 
# another directory, and store that in the FC_MODINC variable.
AC_FC_MODULE_FLAG
if test -n "$FC_MODINC"; then
  FCFLAGS="$FCFLAGS $FC_MODINC. $FC_MODINC../include"
fi

# Find the compiler flag to write Fortran 90 module information to
# another directory, and store that in the FC_MODOUT variable.
AC_FC_MODULE_OUTPUT_FLAG
FCFLAGS="$FC_MODOUT../include"

# Find the Fortran 90 module file name extension
AC_FC_MODULE_EXTENSION


AC_PROG_RANLIB
# This is a reusable macro for providing --with-libfoo functionality.
# 
# REQUIRE_LIB(name,lib,testfn,description)
# name = The complete name of the library file without the extension.
# lib = The name of the library file without the 'lib' prefix and without the extension.
# testfn = One function included in the library that can be used for a test compilation.
# description = Human readable text to be displayed if the library can't be found or
# if there's a problem during the test compilation.
AC_DEFUN([REQUIRE_LIB], [ {
 AC_ARG_WITH([$1], AC_HELP_STRING([--with-$1=<path>],[Location where $4 is
installed]),[],[with_$1=default])
 AS_IF( [test "x$with_$1" != xdefault],
 [
 LDFLAGS="$LDFLAGS -L${with_$1}/lib"
 CFLAGS="$CFLAGS -I${with_$1}/include"
 ])
 AC_CHECK_LIB($2,$3,[],
 [
 AC_MSG_ERROR([$4 was not found, try specifying --with-$1])
 ])
} ] )
# The list of libraries required by the source code that are external to
# our code.
#REQUIRE_LIB(libpcap,pcap,pcap_dump_open,[Libpcap packet capture library])
# AC_OUTPUT takes a space delimited list of where the Makefiles are to be created.
# You need to pass all directories where there is source code (including the base
# directory containing all of the source code (which won't need a path pre-pended
# to the 'Makefile' keyword).
AC_OUTPUT(Makefile src/Makefile libmisc/Makefile)


