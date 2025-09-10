
clc, close all;

% Start and finish time
param.start_time = -8; param.time_duration = 8 ; 

% parameters for rect and sinc signals

rect_pulse_width = 0.5;

% for 0.5 s --> 2 Hz bandwidth 
rect_bandwidth = 1/rect_pulse_width;

sinc_pulse_width = 0.5;

% band sinc = 1/sinc_pulse_width
sinc_bandwidth_hz = 40;

sinc_genration_mode = ["time_base","freq_base"];

sinc_option = sinc_genration_mode(2);

% in Hz
param.fs = 30*sinc_bandwidth_hz;

% for printing and debugging
show_log = 1;

show_freq = 2*max(rect_bandwidth,sinc_bandwidth_hz);

%% Instantiating the object
dsp = signal_analysis(param) ;

%% Sampling 
[nb_of_samples,t_input] = dsp.sampling_uniform();

if show_log == 1
 
fprintf('********** Logging *********** \n');

fprintf('--> Fs Analog for Simulation: %d Hz \n',param.fs); 

fprintf('--> Observation Window: from %d to %d in s \n',...
param.start_time,param.time_duration);
   
fprintf('--> Total Nb of Samples over the observation window'),

fprintf(' for Fs %d Hz is : %.0f \n',param.fs,nb_of_samples);

fprintf(' Pulse width of the sinc: %.0f ms  \n',(1/sinc_bandwidth_hz)*1e3);

end 

%% Rect Signal generation

% rectpuls from signal processing toolbox
signal_rect = rectpuls(t_input,rect_pulse_width);



%% ************** sinc generation ***************


switch sinc_option
    
    case 'time_base'
 
signal_sinc = sinc(t_input/(sinc_pulse_width/2));


    case 'freq_base'
        
signal_sinc = sinc(2*sinc_bandwidth_hz*t_input);

end 

%% Computing the Spectrum of the input analog signal

param_ctft.signal_sampeled  = signal_rect ;

param_ctft.nb_of_samples  = nb_of_samples ;

param_ctft.zero_padd = 'True';


out_ctft_fft_rect = dsp.CTFT(param_ctft) ;

% for sinc

param_ctft.signal_sampeled  = signal_sinc ;

out_ctft_fft_sinc = dsp.CTFT(param_ctft) ;

%% Display 

figure(1)

%continous time domain plot
subplot(2,2,1),
plot(t_input,signal_rect);
xlim([-2*rect_pulse_width 2*rect_pulse_width]);
grid on;
set(gca,'fontsize',14,'fontweight','bold');
title(['Rectangulat pulse of width ',num2str(rect_pulse_width)],...
'Interpreter','Latex');
xlabel('Time (s)','Interpreter','Latex');
ylabel('Amplitude','Interpreter','Latex');


subplot(2,2,3),
plot(t_input,signal_sinc);
grid on;
set(gca,'fontsize',14,'fontweight','bold');
title('Sinc function ','Interpreter','Latex');
xlabel('Time (s)','Interpreter','Latex');
ylabel('Amplitude','Interpreter','Latex');


% CTFT plot


% for rect pulse
subplot(2,2,2),
plot(out_ctft_fft_rect.freq_vec_Hz,...
fftshift(out_ctft_fft_rect.amp));
xlim([-show_freq show_freq]);
grid on;
set(gca,'fontsize',14,'fontweight','bold');
title('CTFT of rectangular pulse','Interpreter','Latex');
xlabel('Frequency (Hz)','Interpreter','Latex');
ylabel('Amplitude Spectrum','Interpreter','Latex');

subplot(2,2,4),
% for sinc pulse
plot(out_ctft_fft_sinc.freq_vec_Hz,...
fftshift(out_ctft_fft_sinc.amp));
xlim([-show_freq show_freq]);
grid on;
set(gca,'fontsize',14,'fontweight','bold');
title('CTFT of Sinc','Interpreter','Latex');
xlabel('Frequency (Hz)','Interpreter','Latex');
ylabel('Amplitude Spectrum','Interpreter','Latex');


