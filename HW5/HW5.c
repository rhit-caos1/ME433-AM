#include "nu32dip.h" // constants, functions for startup and UART
#include "spi.h" // constants, functions for startup and UART

#include <math.h>

#define PI 3.14159265

int x = 5;
int t = 500;
int v1 = 0;
int v2 = 0;
int i = 0;
int j = 0;

int sign = 1;

void blink(int, int); // blink the LEDs function

int main(void) {
  char message[100];
  
  NU32DIP_Startup(); // cache on, interrupts on, LED/button init, UART init
  initSPI();
  while (1) {
//    NU32DIP_ReadUART1(message, 100); // wait here until get message from computer
//    sscanf(message, "%d", &x);
//    NU32DIP_ReadUART1(message, 100); // wait here until get message from computer
//    sscanf(message, "%d", &t);
//    sprintf(message,"%d %d \r\n", x, t);
//    NU32DIP_WriteUART1(message); // send message back
//    NU32DIP_WriteUART1("\r\n"); // carriage return and newline
//	if (NU32DIP_USER){
//		blink(x, t); // 5 times, 500ms each time
//	}
    v1 = (int)((sin(i/50.0*PI*2.0)*1023.0/2.0)+1023.0/2.0);
    
//    if(NU32DIP_USER==0){ 
//      int i = 0;
//      for(i = 0; i<100; i++){
//          sprintf(message,"%f\r\n",sin(i/100.0*PI*2)*1.5+1.5);
//          NU32DIP_WriteUART1(message); 
//          _CP0_SET_COUNT(0);
//          while(_CP0_GET_COUNT()<24000){}
//          
//      }
//    }
    // a or b 1 1 1 voltage 0 0
    unsigned short ta = 0;
    ta = 0b111<<12;
    unsigned char a_or_b; //0b0 or 0b1
    a_or_b = 0;
    ta = ta|(a_or_b<<15);
    // stick in the v1
    v1 = v1<<2;
    ta = ta|v1;
    
    CS = 0;
    spi_io(ta>>8);
    spi_io(ta);
    CS = 1;
    
    
    v2 = (int)(j/50.0*1023.0);
    unsigned short tb = 0;
    tb = 0b111<<12;
    a_or_b = 1;
    tb = tb|(a_or_b<<15);
    // stick in the v1
    v2 = v2<<2;
    tb = tb|v2;
    
    CS = 0;
    spi_io(tb>>8);
    spi_io(tb);
    CS = 1;
    
    if (i>49){
        i = 0;
    }
    i+=1;
    
    if (j>49){
        sign = -1;
    }else if (j<=0){
        sign = 1;
    }
    j+=sign;
    _CP0_SET_COUNT(0);
    while(_CP0_GET_COUNT()<24000000/100){}
  }
}

// blink the LEDs
void blink(int iterations, int time_ms){
	int i;
	unsigned int t;
	for (i=0; i< iterations; i++){
		NU32DIP_GREEN = 0; // on
		NU32DIP_YELLOW = 1; // off
		t = _CP0_GET_COUNT(); // should really check for overflow here
		// the core timer ticks at half the SYSCLK, so 24000000 times per second
		// so each millisecond is 24000 ticks
		// wait half in each delay
		while(_CP0_GET_COUNT() < t + 12000*time_ms){}
		
		NU32DIP_GREEN = 1; // off
		NU32DIP_YELLOW = 0; // on
		t = _CP0_GET_COUNT(); // should really check for overflow here
		while(_CP0_GET_COUNT() < t + 12000*time_ms){}
	}
}
		