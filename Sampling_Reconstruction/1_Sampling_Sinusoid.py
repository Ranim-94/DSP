


import numpy as np


from Helper_Functions import comp_alias_freq

import math

import matplotlib
import matplotlib.pyplot as plt

matplotlib.rcParams.update({'font.size': 22,
                            'lines.linewidth':2,
                            'text.usetex': True})





# parameter to tuned
'''
freq: frequency of the signal
fs: sampling frequency
'''

freq_signal, fs = [1, 1.3 , 1.7] , 2



for count,freq in enumerate(freq_signal):

       # set time vector and frequency for "continous-time" sinusoid
       # taking a step every 1 ms
       start,end,step_cont = 0,5, math.pow(10, -3)
       
       tcont = np.arange(start,end + step_cont,step_cont)
       
       # generating the signal
       xcont = np.cos(2 * math.pi * freq * tcont)
       
       
       # fs: 2 sample per second
       step_sample =  1/fs
       
       # here we are generating the samples (just points) at each
       # time step Ts
       tsamp = np.arange(start,end + step_sample,step_sample)
       
       xsamp = np.cos(2 * math.pi * freq * tsamp)
       
       fig, ax = plt.subplots(nrows = 1 , ncols = 1, figsize=(15,10))
       
       ax.plot(tcont,xcont,
               label = f'Continous Time Signal')
       
       ax.set(xlabel = 'Time [s]', ylabel = f'cos$(2 \pi f t)$')
       
       
       ax.plot(tsamp,xsamp,'ko',label = 'Sampled Signal')
       
       ax.legend(loc = 1) , ax.grid(True)



# ----------------- Computing Aliased Frequency --------------



       f_alias,m = comp_alias_freq(fs,freq)
       
       
       
       if f_alias != freq:
              
              # plotting the aliase signal
              '''
              Notice that in aliasing effect:
                     - we took the same tcont time ax[count]is
                     as the continous time signal
                     - but we put the f_alias to show
                     the effect of aliasing
              '''              
              ax.plot(tcont,np.cos(2 * math.pi * f_alias * tcont),
                      label = 'Aliase Signal')
              
              ax.legend(loc = 1)
              
              # ax[count].set(title = f'Signal Freq = {freq} \n Sampling freq = {fs} \n Alias Freq = {f_alias} Hz \n ')
              
              # formatting
       
              f_alias = format(f_alias,'.2f')
              
              ax.set_title(f'Signal Freq = {freq} Hz \n Sampling Freq = {fs} Hz \n Alias Freq = {f_alias} Hz ')
              
              fig.savefig(f"Figures_Sampling/Signal_Alias_{f_alias}.pdf")
              fig.tight_layout()
       
       else:
              
              # No aliasing
              ax.plot(tcont,np.cos(2 * math.pi * f_alias * tcont))
              ax.set(title = f'Signal Freq = {freq} Hz \n Sampling Freq = {fs} Hz  \n No aliasing')
              
              fig.savefig(f"Figures_Sampling/Signal_No_Alias_{count}.pdf")
              fig.tight_layout()
       


