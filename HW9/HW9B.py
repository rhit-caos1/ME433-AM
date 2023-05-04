import csv
import matplotlib.pyplot as plt # for plotting
import numpy as np # for sine function

t = [] # column 0
data1 = [] # column 1


with open('sigB.csv') as f:
    # open the csv file
    reader = csv.reader(f)
    for row in reader:
        # read the rows 1 one by one
        t.append(float(row[0])) # leftmost column
        data1.append(float(row[1])) # second column


# for i in range(len(t)):
#     # print the data to verify it was read
#     print(str(t[i]) + ", " + str(data1[i]))

plt.plot(t,data1,'b-*')
plt.xlabel('Time [s]')
plt.ylabel('Signal')
plt.title('Signal vs Time')
plt.show()

Fs = 10000 # sample rate
Ts = 1.0/Fs; # sampling interval
ts = np.arange(0,t[-1],Ts) # time vector
y = data1 # the data to make the fft from
n = len(y) # length of the signal
k = np.arange(n)
T = n/Fs
frq = k/T # two sides frequency range
frq = frq[range(int(n/2))] # one side frequency range
Y = np.fft.fft(y)/n # fft computing and normalization
Y = Y[range(int(n/2))]
Y1 = Y

fig, (ax1, ax2) = plt.subplots(2, 1)
ax1.plot(t,y,'b')
ax1.set_xlabel('Time')
ax1.set_ylabel('Amplitude')
ax2.loglog(frq,abs(Y),'b') # plotting the fft
ax2.set_xlabel('Freq (Hz)')
ax2.set_ylabel('|Y(freq)|')
plt.show()

# MAF

avg = []

sample_size = 100
avg.extend([0] * sample_size)

for i in range(len(t)-sample_size):
    # print the data to verify it was read
    avg_sample = []
    for j in range(i,i+sample_size):
        avg_sample.append(data1[j])
    avg.append(np.average(avg_sample))

Fs = 10000 # sample rate
Ts = 1.0/Fs; # sampling interval
ts = np.arange(0,t[-1],Ts) # time vector
y = avg # the data to make the fft from
n = len(y) # length of the signal
k = np.arange(n)
T = n/Fs
frq = k/T # two sides frequency range
frq = frq[range(int(n/2))] # one side frequency range
Y = np.fft.fft(y)/n # fft computing and normalization
Y = Y[range(int(n/2))]

plt.subplot(2, 1, 1)
plt.plot(t,data1,'k',t,avg,'r-')
plt.title('number of points for averaging = 100')
plt.xlabel('Time')
plt.ylabel('Amplitude')

plt.subplot(2, 1, 2)
plt.loglog(frq,abs(Y1),'b',frq,abs(Y),'r')
plt.xlabel('Freq (Hz)')
plt.ylabel('|Y(freq)|')

plt.show()


#IIR

iir = []
A = 0.99
B = 1-A
est = 0

for i in range(len(t)):
    # print the data to verify it was read
    s = []
    est = A*est+B*data1[i]
    iir.append(est)

Fs = 10000 # sample rate
Ts = 1.0/Fs; # sampling interval
ts = np.arange(0,t[-1],Ts) # time vector
y = iir # the data to make the fft from
n = len(y) # length of the signal
k = np.arange(n)
T = n/Fs
frq = k/T # two sides frequency range
frq = frq[range(int(n/2))] # one side frequency range
Y = np.fft.fft(y)/n # fft computing and normalization
Y = Y[range(int(n/2))]

plt.subplot(2, 1, 1)
plt.plot(t,data1,'k',t,iir,'r-')
plt.title('A = 0.99, B = 0.01')
plt.xlabel('Time')
plt.ylabel('Amplitude')

plt.subplot(2, 1, 2)
plt.loglog(frq,abs(Y1),'b',frq,abs(Y),'r')
plt.xlabel('Freq (Hz)')
plt.ylabel('|Y(freq)|')

plt.show()

#FIR


fir = []

fir_size = 15
fir_weight = h = [
    0.000000000000000001,
    -0.000691871108436514,
    0.000000000000000001,
    0.012663706537993771,
    0.053008364153035697,
    0.123627070314003176,
    0.196993410114205819,
    0.228798639978396140,
    0.196993410114205875,
    0.123627070314003190,
    0.053008364153035732,
    0.012663706537993799,
    0.000000000000000001,
    -0.000691871108436513,
    0.000000000000000001,
]

fir.extend([0] * fir_size)

for i in range(len(t)-fir_size):
    # print the data to verify it was read
    fir_sample = []
    for j in range(i,i+fir_size):
        fir_sample.append(data1[j])
    fir_sample = np.array(fir_sample)*np.array(fir_weight)
    fir.append(np.average(fir_sample))

Fs = 10000 # sample rate
Ts = 1.0/Fs; # sampling interval
ts = np.arange(0,t[-1],Ts) # time vector
y = fir # the data to make the fft from
n = len(y) # length of the signal
k = np.arange(n)
T = n/Fs
frq = k/T # two sides frequency range
frq = frq[range(int(n/2))] # one side frequency range
Y = np.fft.fft(y)/n # fft computing and normalization
Y = Y[range(int(n/2))]

plt.subplot(2, 1, 1)
plt.plot(t,data1,'k',t,fir,'r-')
plt.title('FIR low pass filer, 17 weights, cutoff frequency is 1000Hz,  bandwidth is 3500Hz')
plt.xlabel('Time')
plt.ylabel('Amplitude')

plt.subplot(2, 1, 2)
plt.loglog(frq,abs(Y1),'b',frq,abs(Y),'r')
plt.xlabel('Freq (Hz)')
plt.ylabel('|Y(freq)|')

plt.show()