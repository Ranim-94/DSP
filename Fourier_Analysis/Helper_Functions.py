

import numpy as np

import math



def dft_of_ctft(continous_time_signal,sampling_freq,total_sample_nb):
       
       # Impelementing DFT{f(t)} formula

       # Spectral sampling Interval
       spectral_sampling_interval = (2 * math.pi)/total_sample_nb
       
       
       # Taking samples from continous time signal
       discret_time_signal =  (1/sampling_freq) * continous_time_signal
       
       # Specify the type as complex otherwise it will cast
       # the imaginary numbers
       dft_values = np.empty((total_sample_nb,), dtype = complex)
       
       
       # Computing DFT coefficients
       
       # r: 0 -->   total_sample_nb - 1
       for r in range(0,total_sample_nb):
              
               # assign 0 for the summation
               dft_values[r] = 0
              
               for k in range(0,total_sample_nb): 
                     
                     dft_values[r] = dft_values[r] + discret_time_signal[k] * \
                     np.exp(-1j * r * spectral_sampling_interval * k)
              
              
       # Computing the frequency components of the DFT coefficients
       # (0:No-1)*freq_sampling_interval * Fs/2
       freq_dft = np.arange(0,total_sample_nb,1) * \
       spectral_sampling_interval * sampling_freq
       
       
       return dft_values,freq_dft,spectral_sampling_interval


def dft_of_dtft(values_signal,nb_of_zero):
       
       '''
       Compute the DFT
       of DTFT
       '''
       zeros_val = np.zeros((nb_of_zero,))
       
       # the discrete time signal
       f = np.hstack((values_signal,zeros_val)) 
       
       # Spectral sampling Interval
       
       spectral_sampling_interval = 2* math.pi/len(f)
       
       '''
       Notice that the mode we add zeros, the len(f)
       increae --> spectral_sampling_interval decrease --> 
       we get more samples of the DTFT sepctrum 
       '''
       
       # ------------- Computing DFT --------------------
       
       Fr = np.empty((len(f),), dtype= complex)
       
       
       # Computing DFT coefficients
       
       # r: 0 -->   total_sample_nb - 1
       for r in range(0,len(f)):
              
               # assign 0 for the summation
               Fr[r] = 0
              
               for k in range(0,len(f)): 
                     
                     Fr[r] = Fr[r] + f[k] * \
                     np.exp(-1j * r * spectral_sampling_interval * k)
       
       
       # Computing the frequency components of the DFT coefficients
       # compute our samples of the continuous frequency vector Omega
       # samples go from 0 to 2pi in increments of Omega0
       
       wvec = np.arange(0,len(f),1) * spectral_sampling_interval
       
       return Fr,wvec,spectral_sampling_interval
       

def dtft_loop(discrete_time_signal,discrete_freq):
       
       
       '''
       Computing DTFT using the for loop formula
       No analytical expression in this case
       
       The DTFT using the for loop formula will depend
       on the truncation factor (so lenght of the discrete time signal) 
       we set
       '''
       
       # allocating
       dtft_loop_values = np.empty((len(discrete_freq),) , dtype= complex)
       
       dtft_loop_values = 0
       
       for k in range(0,len(discrete_time_signal)):
              
              
              dtft_loop_values = dtft_loop_values + discrete_time_signal[k] * \
              np.exp(-1j * discrete_freq * k) 
              
              '''
              
              0 < discrete_freq  < 2 pi
              
              Notice that the DTFT using a for loop
              depends on w_d: the contious frequency of discrete domains
              
              0 < w_d < 2 pi
              
              Also  notice that we loop depending on the 
              number of samples of the truncated discret time vector k_vec 
              '''
              
              
       return dtft_loop_values
       
       