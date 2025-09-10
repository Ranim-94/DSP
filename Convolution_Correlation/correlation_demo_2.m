

% A demo of correlation with a noisy delayed signal

% generate an input signal (a pulse)

close all,clear all,clc;

%% preparing the signal

choice_signal = 'rect_pulse_causal';
time_window = 200; % in s
nb_samples = 2000; % -> Fs = nb_samples/time_window = 100 Hz

Fs = nb_samples/time_window;

% generate signal depending on parameters
[signal,bandwidth,time_sampled,rect_pulse_width] = ...
generate_signal(choice_signal,time_window,nb_samples);

% hold the signal
temp_signal = signal;
                          
% plotting the signal                          
plot_rect_pulse(time_sampled,temp_signal,rect_pulse_width,'no_delay');

%% Add noise and delaying the signal

delay_s = 50;

signal_noisy_delayed = circshift(signal,delay_s*Fs) + 0.4*rand(1,nb_samples);
% the delay in s = 500/Fs = 500/10 = 50 s

% plotting the delayed and noisy part
plot_rect_pulse(time_sampled,signal_noisy_delayed,rect_pulse_width,'delay');

%% Correlation part

% computing correlation
Rxx = xcorr(signal_noisy_delayed,signal);
%- the signal_noisy_delayed playse the role of 
% a received signal which we don't know its identity
% - signal: it is our known signal in which we know
% we need to receive, capture, measure,...

% extacting the sampling period Ts
Ts = time_sampled(2) - time_sampled(1);

% generating time axis for the Rxx
% recall for an autocorrelation and for a signal of length N, 
% nb_points of Rxx = 2N -1;
time_Rx = (-nb_samples+1:nb_samples-1)*Ts;

plot_auto_correlation(time_Rx,Rxx)

