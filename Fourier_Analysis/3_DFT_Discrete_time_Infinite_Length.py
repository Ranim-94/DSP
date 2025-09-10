


import numpy as np

import math

import matplotlib
import matplotlib.pyplot as plt


import  Helper_Functions as hf

matplotlib.rcParams.update({'font.size': 13, 
                            'text.usetex': True})


a = 0.8

'''
f = (a)^k * u[k]

This signal goes for ever to the right
we need to truncate in order to deal with it
'''


# ----------- DTFT Analytical Formula ---------------

'''
F = 1./(1-a*exp(-j*Omega));

this expression for F is something we look up in a table, it is a function
of the continuous variable Omega where 0 < Omega_d < 2 pi
'''

start, end, nb_point = \
0, 2 * math.pi , 4096 

# Recall that in DTFT, the frequecy is continous variable
# between -pi and pi (equivalent to 0 --> 2 pi),
discrete_freq = np.linspace(start, end, nb_point)


dtft_analytical = 1/(1 - a* np.exp(-1j * discrete_freq))


# ------------- Generating the time domain discrete signal ---------



# this parameter will control the singal f = (a)^k * u[k]
discrete_signal_length = (4,8,16,32)


# for plotting
row_index  = 0

# For now: we don't consider the effect of zero padding
zero_val = 0

# plotting the results      
fig, ax = plt.subplots(nrows = 4 , ncols = 2, figsize = (12,10) )

for row_index,sample_nb_discrete_time_signal in \
enumerate(discrete_signal_length):
       
       # Generating vector k
       start, end, step = 0, sample_nb_discrete_time_signal + 1, 1
       
       k_vec = np.arange(start, end, step)
       
       # Discrete time signal
       discrete_time_signal = a**k_vec
       

       dft_values,wvec,Omega_0 = hf.dft_of_dtft(discrete_time_signal,zero_val)
       
       # formatting
       Omega_0 = format(Omega_0,'.2f')
       
       # Computing DTFT using loop formula: no analytical expression
   

       '''
       Now computing DTFT using the for loop formula
       No analytical expression in this case
       
       The DTFT using the for loop formula will depend
       on the truncation factor we set
       '''
       
       dtft_loop_values = hf.dtft_loop(discrete_time_signal,discrete_freq)
       
       
       # Discret time signal 
       ax[row_index][0].stem(k_vec,discrete_time_signal, 
                             label = f'$p$ = {sample_nb_discrete_time_signal}')
       
       base,exponent = a,sample_nb_discrete_time_signal
       
       ax[row_index][0].set(xlabel = r'$k$ ',ylabel  = r'$f[k]$',
              title = f'$f[k]  = a^p \, u[k] $')
       
       ax[row_index][0].grid(True)
       
       ax[row_index][0].legend(loc=0)
       
       # DTFT Anayltical 
       ax[row_index][1].plot(discrete_freq,np.absolute(dtft_analytical), 
                             label = 'DTFT Analytical Formula')
       
       # DFT loop formula
       ax[row_index][1].plot(discrete_freq, np.absolute(dtft_loop_values), 
                             label = 'DTFT Loop Formula')
       
       # DFT of DTFT
       ax[row_index][1].stem(wvec, np.absolute(dft_values), 
                                 'g',label = "DFT Values",markerfmt = 'ro')
       
       ax[row_index][1].set_xlim((0,2 * math.pi))
       
       ax[row_index][1].grid(True)
       
       ax[row_index][1].set(xlabel = r'$\omega_d$ rad/sample ', 
                                ylabel  = 'Amplitude Spectrum',
              title = \
              f'Nb of samples of $f$:{sample_nb_discrete_time_signal} \n $\Omega_0$ = {Omega_0}')
       
       ax[row_index][1].legend(loc=0)
       
       ax[row_index][1].grid(True)
       
             

fig.tight_layout()

fig.savefig("Figures/DFT_Discrete_time_Infinite_Length.pdf")             

       
       
       
   
       
       
       









