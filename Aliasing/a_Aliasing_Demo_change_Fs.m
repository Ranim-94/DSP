

clc, close all;

% Specifying parameters

param.signal_name = 'cos';

% in s
param.time_duration = 0.1; 

% Initial Sampling Rate inn Hz
param.fs = 8e3; 


% Instantiating the object 
dsp = signal_analysis(param);


f_cos_val = [2.5e3,30];

f_sin_val = [1e3,0];


% index to select frequency of cos and sin
selct_freq = 1;

[nb_of_samples,t_sampled] = dsp.sampling_uniform();

f_cos = f_cos_val(selct_freq); f_sin = f_sin_val(selct_freq);
    
signal = 5*sin(2*pi*f_sin.*t_sampled) + cos(2*pi*f_cos.*t_sampled);
    
    

    
show_freq = max(f_cos,f_sin)+ 100;


%% Performing CTFT 
% Encapsulating param
 
param_ctft.nb_of_samples = nb_of_samples;

param_ctft.signal_sampled = signal;

param_ctft.signal_name = param.signal_name ;
         
% Invoking CTFT
[freq_vector_fft,ctft_fft] = dsp.CTFT(param_ctft);


%% Dowsampling part

down_samp_factor = 2;

fs_new = param.fs/down_samp_factor;

% changing the sampling rate in the object
dsp = dsp.change_param(fs_new);


% downsampling 
signal_down = signal(1:down_samp_factor:end);

% Perfomring CTFT

param_ctft.nb_of_samples = length(signal_down);
param_ctft.signal_sampled = signal_down;


param_ctft.signal_name = param.signal_name;
         
% Invoking CTFT
[freq_vector_fft_down,ctft_fft_down] = dsp.CTFT(param_ctft);






figure(1)
%  CTFT Original Signal with Original Fs
subplot(1,2,1),
plot(freq_vector_fft,abs(ctft_fft),'r','linewidth',1);
xlim([0 show_freq]);grid on,
set(gca,'fontsize',14,'fontweight','bold');
xlabel('Frequency (Hz)','Interpreter','latex');
title('Before Downsampling','Interpreter','latex');
ylabel('$|X(f)|$','Interpreter','latex');


% CTFT using FFT for downsampeled Fs: aliasing occure here
subplot(1,2,2),
plot(freq_vector_fft_down,abs(ctft_fft_down),'b','linewidth',1);
grid on;
xlim([0 show_freq]);
set(gca,'fontsize',14,'fontweight','bold');
xlabel('Frequency (Hz)','Interpreter','latex');
title('After Downsampling','Interpreter','latex');
ylabel('$|X(f)|$','Interpreter','latex');



