# set shell
SHELL = /bin/sh

# Name of the final executable
TARGET = inctime

# Add SOURECDIRS to VPATH, the place make will look for the source files
VPATH = $(SOURCEDIR)

# common flags and utils
include Makefile.common

ifeq (,$(findstring $(MAKECMDGOALS),clean help install))
   # Check necessary variables
   $(call check_die, arch, try: make $(MAKECMDGOALS) arch=gnu; make $(MAKECMDGOALS) arch=intel)
   $(call check_wrn, mode, can be: mode= ; mode=pro; mode=dbg)
   # Include necessary file with flags
   include $(CONFIGDIR)/makefile.$(arch)
endif


# objectlist file
include Makefile-objs
OBJS := $(subst $(SOURCEDIR),$(BUILDDIR),$(OBJS))

## Create a list of *.c sources in DIRS
#SOURCES = $(foreach dir,$(SOURCEDIR),$(wildcard $(dir)/*.f90))
## Define objects for all sources
#OBJS := $(subst $(SOURCEDIR),$(BUILDDIR),$(SOURCES:.f90=.o))

# additionnal libraries
LIBDIRS =  
LIBS    =  

# Not real file targets
.PHONY: $(MAKEFILE) Makefile-deps Makefile-objs \
        all clean

# targets
all: $(LIB) $(TARGET)
	
$(LIB): $(OBJS)
	@$(ECHO) ""
	@$(ECHO) "Creating archive $(@F)"
	@$(ECHO) ""
	$(AR) $(ARFLAGS) $@ $(notdir $(OBJS))


$(TARGET): $(OBJS) 
	@$(ECHO) ""
	@$(ECHO) "Linking executable $(@F)"
	@$(ECHO) ""
	$(LD) $(LDFLAGS) $(addprefix $(BUILDDIR)/,$(notdir $(OBJS))) $(LIBDIRS) $(LIBS) -o $@


# cleanup
clean:
	$(RM) -f $(TARGET) $(LIB) $(notdir $(OBJS)) *.[dlMT] *.mod core


install:
	@$(ECHO) ""
	@$(ECHO) "Installing executable $(TARGET) at $(BINDIR)"
	@$(ECHO) ""
	@if [ -n "$(TARGET)" ] && [ -r "$(TARGET)" ]; then \
	   $(INSTALL) -c $(TARGET) $(BINDIR); \
	fi

# suffixes
.SUFFIXES:
.SUFFIXES: .F90 .f90 .o

# remove target on error
.DELETE_ON_ERROR:

# implicit rules
# Want full path? Change $(<F) to $< and add -o $(@F) or -o $@
%.o: %.F90 ; $(FC) -c $(FCFLAGS)  $< -o $(@F)
%.o: %.f90 ; $(FC) -c $(FCFLAGS)  $< -o $(@F)


# if the compiler do no support the F90 extension
#%.o: %.F90
#	$(MV) $(<F) $(*F).c
#	$(FPP) $(FPPFLAGS) $(*F).c > $(*F)-tmp.f90
#	$(FC) -c $(FFLAGS) $(INCDIRS) $(*F)-tmp.f90
#	$(MV) $(*F)-tmp.o $(*F).o
#	$(RM) -f $(*F).c $(*F)-tmp.f90 

# help page
help:
	@$(ECHO) "Defined targets:"
	@$(ECHO) "  all    : build targets (default)"
	@$(ECHO) "  clean  : cleanup"
	@$(ECHO) "  install: install executable"
	@$(ECHO) "Defined archs:"
	@$(ECHO) "  gnu  : enable gnu compiler and flags"
	@$(ECHO) "  intel: enable intel compiler and flgas"
	@$(ECHO) "Example:"
	@$(ECHO) "  type \`make arch=gnu' to enble gnu compiler"
	@$(ECHO) "Defined modes:"
	@$(ECHO) "  opt: enable flags for optimization (default)"
	@$(ECHO) "  dbg: enable flags for debugging"
	@$(ECHO) "Example:"
	@$(ECHO) "  type \`make mode=dbg+pro' to enable dbg and pro flags"

# dependencies file
include Makefile-deps
