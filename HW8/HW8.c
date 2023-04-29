#include "nu32dip.h" // constants, functions for startup and UART
#include "i2c_master_noint.h"
#include "mpu6050.h"
#include "ssd1306.h"
#include "font.h"
#include <stdio.h>

void blink(int, int); // blink the LEDs function

void drawChar(char, char, char);

void drawString(char*, char, char);

int main(void) {
    NU32DIP_Startup(); // cache on, interrupts on, LED/button init, UART init
    init_mpu6050();
    ssd1306_setup();
    
    // char array for the raw data
    unsigned char d[14]; //  Accelerations, Gyroscope, Temperature
    // floats to store the data
    float ax, ay, az, gx, gy, gz, t;
    
    unsigned long long int time;
    double fps = 0.0;

    // read whoami
    unsigned char who = whoami();
    // print whoami
    char m[100];
    sprintf(m,"0x%X\r\n", who);
    NU32DIP_WriteUART1(m);
    
    //drawsting test


    
    // if whoami is not 0x68, stuck in loop with LEDs on
    if(who != 0x68){ 
        while(1){
        NU32DIP_GREEN = 1; 
        NU32DIP_YELLOW = 0; // on
        }
    }

    // wait to print until you get a newline
//    NU32DIP_ReadUART1(m,100);
    _CP0_SET_COUNT(0);
    time = _CP0_GET_COUNT();

    while (1) {
        // use core timer for exactly 100Hz loop
        
//        blink(5, 100);

//        // read IMU
        burst_read_mpu6050(d);
//        // convert data
        ax = conv_xXL(d); // convert x-acceleration to float (g's)
        ay = conv_yXL(d); // convert y-acceleration to float (g's)
        az = conv_zXL(d); // convert z-acceleration to float (g's)
        gx = conv_xG(d); // convert x-gyro rate to dps
        gy = conv_yG(d); // convert y-gyro rate to dps
        gz = conv_zG(d); // convert z-gyro rate to dps
        t = conv_temp(d); // convert int16_t temperature signed short to float (Celsius)
        
        sprintf(m,"z acc = %f", ax);
        drawString(m,10,10);
        sprintf(m,"%f fps", fps);
        drawString(m,10,25);
        ssd1306_update();

        fps = 24000000.0/(_CP0_GET_COUNT()-time);

        ssd1306_clear();
        
        time = _CP0_GET_COUNT();
        
      // print out all of the data
//        sprintf(m,"ax: %f\r\n", ax);
//        NU32DIP_WriteUART1(m);
//        sprintf(m,"ay: %f\r\n", ay);
//        NU32DIP_WriteUART1(m);
//        sprintf(m,"az: %f\r\n", az);
//        NU32DIP_WriteUART1(m);
//        sprintf(m,"gx: %f\r\n", gx);
//        NU32DIP_WriteUART1(m);
//        sprintf(m,"gy: %f\r\n", gy);
//        NU32DIP_WriteUART1(m);
//        sprintf(m,"gz: %f\r\n", gz);
//        NU32DIP_WriteUART1(m);
//        sprintf(m,"t: %f\r\n", t);
//        NU32DIP_WriteUART1(m);
        
        //print ax for python plot file
//        sprintf(m,"%f\r\n", ax);
//        NU32DIP_WriteUART1(m);

//        while (_CP0_GET_COUNT() < 48000000 / 2 / 100) { 
//        }
    }
}

// blink the LEDs
void blink(int iterations, int time_ms) {
    int i;
    unsigned int t;
    for (i = 0; i < iterations; i++) {
        NU32DIP_GREEN = 0; // on
        NU32DIP_YELLOW = 1; // off
        
        ssd1306_drawPixel(3, 3, 1);
        ssd1306_update();
        t = _CP0_GET_COUNT(); // should really check for overflow here
        // the core timer ticks at half the SYSCLK, so 24000000 times per second
        // so each millisecond is 24000 ticks
        // wait half in each delay
        while (_CP0_GET_COUNT() < t + 12000 * time_ms) {
        }

        NU32DIP_GREEN = 1; // off
        NU32DIP_YELLOW = 0; // on
        
        ssd1306_clear();
        ssd1306_update();
        
        t = _CP0_GET_COUNT(); // should really check for overflow here
        while (_CP0_GET_COUNT() < t + 12000 * time_ms) {
        }
    }
}

//char m[100];
//sprintf(m,"hello")
//
//drawString(m,x,y)
//
void drawChar(char letter, char x, char y){
    for (int j=0;j<5;j++){
        char col  = ASCII[letter-0x20][j];
        for (int i = 0; i<8; i++){
            ssd1306_drawPixel(x+j,y+i,(col>>i)&0b1);
        }
        
    }
}



void drawString(char* m, char x, char y){

    int k = 0;

    while(m[k]!=0){

        drawChar(m[k],x+5*k,y);

        k++;
    }


}