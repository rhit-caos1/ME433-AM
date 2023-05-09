#include "nu32dip.h" // constants, functions for startup and UART
#include "ws2812b.h"

#include <stdio.h>

int main(void) {

    NU32DIP_Startup();
    ws2812b_setup();
    float H, Href, S, B;
    Href = 0.0;
    H = Href;
    S = 0.65;
    B = 0.01;

    int LEDnum = 8;
    wsColor c[LEDnum];
    
    while (1) {
        H = Href;
        for (unsigned int i = 0; i<LEDnum; i++){
            H = (float)(Href+45.0*i);
            if (H>360.0){
                H -=360.0;
            }
            
            c[i] = HSBtoRGB(H, S, B);
        }
        ws2812b_setColor(c,LEDnum);
        Href += 0.1;
        if (Href>360.0){
            Href = 0.0;
        }
//        _CP0_SET_COUNT(0);
//        while (_CP0_GET_COUNT() < 48000000 / 2 / 100) { 
//        }
    }
}