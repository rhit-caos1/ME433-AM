#include "nu32dip.h"
#include "uart2.h" // include the library

#define NUMSAMPS 2000    // max trajectory size
int PWM_control = 0;        // PWM signal percentage
int PWM_range = 186;
int i = 0;
int dir = 0;


int main(){

    NU32DIP_Startup(); // cache on, min flash wait, interrupts on, LED/button init, UART init

    UART2_Startup();
    NU32DIP_GREEN = 0; // turn off the LEDs
    NU32DIP_YELLOW = 1;
    char message2[100];
    int com;
//    RPA0Rbits.RPA0R = 0b0101;   //Set A0 to OC1
//
//    TRISACLR = 0b0010; //Set A1 to IO
//    LATAbits.LATA1 = 1;//Set A1 to high
//
//
//    T2CONbits.TCKPS = 0b111;     // Timer2 prescaler N=4 (1:256)
//    PR2 = 3749;              // period = (PR2+1) * N * (1/48000000) = 50 Hz
//    TMR2 = 0;                // initial TMR2 count is 0
//    OC1CONbits.OCM = 0b110;  // PWM mode without fault pin; other OC1CON bits are defaults
//    OC1CONbits.OCTSEL = 0;   // Use timer2
//    OC1RS = 282;             // duty cycle = OC1RS/(PR2+1) = 1.5ms
//    OC1R = 500;              // initialize before turning OC1 on; afterward it is read-only
//    T2CONbits.ON = 1;        // turn on Timer2
//    OC1CONbits.ON = 1;       // turn on OC1


    while(1){

        if(get_uart2_flag()){
                set_uart2_flag(0); // set the flag to 0 to be ready for the next message
                com = get_uart2_value();
                sprintf(message2,"%d\r\n",com);
                NU32DIP_WriteUART1(message2);
                NU32DIP_YELLOW = 0;
            }
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