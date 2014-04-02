
#
# Make init library for PIC32MX7 microcontrollers.
# Uses MIPS-GCC compiler.
#
CC = mips-elf-gcc
AR = mips-elf-ar
PROGRAM = mx7crt.o
ARCH = -EL -march=m4k
OBJECTS = init.o sfr.o sbrk.o
CFLAGS = -I. -msoft-float
LIBS = 
LDSCRIPT = -nostartfiles -T../ld/mx7.ld

all: $(PROGRAM)

$(PROGRAM): $(OBJECTS)
	$(AR) -r $(PROGRAM) $(OBJECTS)
   
.s.o:
	$(CC) $(ARCH) -I. -c $< -o $@
   
.c.o:
	$(CC) $(ARCH) $(CFLAGS) -c $<

clean:
	rm -f $(OBJECTS) $(PROGRAM)
