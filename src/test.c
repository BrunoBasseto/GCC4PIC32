
/*
 * This is just a dummy program to test PIC32 framework.
 */

#include "mx7/sfr.h"
#include "mx7/config.h"

DECLARE_CONFIG(DEVCFG1, DEVCFG1_FNOSC_PRIPLL & DEVCFG1_FPBDIV_8 & DEVCFG1_POSCMOD_HS);
DECLARE_CONFIG(DEVCFG2, DEVCFG2_FPLLIDIV_2 & DEVCFG2_FPLLMUL_20 & DEVCFG2_FPLLODIV_1);

void main(void)
{
   unsigned long t;

   AD1PCFG = 0xffffffff;
   DDPCON = 0;
   
   TRISBbits.TRISB6 = 0;
   LATBbits.LATB6 = 0;

   INTCONbits.MVEC = 1;

   /*
    * Blink led on RB6
    */
   for(;;) {
      if(t < 100000) t++;
      else {
         t = 0;
         LATBbits.LATB6 = !LATBbits.LATB6;
      }
   }
}
