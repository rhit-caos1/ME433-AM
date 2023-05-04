import csv
import matplotlib.pyplot as plt # for plotting
import numpy as np # for sine function

t = [] # column 0
data1 = [] # column 1


with open('sigD.csv') as f:
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

hpf_fir_weight = [
    -0.000000000000000001,
    0.000000000000000000,
    -0.009873601158756899,
    -0.021279540272210441,
    0.059144604580114314,
    0.271300038405773825,
    0.401416996890158473,
    0.271300038405773825,
    0.059144604580114349,
    -0.021279540272210452,
    -0.009873601158756899,
    0.000000000000000000,
    -0.000000000000000001,

]
hpf_fir = []
hpf_fir_size = 13
hpf_fir.extend([0] * hpf_fir_size)

for i in range(len(t)-hpf_fir_size):
    # print the data to verify it was read
    fir_sample = []
    for j in range(i,i+hpf_fir_size):
        fir_sample.append(avg[j])
    fir_sample = np.array(fir_sample)*np.array(hpf_fir_weight)
    hpf_fir.append(np.average(fir_sample))

Fs = 10000 # sample rate
Ts = 1.0/Fs; # sampling interval
ts = np.arange(0,t[-1],Ts) # time vector
y = hpf_fir # the data to make the fft from
n = len(y) # length of the signal
k = np.arange(n)
T = n/Fs
frq = k/T # two sides frequency range
frq = frq[range(int(n/2))] # one side frequency range
Y = np.fft.fft(y)/n # fft computing and normalization
Y = Y[range(int(n/2))]

plt.subplot(2, 1, 1)
plt.plot(t,data1,'k',t,avg,'g-',t,hpf_fir,'r-')
plt.title('number of points for averaging = 100, with LPF, cutoff frequency is 2000Hz,  bandwidth is 4000Hz')
plt.xlabel('Time')
plt.ylabel('Amplitude')

plt.subplot(2, 1, 2)
plt.loglog(frq,abs(Y1),'b',frq,abs(Y),'r')
plt.xlabel('Freq (Hz)')
plt.ylabel('|Y(freq)|')

plt.show()


#IIR

iir = []
A = 0.8
B = 1-A
est = 0

for i in range(len(t)):
    # print the data to verify it was read
    s = []
    est = A*est+B*data1[i]
    iir.append(est)

hpf_fir_weight = [
    -0.000000000000000001,
    0.000000000000000000,
    -0.009873601158756899,
    -0.021279540272210441,
    0.059144604580114314,
    0.271300038405773825,
    0.401416996890158473,
    0.271300038405773825,
    0.059144604580114349,
    -0.021279540272210452,
    -0.009873601158756899,
    0.000000000000000000,
    -0.000000000000000001,

]
hpf_fir = []
hpf_fir_size = 13
hpf_fir.extend([0] * hpf_fir_size)

for i in range(len(t)-hpf_fir_size):
    # print the data to verify it was read
    fir_sample = []
    for j in range(i,i+hpf_fir_size):
        fir_sample.append(iir[j])
    fir_sample = np.array(fir_sample)*np.array(hpf_fir_weight)
    hpf_fir.append(np.average(fir_sample))

Fs = 10000 # sample rate
Ts = 1.0/Fs; # sampling interval
ts = np.arange(0,t[-1],Ts) # time vector
y = hpf_fir # the data to make the fft from
n = len(y) # length of the signal
k = np.arange(n)
T = n/Fs
frq = k/T # two sides frequency range
frq = frq[range(int(n/2))] # one side frequency range
Y = np.fft.fft(y)/n # fft computing and normalization
Y = Y[range(int(n/2))]

plt.subplot(2, 1, 1)
plt.plot(t,data1,'k',t,iir,'g-',t,hpf_fir,'r-')
plt.title('A = 0.8, B = 0.2, with LPF, cutoff frequency is 2000Hz,  bandwidth is 4000Hz')
plt.xlabel('Time')
plt.ylabel('Amplitude')

plt.subplot(2, 1, 2)
plt.loglog(frq,abs(Y1),'b',frq,abs(Y),'r')
plt.xlabel('Freq (Hz)')
plt.ylabel('|Y(freq)|')

plt.show()

#FIR


lpf_fir = []

#LPF

lpf_fir_size = 17
lpf_fir_weight = [
    0.000000000000000000,
    0.000391085607900160,
    0.003353289830491750,
    -0.000000000000000003,
    -0.025737623466723879,
    -0.034606372223859476,
    0.072380599422168998,
    0.284176158482516983,
    0.400085724695010803,
    0.284176158482516983,
    0.072380599422169012,
    -0.034606372223859504,
    -0.025737623466723893,
    -0.000000000000000003,
    0.003353289830491754,
    0.000391085607900160,
    0.000000000000000000,
]
lpf_fir.extend([0] * lpf_fir_size)

for i in range(len(t)-lpf_fir_size):
    # print the data to verify it was read
    fir_sample = []
    for j in range(i,i+lpf_fir_size):
        fir_sample.append(data1[j])
    fir_sample = np.array(fir_sample)*np.array(lpf_fir_weight)
    lpf_fir.append(np.average(fir_sample))

#hpf
hpf_fir_weight = [
1
]
hpf_fir = []
hpf_fir_size = 1
hpf_fir.extend([0] * hpf_fir_size)

for i in range(len(t)-hpf_fir_size):
    # print the data to verify it was read
    fir_sample = []
    for j in range(i,i+hpf_fir_size):
        fir_sample.append(lpf_fir[j])
    fir_sample = np.array(fir_sample)*np.array(hpf_fir_weight)
    hpf_fir.append(np.average(fir_sample))


Fs = 10000 # sample rate
Ts = 1.0/Fs; # sampling interval
ts = np.arange(0,t[-1],Ts) # time vector
y = hpf_fir # the data to make the fft from
n = len(y) # length of the signal
k = np.arange(n)
T = n/Fs
frq = k/T # two sides frequency range
frq = frq[range(int(n/2))] # one side frequency range
Y = np.fft.fft(y)/n # fft computing and normalization
Y = Y[range(int(n/2))]

plt.subplot(2, 1, 1)
plt.plot(t,data1,'k',t,hpf_fir,'r-')
plt.title('FIR low pass filer, 17 weights, cutoff frequency is 3000Hz,  bandwidth is 3000Hz')
plt.xlabel('Time')
plt.ylabel('Amplitude')

plt.subplot(2, 1, 2)
plt.loglog(frq,abs(Y1),'b',frq,abs(Y),'r')
plt.xlabel('Freq (Hz)')
plt.ylabel('|Y(freq)|')

plt.show()