



import numpy as np

import math

import Helper_Functions as hf

import matplotlib
import matplotlib.pyplot as plt

from scipy import fftpack 

matplotlib.rcParams.update({'font.size': 22, 
                            'text.usetex': True})



'''
In this script,
we are testing the effect of zero padding
       _ zero padding only give us more sample in the
              frequency spectrum to samples
       - it doesn't effect the frequency resolution
'''

nb_sample = 64

fft_length = (nb_sample,2*nb_sample, 4*nb_sample) 

# sampling freq

fs = 8000

Ts = 1/fs

freq_sin, amp = 500 , 2


start,end,step = 0,nb_sample*Ts,Ts

time_vec = np.arange(start,end,step)

signal = amp * np.sin(2* math.pi * freq_sin * time_vec)


fig_signal, ax_signal = plt.subplots(nrows = 1 , ncols = 1, figsize=(15,10))



ax_signal.plot(time_vec,signal)

ax_signal.set(xlabel = r'$t$ [s]',ylabel = 'Amplitude', 
              title = f"$f(t) \, = \,$ 2 sin $(2 \pi 500t)$" \
              f"\n $ F_s \, = \, {fs}$ ; Nb of Samples = {nb_sample}")

ax_signal.grid(True)

fig_signal.tight_layout()
fig_signal.savefig("Figures/Spectral_Analysis_1_Sin_time_domain.pdf")




#%%


# computing theoritcl sinc for Fourier transfrom of the sin


start, end, step = -fs/2 , fs/2, fft_length[-1]/128

freq_theoritcal = np.arange(start,end,step)

window_length = max(time_vec)/2

num1 =( 2 * math.pi *(freq_theoritcal - freq_sin) * window_length)/math.pi


num2 = (2 * math.pi *(freq_theoritcal + freq_sin) * window_length)/math.pi

sinc = (amp/2)*(np.sinc(num1) + np.sinc(num2))

fig, ax = plt.subplots(nrows = 1 , ncols = 3, figsize=(15,10))

# Start Analysis on zero padding effect
for count,zero_padd in enumerate(fft_length) :
       
       # Computing Fourier Transfrom
       # be aware that we are normalizing by nb_sample 
       # of time domain signal
       spectrum = fftpack.fft(signal,n = zero_padd)/nb_sample
       
       # if n > signal --> we will have zero padding effect 
       # best option of n: n = 2^nb_samples_in_signal
       # to employ radix algorithm
       

       # Shifting to make the spectrum symmetric
       spectrum = fftpack.fftshift(spectrum)
       
       
       # Computing Frequency vector: -Fs/2 --> Fs/2
       
       '''
       Either we can use np.linspace
       
       or fftpack.fftfreq(arg1,arg2):
              arg1: nb of samples we have in the spectrum computed
              arge 2: sampling time
              
       Recall also that f[Hz] has Nf points
       
       so f: (0: Nf - 1)* Fs
       
       Then we flip this frequency vector to make it 
       between [-Fs/2 --> Fs/2[
       
              Fs/s: is exclusive
       '''
       

       # Second Method to generate the freq vector:
              
       freq_vector = fftpack.fftshift(fftpack.fftfreq(len(spectrum),Ts)) 
       
       # plotting amplitude fft spectrum
       ax[count].plot(freq_vector,np.absolute(spectrum),label = 'FFT')
       
       # plotting theoritical sinc
       ax[count].plot(freq_theoritcal,np.abs(sinc) ,label = 'Theoritical Sinc')
       
       
       added_zero = zero_padd - nb_sample
       
       ax[count].set(xlabel = r'$f$ [Hz]',ylabel = 'Amplitude Spectrum',
                     title = f"Zero padd = {added_zero}")
       ax[count].grid(True)
       ax[count].legend(loc=0)
       
       
       
       
fig.tight_layout()

fig.savefig("Figures/Spectral_Analysis_1_Sin.pdf")    
       





