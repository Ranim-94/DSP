

clc, clear all, close all;

choice_sig = {'sin','sum_of_sinusoids_2','sum_of_sinusoids_3','sinc'};

% choose what type of signal
choice = choice_sig(4);

% choose option to display plot option
show_signal_in_time_array = ["show_sin","show_sinc"];
param_plot.show_signal_in_time = show_signal_in_time_array(2);

nb_channel = 2;

% choose bandwidth of sinc
bandwidth_Hz = 10 ;

f_Nyq = 2*bandwidth_Hz;

% this will be used to sample above B (bandwidth of the signal)
% slightly
f_offset = 5;

% in Hz: this is an undersampling sampling rate < F_Nyquist 
fs_ch = bandwidth_Hz + f_offset ;

oversampling_factor = 30;

fs_in = oversampling_factor*bandwidth_Hz;


% choose what type of new Fs to simulate, in Hz
target_Fs = [60,15];

param_plot.dtft_plot = 'aliasing';

% alias frequnce
f_alias = abs(bandwidth_Hz - fs_ch) ;

% this is to test: to convert from rad/cycle --> Hz
% formula used: F[Hz] = \omega[rad/cycle] x (Fs/(2*pi))
% I have many Fs to test
param_plot.fs_to_scale = 15/2;

% Undersampling rate will be bandwidth_Hz + f_offset

% multiplicative factor: if in ms --> 1e3
% if in micro s --> 1e6
time_scale = 1e3;

% It control the delay: if it is in ms or micro s
% also use it in plotting the x-axis (which is the time axis)

param_plot.time_scale_option_input_signal = 'ms';


show_debug = 1;

run_rest = 1;

% choose 1 if you need to display, 0 otherwise
show_log = 1;


% in s
param.time_duration = 50;

param.start_time = -50;



% in ms or micros or whatever: this is dimensionless
show_time = 50;

switch nb_channel
    
    case 5
        
      delayed_channels = [0,0.02 , 0.034, 0.047, 0.05];  
        
      gain_channels = [1,0.5,0.1,0.5,0.35];

     % gain_channels = randi(10,1,nb_channel)/20;

    case 2
        
       delayed_channels = [35,14]*(1/time_scale); 
       
       gain_channels = [1,0.5];
       
        % setting first gain to 1
    gain_channels(1) = 1;
        
        
end 

amp_cos = 2;

% for display in the x-axis of the FFT plot for the Spectrum
show_freq = 2*bandwidth_Hz;

param.fs = fs_in;

show_freq_input = show_freq;


how_many = 2;

%% ******************* Start of the code *******************************

% Lower bound of Fs per channel
bound_fs_ch = (2*pi*bandwidth_Hz)/(nb_channel*pi) ;



% Instantiating the object
dsp = signal_analysis(param) ;

%**************************************************************
% Sampling 
[nb_of_samples,t_input] = dsp.sampling_uniform();


%**************** Logging *********************

if show_debug == 1

fprintf('--> Fs Analog for Simulation: %d Hz \n',param.fs);    
    
fprintf('--> Bandwidth of Input Signal: %d Hz \n',bandwidth_Hz);    
    
fprintf('--> Lower Bound on Fs_ch: %.1f Hz \n',bound_fs_ch);

fprintf('--> Chosen Sampling Rate per channel: %d Hz \n',fs_ch);

fprintf('--> Alias Frequency: %d Hz \n \n',f_alias);

fprintf('********************************************** \n \n');

fprintf('--> Observation Window: from %d to %d in s \n',...
param.start_time,param.time_duration);    
    
fprintf('--> Total Nb of Samples over the observation window'),

fprintf(' for Fs = %d Hz is : %.0f \n',param.fs,nb_of_samples);

end 



%**************************************************************

% Generating input signal

% input_signal = normrnd(0,1,[1,length(t_sampled)]);

% Preparing Parameters
param_sig.t_input = t_input; param_sig.f_cos = bandwidth_Hz ;
param_sig.amp_cos = amp_cos;


% Instantiation of the object
sig_generator = signal_generation(param_sig) ;

% Generate the input analog signal
input_signal = sig_generator.generate(choice);

%**************************************************************

% Computing the Spectrum of the input analog signal

param_ctft.signal_sampeled  = input_signal ;

param_ctft.nb_of_samples  = nb_of_samples ;

param_ctft.zero_padd = 'False';


out_ctft_fft_input = dsp.CTFT(param_ctft) ;


%******************* Plotting **********************

what_to_plot = 'ctft_plot';

% Encapsulating parameter for plotting
param_plot.t_input = t_input;

param_plot.start_time = param.start_time;


param_plot.bandwidth_Hz = bandwidth_Hz;

param_plot.input_signal = input_signal;
param_plot.nb_of_samples = nb_of_samples;


param_plot.Ts = 1/param.fs;

param_plot.show_time = show_time;

% Sepctrum
param_plot.freq_vector_input = out_ctft_fft_input.freq_vec_Hz;

param_plot.ctft_input_amp = out_ctft_fft_input.amp;

param_plot.ctft_input_phase_Deg = out_ctft_fft_input.phase_spect_deg;

