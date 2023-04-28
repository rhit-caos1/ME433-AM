#include "nu32dip.h" // constants, functions for startup and UART
#include "i2c_master_noint.h" // constants, functions for startup and UART

#include <math.h>

#define PI 3.14159265

//int x = 5;
//int t = 500;
//int v1 = 0;
//int v2 = 0;
//int i = 0;
//int j = 0;
//
//int sign = 1;

//void blink(int, int); // blink the LEDs function
void write_i2c(int);
unsigned char read_i2c(void);

int main(void) {
//  char message[100];
  
  NU32DIP_Startup(); // cache on, interrupts on, LED/button init, UART init

  i2c_master_setup();
  i2c_master_start();
  i2c_master_send(0b01000000);
  i2c_master_send(0b00000000);
  i2c_master_send(0b01111111);
  i2c_master_stop();
  NU32DIP_GREEN = 1;
  NU32DIP_YELLOW = 0;

//  i2c_master_setup();
  while (1) {
//      NU32DIP_GREEN = 1;
//      NU32DIP_YELLOW = 0;
      
//    write_i2c();

    _CP0_SET_COUNT(0);
    while(_CP0_GET_COUNT()<24000000/10){
        NU32DIP_GREEN = 0;
        NU32DIP_YELLOW = 1;
//        i2c_master_start();
//        i2c_master_send(0b01000000);
//        i2c_master_send(0x0A);
//        i2c_master_send(0b10000000);
//        i2c_master_stop();
//        if (read_i2c()==1){
//            write_i2c(1);
//        }
//        write_i2c(1);
        
    }
    _CP0_SET_COUNT(0);
    while(_CP0_GET_COUNT()<24000000/10){
        NU32DIP_GREEN = 1;
        NU32DIP_YELLOW = 0;
//        i2c_master_start();
//        i2c_master_send(0b01000000);
//        i2c_master_send(0x0A);
//        i2c_master_send(0b00000000);
//        i2c_master_stop();
//        if (read_i2c()==0){
//            write_i2c(0);
//        }
//        write_i2c(0);
    }
    if (read_i2c()==0){
        write_i2c(0);
    }else{
        write_i2c(1);
    }
  }
}

void write_i2c(int a){
  i2c_master_start();
  i2c_master_send(0b01000000);
  i2c_master_send(0x0A);
  i2c_master_send(a<<7);
  i2c_master_stop();

}

unsigned char read_i2c(void){
  i2c_master_start();
  i2c_master_send(0b01000000);
  i2c_master_send(0x09);
  i2c_master_restart();
  i2c_master_send(0b01000001);
  unsigned char a = i2c_master_recv();
  i2c_master_ack(1);
  i2c_master_stop();
  return (a&0b00000001);
}

// blink the LEDs
//void blink(int iterations, int time_ms){
//	int i;
//	unsigned int t;
//	for (i=0; i< iterations; i++){
//		NU32DIP_GREEN = 0; // on
//		NU32DIP_YELLOW = 1; // off
//		t = _CP0_GET_COUNT(); // should really check for overflow here
//		// the core timer ticks at half the SYSCLK, so 24000000 times per second
//		// so each millisecond is 24000 ticks
//		// wait half in each delay
//		while(_CP0_GET_COUNT() < t + 12000*time_ms){}
//		
//		NU32DIP_GREEN = 1; // off
//		NU32DIP_YELLOW = 0; // on
//		t = _CP0_GET_COUNT(); // should really check for overflow here
//		while(_CP0_GET_COUNT() < t + 12000*time_ms){}
//	}
//}
		