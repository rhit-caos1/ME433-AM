char m[100];
sprintf(m,"hello")

drawString(m,x,y)

void drawChar(cahr letter, char x, char y)

for j=0:j<5;j++
char col  = ACSII[letter-0x20][j]
for i = 0; j<8 i++
drawPixel(x+j,y+i,(col>>i)&0b1)

void drawString(char*m, char x, char y)

int k = 0
while(m[k]!=0){
    drawChar(m[k],x,y)
    k++
}

optimuization level to 1