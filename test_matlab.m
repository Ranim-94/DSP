


clear all, close all, clc;

B_Hz = 10;

Fs = 4*B_Hz;

time_axis = 0:(1/Fs):5;

signal = sinc(2*B_Hz*time_axis);

nb_points = length(signal);

spectrum = fftshift(fft(2*signal));

freq_step = Fs/nb_points;

freq_bin = -Fs/2:freq_step:Fs/2-freq_step;

plot(freq_bin,abs(spectrum))
title("fft Spectrum")
xlabel("f (Hz)")
ylabel("|fft(X)|")



