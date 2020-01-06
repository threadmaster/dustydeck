# Makefile to build lbstime.a library and driver routines 
#
# Andrew J. Pounds, Ph.D.
# Departments of Chemistry and Computer Science
# Mercer University
# Spring 2007
#

F77 = gfortran    
CC  = gcc 
CFLAGS = -O3

TIMINGLIBS =  -L./ -llbstime 
CLIBS = -lm

OBJS = cputime.o walltime.o  

all: lib dusty77  

cputime.o : cputime.cc   
	$(CC) $(CFLAGS) -c cputime.cc  

walltime.o : walltime.cc   
	$(CC) $(CFLAGS) -c walltime.cc  

dusty77.o : dusty77.f   
	$(F77) -c dusty77.f   

# Don't forget the -lstdc++
dusty77 : dusty77.o  $(OBJS) 
	$(F77) -o dusty77 dusty77.o  $(TIMINGLIBS) -lstdc++  

# Default Targets for Cleaning up the Environment
clean :
	rm *.o
	rm *.a

pristine :
	rm *.o
	rm *.a
	touch *.c *.f  

ctags :
	ctags  *.c *.f

# Target for making the library

lib: $(OBJS) 
	ar -rc liblbstime.a $(OBJS) 
	ranlib liblbstime.a
