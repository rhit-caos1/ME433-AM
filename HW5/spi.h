#ifndef SPI__H__
#define SPI__H__
#define CS LATAbits.LATA1
void initSPI();
unsigned char spi_io(unsigned char o);

#endif // SPI__H__