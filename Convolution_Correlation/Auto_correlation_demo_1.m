% Description
% Demo 1: a first example about applying autocorrolation 
% signal used: a rect pulse
% computation: the Rxx
% plot the time domain signal and Rxx

% A demo about autocorrelation
clear all, close all, clc;


%preparing the signal

choice_signal = 'rect_pulse';
choice_plot = 'no_delay';
time_window = 10; % in s
nb_samples = 100;

% generate signal depending on parameters
[signal,bandwidth,time_sampled,rect_pulse_width] = ...
generate_signal(choice_signal,time_window,nb_samples);
                          
% plotting the signal in time domain                         
plot_rect_pulse(time_sampled,signal,rect_pulse_width,choice_plot);

% computing correlation
Rxx = xcorr(signal);

% extacting the sampling period Ts
Ts = time_sampled(2) - time_sampled(1);

% generating time axis for the Rxx
% recall for an autocorrelation and for a signal of length N, 
% nb_points of Rxx = 2N -1;
time_Rx = (-nb_samples+1:nb_samples-1)*Ts;

plot_auto_correlation(time_Rx,Rxx)






