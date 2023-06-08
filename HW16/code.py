# requires adafruit_ov7670.mpy and adafruit_st7735r.mpy in the lib folder
import time
from displayio import (
    Bitmap,
    Group,
    TileGrid,
    FourWire,
    release_displays,
    ColorConverter,
    Colorspace,
    Palette,
)
from adafruit_st7735r import ST7735R
import board
import busio
import digitalio
from adafruit_ov7670 import (
    OV7670,
    OV7670_SIZE_DIV1,
    OV7670_SIZE_DIV8,
    OV7670_SIZE_DIV16,
)
from ulab import numpy as np

release_displays()
spi = busio.SPI(clock=board.GP2, MOSI=board.GP3)
display_bus = FourWire(spi, command=board.GP0, chip_select=board.GP1, reset=None)
display = ST7735R(display_bus, width=160, height=128, rotation=90) 

# Ensure the camera is shut down, so that it releases the SDA/SCL lines,
# then create the configuration I2C bus

with digitalio.DigitalInOut(board.GP10) as reset:
    reset.switch_to_output(False)
    time.sleep(0.001)
    bus = busio.I2C(board.GP9, board.GP8) #GP9 is SCL, GP8 is SDA

# Set up the camera (you must customize this for your board!)
cam = OV7670(
    bus,
    data_pins=[
        board.GP12,
        board.GP13,
        board.GP14,
        board.GP15,
        board.GP16,
        board.GP17,
        board.GP18,
        board.GP19,
    ],  # [16]     [org] etc
    clock=board.GP11,  # [15]     [blk]
    vsync=board.GP7,  # [10]     [brn]
    href=board.GP21,  # [27/o14] [red]
    mclk=board.GP20,  # [16/o15]
    shutdown=None,
    reset=board.GP10,
)  # [14]

width = display.width
height = display.height

bitmap = None
# Select the biggest size for which we can allocate a bitmap successfully, and
# which is not bigger than the display
for size in range(OV7670_SIZE_DIV1, OV7670_SIZE_DIV16 + 1):
    #cam.size = size # for 4Hz
    #cam.size = OV7670_SIZE_DIV16 # for 30x40, 9Hz
    cam.size = OV7670_SIZE_DIV8 # for 60x80, 9Hz
    if cam.width > width:
        continue
    if cam.height > height:
        continue
    try:
        bitmap = Bitmap(cam.width, cam.height, 65536)
        break
    except MemoryError:
        continue

print(width, height, cam.width, cam.height)
if bitmap is None:
    raise SystemExit("Could not allocate a bitmap")
time.sleep(4)
g = Group(scale=1, x=(width - cam.width) // 2, y=(height - cam.height) // 2)
tg = TileGrid(
    bitmap, pixel_shader=ColorConverter(input_colorspace=Colorspace.BGR565_SWAPPED)
)
g.append(tg)
display.show(g)

t0 = time.monotonic_ns()
display.auto_refresh = False

# arrays to store the color data
reds = np.zeros(60,dtype=np.uint16)
greens = np.zeros(60,dtype=np.uint16)
blues = np.zeros(60,dtype=np.uint16)
bright = np.zeros(60)

uart = busio.UART(board.GP4, board.GP5, baudrate=9600) #tx pin, rx pin
while True:
    cam.capture(bitmap)
    #bitmap[10,10] = 0 # set a pixel to black
    #bitmap[10,20] = 0 # [Y,X], [0,0] is bottom left
    
    # colors:
    #0x1F ->   0b0000000000011111 # all green
    #0x7E0 ->  0b0000011111100000 # all red
    #0xF800 -> 0b1111100000000000 # all blue
    
    # wait for a newline from the computer
    # input()
    row = 40 # which row to send to the computer
    # draw a red dot above the row, in the middle
    bitmap[row+1,30] = 0x3F<<5
    # force some colors to test the bits
    #for i in range(0,20):
    #    bitmap[row,i] = 0xF800 # blue
    #for i in range(20,40):
    #    bitmap[row,i] = 0x1F # green
    #for i in range(40,60):
    #    bitmap[row,i] = 0x7E0 # red
    # calculate the colors
    green_sum = 0
    blue_sum = 0
    for i in range(0,60):
        reds[i] = ((bitmap[row,i]>>5)&0x3F)/0x3F*100
        greens[i] = ((bitmap[row,i])&0x1F)/0x1F*100
        blues[i] = (bitmap[row,i]>>11)/0x1F*100
        bright[i] = reds[i]+greens[i]+blues[i]
        green_sum+=greens[i]
        blue_sum+=blues[i]

    green_avg = green_sum/60
    blue_avg = blue_sum/60
    High_num = 0
    Low_num = 0
    # threshold to try to find the line
    for i in range(0,60):
        # if (greens[i]>green_avg):
        if (greens[i]>green_avg):
            bitmap[row,i] = 0xFFFF
            High_num+=1
        else:
            bitmap[row,i] = 0x0000
            Low_num+=1
    # print the raw pixel value to the computer
    # for i in range(0,60):
        # print(str(i)+" "+str(bitmap[row,i]))
    if (High_num > Low_num):
        reference = 0x0000
    else:
        reference = 0xFFFF
        
    mass_sum = 0
    distribution = 0
    for i in range(0,60):
        if (bitmap[row,i] ==reference):
            mass_sum+=1
            distribution+=1*i
            
    center = distribution/mass_sum
    bitmap[row,int(center)] = 0xAF0F

    bitmap.dirty() # updae the image on the screen
    display.refresh(minimum_frames_per_second=0)
    t1 = time.monotonic_ns()
    #print("fps", 1e9 / (t1 - t0))
    t0 = t1
    print(int(center))
    value_str = str(int(center))+'\n'
    uart.write(value_str.encode())
