# compiler, pre-processor and linker
CPP = gcc
CC  = gcc
FC  = gfortran
LD  = gfortran

# add flags
CPPFLAGS =
CCFLAGS  =
FFFLAGS  =
LDFLAGS  =

# add flags for debugging if requested
ifeq (dbg,$(findstring dbg,$(mode)))
   CCFLAGS += -DDEBUG -g -Wall
   FCFLAGS += -fbacktrace -g -Wall
   LDFLAGS += -g -fbacktrace
endif

# add flags for profiling if requested
ifeq (pro,$(findstring pro,$(mode)))
   CCFLAGS += -pg
   FCFLAGS += 
   LDFLAGS += 
endif

# add flags for optimization if requested
ifeq (opt,$(findstring opt,$(mode)))
   CCFLAGS += 
   FCFLAGS += -O3
   LDFLAGS += 
endif