param_plot.show_freq_input = show_freq_input;

param_plot.time_scale = time_scale; 

% Calling the function of the plot
make_plots(what_to_plot,param_plot,how_many);


%% Simulating using other Sampling rate

param_sampling_rate_conv.input_signal = input_signal;

param_sampling_rate_conv.time_input_signal  = t_input;

param_sampling_rate_conv.fs_input = fs_in;
         
param_sampling_rate_conv.total_signal_duration = ...
param.time_duration - param.start_time ;

param_sampling_rate_conv.target_Fs = target_Fs;

% Instantiating the object
src_obj = Sampling_Rate_Convresion(param_sampling_rate_conv) ;

out_src_obj = src_obj.downsample_multiple_fs(show_debug);

param_ctft.zero_padd = 'False';

% Allocating for storing results
ctft_per_fs_amp = zeros(length(target_Fs),out_src_obj.nb_samples_for_each_fs(1));

freq_vec_Hz_per_fs = ctft_per_fs_amp;

freq_discrete_per_fs = ctft_per_fs_amp;

reconstructed_signals = zeros(length(target_Fs),length(t_input));



% allocating for DTFT using freqz function
number_freq_points = 1024;
dtft_comp_per_fs_freqz = zeros(length(target_Fs),number_freq_points);

% the discrete freq will be the same for all tagrget Fs
freq_discrete_per_fs_freqz = ...
-pi:2*pi/number_freq_points:pi-2*pi/number_freq_points;


fprintf(' \n \n ****** Starting CTFT and DTFT per Fs ************ \n \n');


% this is for ideal reconstruction using sinc interpolation
% it is the same for all target Fs, so we only need to declare it
% once
param_sinc.t_analog = t_input;


% Performing CTFT,DTFT and sinc interpolation for each new Fs
for index = 1:length(target_Fs)

 nb_samples_per_fs = out_src_obj.nb_samples_for_each_fs(index);   
    
    % setting the new Fs to some new Fs
 dsp = dsp.change_param(target_Fs(index)); 
 
 fprintf('--> Operation nb %d: Fs = %d Hz \n',index,dsp.fs);
 
 % setting the number of samples
 param_ctft.nb_of_samples = nb_samples_per_fs;
 
 % Setting the sampled signal
  param_ctft.signal_sampeled = ...
  out_src_obj.new_signals(index,1:nb_samples_per_fs);

% Performing DTFT using freqz function
dtft_comp_per_fs_freqz(index,:) = ...
fftshift(freqz(param_ctft.signal_sampeled,1,number_freq_points,'whole'));


% Performing CTFT
out_ctft_fft = dsp.CTFT(param_ctft) ;

% Storing Amplitdue spectrum for each new Fs
ctft_per_fs_amp(index,1:nb_samples_per_fs) =  out_ctft_fft.amp;

% Storing freq vect for each new Fs
freq_vec_Hz_per_fs(index,1:nb_samples_per_fs) =  out_ctft_fft.freq_vec_Hz;

freq_discrete_per_fs(index,1:nb_samples_per_fs) = out_ctft_fft.freq_discrete_normalize;


% Performing ideal reconstruction using sinc interpolation

param_sinc.sinc_interpolation_version = 'matrix_vector';
    
param_sinc.t_sampeles = out_src_obj.new_timeaxis(index,1:nb_samples_per_fs)  ;
    
param_sinc.signal_sampeled = param_ctft.signal_sampeled;

reconstructed_signals(index,:) =  dsp.sinc_interpol(param_sinc) ;

end 


%--------------------- Plot Downsampled Samples ---------------------

param_plot.down_signals = out_src_obj.new_signals;

param_plot.target_Fs = target_Fs;

param_plot.new_timeaxis = out_src_obj.new_timeaxis;
param_plot.nb_samples_for_each_fs = out_src_obj.nb_samples_for_each_fs;

param_plot.show_sinc_interpol = 'False';

param_plot.what_to_plot = 'dowsample_plot';

% Calling the function to plot dowsampled samples per Fs
make_plot_for_sampling_rate_conv(param_plot);

%--------------------- Plot Spectrum ---------------------

param_plot.what_to_plot = 'ctft_plot_per_fs';

param_plot.freq_vec_Hz_per_fs = freq_vec_Hz_per_fs;

param_plot.freq_discrete_per_fs_freqz = freq_discrete_per_fs_freqz;


param_plot.downsampling_factor = out_src_obj.downsampling_factor;



param_plot.freq_discrete_per_fs = freq_discrete_per_fs;

param_plot.dtft_comp_per_fs_freqz = dtft_comp_per_fs_freqz;

param_plot.ctft_per_fs_amp = ctft_per_fs_amp;

param_plot.reconstructed_signals = reconstructed_signals;

% Calling the function to plot ctft per new Fs
make_plot_for_sampling_rate_conv(param_plot);

%--------------------- Plot Sinc Interpolation ---------------------

param_plot.what_to_plot = 'dowsample_plot';

param_plot.show_sinc_interpol = 'True';

make_plot_for_sampling_rate_conv(param_plot);

