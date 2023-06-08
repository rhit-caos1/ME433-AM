#include "nu32dip.h"
#include "uart2.h" // include the library

#define NUMSAMPS 2000    // max trajectory size
int PWM_control = 0;        // PWM signal percentage
int PWM_range = 186;
int i = 0;
int dir = 0;
int V_l = 0;
int V_r = 0;
int com = 30;


int main(){

    NU32DIP_Startup(); // cache on, min flash wait, interrupts on, LED/button init, UART init

    UART2_Startup();
    NU32DIP_GREEN = 0; // turn off the LEDs
    NU32DIP_YELLOW = 1;
    char message2[100];
//    int com;

    RPB15Rbits.RPB15R = 0b0101;   //Set B15 to OC1
    RPB13Rbits.RPB13R = 0b0101;   //Set B13 to OC4
//
    TRISBCLR = 0b101000000000000; //Set B12 and B14 to IO
    LATBbits.LATB12 = 0;//Set B12 to high
    LATBbits.LATB14 = 0;//Set B14 to high
//
//
    T2CONbits.TCKPS = 0;     // Timer2 prescaler N=1 (1:1)
    PR2 = 2399;              // period = (PR2+1) * N * (1/48000000) = 20k Hz
    TMR2 = 0;                // initial TMR2 count is 0
    OC1CONbits.OCM = 0b110;  // PWM mode without fault pin; other OC1CON bits are defaults
    OC1CONbits.OCTSEL = 0;   // Use timer2
    OC1RS = V_l;             // duty cycle = OC1RS/(PR2+1) = 25%
    OC1R = V_l;              // initialize before turning OC1 on; afterward it is read-only
    
    OC4CONbits.OCM = 0b110;  // PWM mode without fault pin; other OC1CON bits are defaults
    OC4CONbits.OCTSEL = 0;   // Use timer2
    OC4RS = V_r;             // duty cycle = OC1RS/(PR2+1) = 25%
    OC4R = V_r;              // initialize before turning OC1 on; afterward it is read-only
    
    T2CONbits.ON = 1;        // turn on Timer2
    OC1CONbits.ON = 1;       // turn on OC1
    OC4CONbits.ON = 1;       // turn on OC4


    while(1){

        if(get_uart2_flag()){
                set_uart2_flag(0); // set the flag to 0 to be ready for the next message
                com = get_uart2_value();
                sprintf(message2,"%d\r\n",com);
                NU32DIP_WriteUART1(message2);
                NU32DIP_YELLOW = 0;
            }
        
        if (com<30){
            V_l = 1200+(com-30)*40;
            V_r = 1200;
        }else if(com>30){
            V_r = 1200+(30-com)*40;
            V_l = 1200;
        }else{
            V_l = 1200;
            V_r = 1200;
        }
        OC1RS = V_l;
        OC1R = V_l;
        OC4RS = V_r;
        OC4R = V_r;
//        if (i<400000){
//            if (dir == 0){
//                PWM_control = (int)((float)(i/400000.0)*PWM_range);
//
//            }else{
//                PWM_control = (int)((float)((400000-i)/400000.0)*PWM_range);
//            }
//            OC1RS = 282+PWM_control-46;
//            OC1R = 282+PWM_control-46;
//        }else{
//            i = 0;
//            if (dir == 0){
//                dir = 1;
//            }else{
//                dir = 0;
//            }
//        }
//        i = i+1;

    }
}