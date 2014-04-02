#!/bin/bash
# This script verifies if there are undefined symbols in an ELF file, passed as parameter.
# Author: Bruno Basseto (bruno@wise-ware.org).
#
res=`nm -u $1`
if [ "$res" != '' ]; then
   echo "ERROR: Undefined symbols:"
   echo $res
   exit 1
fi
