


import numpy as np

import math

import Helper_Functions as hf

import matplotlib
import matplotlib.pyplot as plt

matplotlib.rcParams.update({'font.size': 22, 
                            'text.usetex': True})


param = {
       
        # in sample/s 
       'Fs': 16,
       
       # set signal duration (s)
       'signal_time': (16,8,4,2)
       
       }



# ---------- Computing the theoritcal part for comparision ---------
       
       
'''
 Whatever the sampling rate we are testing, the theoretical CTFT
will always have the correct Fs = 16 samples/s 
'''     


# the fequency components
start, end = 0, 2 * math.pi * param['Fs']/2
       
       # We add +1 cz linspace is exclusive
       #Sampling theory results: 
       # In continous frequency, we see from 0 --> fs/2
       # fcont is in hz
w_cont = np.linspace(start, end, 2560 )
              
        
# Continous time signal f(t)
amp = 0.5       
# magnitude of F(w)       
absf = 1/np.sqrt(w_cont**2 + amp**2 )
       



fig, ax = plt.subplots(nrows = 1 , ncols = 1, figsize=(15,10))

for count,signal_duration in enumerate(param['signal_time']) :
       

       total_sample_nb = int(signal_duration * param['Fs'])
       
       
       # signal: x(t) = e(-at) u(t)
       
       # Generating time vector
       # Don't forget to multiply by Ts (= 1/Fs) to scale the t vector into seconds
       start, end , nb_point = \
       0 , total_sample_nb * (1/param['Fs']), total_sample_nb
       
       t = np.linspace(start,end,nb_point)
       
       f = np.exp(-amp * t)
       
       # Computing dft of the CTFT
       dft_values,freq_dft,spectral_sampling_interval = \
       hf.dft_of_ctft(f,param['Fs'],total_sample_nb)
       
       
       # formatting
       spectral_sampling_interval = format(spectral_sampling_interval,'.2f')

       #----------------------  Plotting results -----------------------------
       
       fig, ax = plt.subplots(nrows = 1 , ncols = 2, figsize=(15,10))
       # plotting the continous time signal
       ax[0].plot(t, f, 
              label = f"$F_s = {param['Fs']}$ sample/s ; $T_0 = {signal_duration}$ s")
       
       ax[0].set(xlabel = r'$t$ [s]', ylabel  = r'$f(t)$', 
                 title = r'$f(t)$ = exp$(-0.5)t \, u(t) $')
       
       ax[0].grid(True)
       ax[0].legend(loc=0)
       
       
       # plotting CTFT analytical formula
       ax[1].plot(w_cont/(2*math.pi), absf, label = f'CTFT')
       
       # DFT of CTFT
       ax[1].stem(freq_dft/(2*math.pi), np.absolute(dft_values), 'g',
       label = f"DFT ; \n $\Omega_0 \, = \, {spectral_sampling_interval}$ ; \n $N_0 \, = \, {total_sample_nb} $", 
                  markerfmt = 'ro')
       
       ax[1].set_xlim((0,param['Fs']/2))
       
       ax[1].grid(True)
       
       ax[1].set(xlabel = r'$f$ [Hz]', ylabel  = 'Amplitude Spectrum')
       
       ax[1].legend(loc=0)
       
       fig.tight_layout()
       
       fig.savefig(f"Figures/DFT_CTFT_{count}.pdf")
       
       




