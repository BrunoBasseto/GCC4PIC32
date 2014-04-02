#!/bin/perl
#
# Use this script to translate intel HEX files for the PIC32.
# It will translate virtual absolute addresses into physical ones.
# The result should be up for uploading to the chip.
# Author: Bruno Basseto (bruno@wise-ware.org).
#

use strict;

#
# Change extended address record to point to PIC32 physical memory addresses.
# Returns the changed command line. 
#
sub change_addr {   
   #
   # Change address from virtual to physical.
   #
   s/(:.*)(\w{4})(\w{2}.*)/sprintf("$1%04X$3", hex($2) & 0x1fff)/e;
   
   #
   # Update line's checksum.
   #   
   m/^:(.*)\w{2}/;
   my $data = $1;
   my $checksum = 0;
   while ($data =~/(\w{2})/g) {
      $checksum += hex($1);
   }

   #
   # Resassemble the line.
   #
   return  ":$data" . sprintf("%02X", (-$checksum) & 0xff);
}

#
# Main program.
# Test program arguments.
#
@ARGV == 1 or die "Usage: vhex <filename>\n";
my $filename = $ARGV[0];

#
# Open source file and create destination file.
#
open (my $in, "<", $ARGV[0]) or die "Cannot open file $filename.\n";
open (my $tmp, ">", "tmpfl") or die "Cannot create temporary file.\n";

#
# Process source file.
#
while(<$in>) {
   #
   # Search for an extended address record and process it, if found.
   # Copy lines from source to destination.
   #
   chomp;
   s/^:\w{6}04.*/change_addr/e;
   print $tmp "$_\n";
}

#
# End file processing. Substitute source and destination files and we are done.
#
close $in;
close $tmp;
unlink $filename or die "Cannot change file $filename.\n";
rename "tmpfl", $filename or die "Cannot create $filename.\n";

