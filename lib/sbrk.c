
#include <stdio.h>
#include <stdlib.h>

/**
 * Stub for the sbrk function.
 * Move heap pointer up and down as requested by functions as malloc() and free().
 * This is the very basic implementation.
 * @note No heap-stack collision test is performed: take care.
 * @param incr Number of bytes to move the pointer (positive or negative).
 * @return Last position of the sbrk pointer.
 */
caddr_t 
sbrk
   (int incr) 
{
   extern char _end;                      // this is defined by the linker. You can only point to this variable.
   static char *heap_end;
   char *prev_heap_end;
 
   if (heap_end == 0) heap_end = &_end;

   prev_heap_end = heap_end;
   heap_end += incr;
   return (caddr_t) prev_heap_end;
}
