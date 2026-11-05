

clc, close all;


% ===============  List of test analytical signal ===============
choice_sig_list = ["sin","sum_of_sinusoids_2","sum_of_sinusoids_3"... % 1,2,3
                   "sinc","sinc_square",... % 4,5
                   "periodic_rect"]; % 6 

% ======== Specifying Signal Parameters ========

param_sim.choice_signal = choice_sig_list(4); % choose signal name from list above

param_sim.bandwidth_Hz = 30; % Signal Bandwidth in Hz

param_sim.signal_amp = 1; % Signal Amplitude

% General Simulation Parameters

% how many samples s
param_sim.nb_samples = 800;

% Sampling Frequency in Hz
param_sim.fs = 5*param_sim.bandwidth_Hz ;
% I simulate Fs in function of B, as Fs = m*B where m is some integer and
% m > 2 <-> m in [3,4,5,...]

zero_padd_choice = ["True","False"];

param_sim.zero_padd = zero_padd_choice(1) ;


% delay_option_generation_choice = ["defined_delays","random_delays"] ;
% 
% % choose from above: how to generate delays: by choosing values or randomly
% param_sim.delay_generation_option = delay_option_generation_choice(2); 
 
% multiplicative factor to scale time axis: 
% if in ms -> 1e3
% if in micro s -> 1e6
% if in s -> 1
param_sim.time_scale = 1e3;


% choose 1 if you need to display, 0 otherwise

param_sim.show_debug = 1;




%% ------------- Start Simulation ------------------------ 

out_sim = Sim_Spectrum(param_sim);




