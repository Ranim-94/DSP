


import numpy as np

import math

import Helper_Functions as hf

import matplotlib
import matplotlib.pyplot as plt

matplotlib.rcParams.update({'font.size': 14, 
                            'text.usetex': True})


param = {
       
        # in seconds 
       'Fs': (16 , 2, 4, 8),
       
       # set signal duration (s)
       'signal_time': 16
       
       }



# ---------- Computing the theoritcal part for comparision ---------
       
       
'''
 Whatever the sampling rate we are testing, the theoretical CTFT
will always have the correct Fs = 16 samples/s 
'''     

correct_sampling_rate = 16
# the fequency components
start, end, nb_point = 0, 2 * math.pi * (correct_sampling_rate /2) , 2048 
       
       # We add +1 cz linspace is exclusive
       #Sampling theory results: 
       # In continous frequency, we see from 0 --> ws/2 
w = np.linspace(start, end, nb_point)
              
        
# Continous time signal f(t)
amp = 0.5       
       # magnitude of F(w)       
absf = 1/np.sqrt(w**2 + amp**2)
       



fig, ax = plt.subplots(nrows = 4 , ncols = 2, figsize=(14,14))

for count,sampling_rate in enumerate(param['Fs']) :
       
       
       sampling_time = 1/sampling_rate
       
       total_sample_nb = int(param['signal_time']/ sampling_time)
       
       
       # signal: x(t) = e(-at) u(t)
       
       # Generating time vector
       # Don't forget to multiply by Ts to scale the t vector into seconds
       start, end , nb_point = \
       0 , param['signal_time'], total_sample_nb
       
       t = np.linspace(start,end,nb_point)
       
       f = np.exp(-amp * t)
       
       # Computing dft of the CTFT
       dft_values,freq_dft,spectral_sampling_interval = \
       hf.dft_of_ctft(f,sampling_rate,total_sample_nb)
       
       
       # formatting
       spectral_sampling_interval = format(spectral_sampling_interval,'.2f')

       #----------------------  Plotting results -----------------------------
       
       
       # plotting the continous time signal
       ax[count][0].plot(t, f, 
              label = f"$F_s = {sampling_rate}$ sample/s ; $T_0 = {param['signal_time']}$ s")
       
       ax[count][0].set(xlabel = r'$t$ [s]', ylabel  = r'$f(t)$', 
                 title = r'$f(t)$ = exp$(-0.5)t \, u(t) $')
       
       ax[count][0].grid(True)
       ax[count][0].legend(loc=0)
       
       
       # CTFT
       ax[count][1].plot(w/(2 * math.pi), absf, label = f'CTFT')
       
       # DFT of CTFT
       ax[count][1].stem(freq_dft/(2 * math.pi), np.absolute(dft_values), 'g',
       label = f"DFT ; \n $\Omega_0 \, = \, {spectral_sampling_interval}$ ; \n $N_0 \, = \, {total_sample_nb} $", 
                  markerfmt = 'ro')
       
       ax[count][1].set_xlim((0,sampling_rate/2))
       
       ax[count][1].grid(True)
       
       ax[count][1].set(xlabel = r'$f$ [Hz]', ylabel  = 'Amplitude Spectrum')
       
       ax[count][1].legend(loc=0)
       
       

fig.tight_layout()

fig.savefig("Figures/DFT_Continous_time_sampling_rate.pdf")
