#
# Makefile for PIC32
# by Bruno Basseto.
# 

#
# Define your project name here.
#
PROGRAM = test

#
# List the object files of your project here.
#
OBJECTS = test.o 

#
# Source directory.
#
SRC_PATH = ../src

#
# List libraries needed:
#
LIBS = c

#
# List search directories for headers and for libraries
#
INCLUDE_DIRS = ../include
LIB_DIRS = ../lib

#
# Name the startup code and linker script to be used.
#
LDSCRIPT = ../ld/mx7.ld
STARTUP = ../lib/mx7crt.o

#
# Definitions for make
#
CC = mips-elf-gcc
OBJCPY = mips-elf-objcopy
ARCH = -EL -march=m4k
CFLAGS += -msoft-float
LDFLAGS += $(STARTUP) -usbrk -nostartfiles 
CDIRS = $(patsubst %,-I%,$(INCLUDE_DIRS))
LDLIBS = $(LIBS2) $(patsubst %,-L%,$(LIB_DIRS)) $(patsubst %,-l%,$(LIBS))
ELFFILE = $(PROGRAM).elf
HEXFILE = $(PROGRAM).hex
MAPFILE = $(PROGRAM).map

.phony: all
.phony: clean

#
# And here come the targets and their rules.
#
all: $(ELFFILE)

#
# Build project
# 1. link everything into an ELF output.
# 2. use objcopy to convert to an HEX file.
# 3. use vhex script to translate to physical addresses.
#
$(ELFFILE): $(OBJECTS)
	$(CC) $(ARCH) $(CFLAGS) -T$(LDSCRIPT) $(OBJECTS) $(LDFLAGS) $(LDLIBS) -Wl,-Map,$(MAPFILE) -o$(ELFFILE)
	../bin/undef.sh $(ELFFILE)
	$(OBJCPY) -x -O ihex $(ELFFILE) $(HEXFILE)
	perl ../bin/vhex.pl $(HEXFILE)
	@printf "**************\n* Build DONE *\n**************"
   
#
# Rule for compiling C files.
#   
%.o: $(SRC_PATH)/%.c
	$(CC) $(ARCH) $(CFLAGS) $(CDIRS) -c $<

#
# Target to remove all generated files.
#
clean:
	rm -f $(OBJECTS) $(PROGRAM).*
