


import numpy as np

import math

import matplotlib
import matplotlib.pyplot as plt


import  Helper_Functions as hf

matplotlib.rcParams.update({'font.size': 13, 
                            'text.usetex': True})





# ---------- Computing the theoritcal part for comparision ---------

# the fequency components

start, end, nb_point = \
0, 2 * math.pi , 1024 

# Recall that in DTFT, the frequecy is continous variable
# between -pi and pi (equivalent to 0 --> 2 pi),
w = np.linspace(start, end, nb_point)

# Computing DTFT

F = np.exp(-1j* w) * (2 + 6 * np.cos(w))


#------------------------------------------------------------------------

# Setting the discrete time signal

# the number of zeros we add: a hyperparameter to tune and see
# the resutls
nb_of_zero = (0,4,8,16)

values_signal = np.array([3,2,3]) 

fig, ax = plt.subplots(nrows = 2 , ncols = 2, figsize = (8,10) )

# for plotting
row_index, col_index  = 0,0

for count,zero_val in enumerate(nb_of_zero, start = 1):
       
       Fr,wvec,Omega_0 = hf.dft_of_dtft(values_signal,zero_val)
       
       Omega_0 = format(Omega_0,'.2f')
       
# ------------ Plotting the results ---------------------------

              
       # DTFT
       ax[row_index][col_index].plot(w, np.absolute(F), label = 'DTFT')
       
       # DFT of DTFT
       ax[row_index][col_index].stem(wvec, np.absolute(Fr), 
                                 'g',label = "DFT Values",markerfmt = 'ro')
       
       ax[row_index][col_index].set_xlim((0,2 * math.pi))
       
       ax[row_index][col_index].grid(True)
       
       ax[row_index][col_index].set(xlabel = r'$\omega_d$ ', 
                                ylabel  = 'Amplitude Spectrum',
              title = \
              f'Nb of zero padding:{zero_val} \n $\Omega_0$ = {Omega_0}')
       
       ax[row_index][col_index].legend(loc=0)
       
       # shift the column postion
       col_index += 1
       
       if count % 2 == 0:
              row_index += 1
              col_index = 0
       





fig.tight_layout()

fig.savefig("Figures/DFT_Discrete_time_Finite_Length.pdf")






