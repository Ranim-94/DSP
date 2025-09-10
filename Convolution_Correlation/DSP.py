
"""
This module contains some general signal processing operation
It is meant to be for training, and testing also
from signal generation, time operation as convolution, spectral analysis (fft)...
"""



import numpy as np

import matplotlib.pyplot as plt
from IPython.core.pylabtools import figsize
from numpy.typing import NDArray
from scipy.fft import fft, fftshift, fftfreq
from scipy import signal
from sqlalchemy.sql.operators import truediv


class SignalProcessing:

    def __init__(self,start_time:float,end_time:float,
                      Fs:float,
                      signal_name:str,
                      band_hz:float):

        self.start_time = start_time
        self.end_time = end_time

        self.Fs = Fs

        # generate time axis
        self.time = np.arange(self.start_time,
                              self.end_time,(1/self.Fs))

        self.signal_name = signal_name

        self.band_hz = band_hz

    def generate_real_sampled_signal(self)->NDArray[np.float64]:

        if self.signal_name == "sinc_square":

            signal = self.band_hz * np.square(np.sinc(self.band_hz*self.time))

        elif self.signal_name == "sinc":

            signal = self.band_hz * np.sinc(self.band_hz*self.time)

        return signal,self.time

    def compute_spectrum(self,time_signal):

        # generating spectrum using fft
        # the signal is assumed to be sampled uniform
        spectrum = fft(time_signal)

        spectrum = fftshift(spectrum)

        # generate freq bins from [-Fs/2;Fs/2[
        freq_bins = fftshift(fftfreq(len(time_signal), (1 / self.Fs)))

        return spectrum,freq_bins

    def convolve(self,x: NDArray[np.float64],
                 y: NDArray[np.float64],
                 plot_option:bool) -> NDArray[np.float64]:

        convoluted_signal = signal.convolve(x, y, mode="full", 
                                            method="fft")

        if plot_option == True:
            fig, ax = plt.subplots(1, 1)

            ax.plot(self.time, convoluted_signal)
            ax.set_ylabel('Amp')
            ax.set_xlabel('time')
            ax.grid(True)

            fig.savefig(self.signal_name + "convolution_plot.pdf")


        return convoluted_signal

    def plot_time_real_signal(self,signal)->None:

        fig,ax = plt.subplots(2,1, figsize=(7,8))

        ax[0].plot(self.time,signal)
        ax[0].set_ylabel('Amp')
        ax[0].grid(True)

        # plotting from sub interval (zooming in)

        cut_time = 20

        sub_interval = (self.time >= self.start_time/cut_time) & (self.time < self.end_time/cut_time)
        zoomed_time = self.time[sub_interval]

        ax[1].plot(zoomed_time, signal[sub_interval])
        ax[1].set_xlabel('t[s]')
        ax[1].set_title('Zoomed in Plot')
        ax[1].set_ylabel('Amp')
        ax[1].grid(True)

        fig.savefig(self.signal_name+"_plot.pdf")


    def plot_spectrum(self,freq_axis,spectrum)->None:

        fig, ax = plt.subplots(1, 1)

        ax.plot(freq_axis, np.abs(spectrum))
        ax.set_ylabel('Amp')
        ax.set_xlabel('F[Hz]')
        ax.grid(True)

        fig.savefig(self.signal_name + "_spectrum_plot.pdf")









