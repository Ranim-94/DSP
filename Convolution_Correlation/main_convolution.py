


"""
Convolution: is the operation in which

"""

import numpy as np

from DSP import SignalProcessing

# ======================= Start the Script =======================

# define bandwidth
band_hz = 10

Fs = 5*band_hz

# define time vectors
start_time,end_time = -2,2

signal_name = "sinc"

# Instantiate the object
dsp = SignalProcessing(start_time,end_time,Fs,signal_name,band_hz)

# generating signal
input_signal,time = dsp.generate_real_sampled_signal()

# Save to file
np.savetxt("sinc_data.txt", np.column_stack((time, input_signal)),
           delimiter=", ", fmt="%.6f")

#dsp.plot_time_real_signal(input_signal)

spectrum,freq_bins = dsp.compute_spectrum(input_signal)

#dsp.plot_spectrum(freq_bins,spectrum)

out_convolution = dsp.convolve(input_signal,input_signal,False)

print("Finish Program")


