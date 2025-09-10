



clc, clear all, close all;

% rng('default');


%================ Selection list: what demo I want to run

demo_list = ["IQ",... % 1
            ];  % 4

demo_choice = demo_list(1);

% ============================================================

%===============  List of message signal in case we do Analog modulation
%  (DSB,AM,FM,....)
choice_sig_list = {'sin','sum_of_sinusoids_2',... % 1,2
                   'sum_of_sinusoids_3','sinc','sinc_square'};  % 3,4,5

% choose what type of signal
param_sim.choice_signal = choice_sig_list(5);

show_signal_in_time_array = ["show_sin","show_sinc"];

param_sim.show_signal_in_time = show_signal_in_time_array(2);

scale_freq_list = [1,1e3,1e6]; % Hz,KHz,MHz,...

param_sim.scale_freq = scale_freq_list(1);

param_sim.bandwidth_Hz = 10; % Signal Bandwidth in Hz

param_sim.signal_amp = 1; % Signal Amplitude 

% ========= Choose Modulation type ========================
modulation_type = {'DSB_SC','SSB_U','SSB_L','FM'}; % 1,2,3,4

param_sim.modulation_type  = modulation_type(1);

param_sim.f_carrier = 200 ; % Carrier frequency in Hz

param_sim.f_conversion = 200 ; % frequency for doing up or down conversion

% ============================================================

%====================== Sampling Parameters ===============
param_sim.fs = 10*param_sim.f_carrier ;

zero_padd_choice = ["True","False"];

param_sim.zero_padd = zero_padd_choice(2) ;


% delay_option_generation_choice = ["defined_delays","random_delays"] ;
% 
% % choose from above: how to generate delays: by choosing values or randomly
% param_sim.delay_generation_option = delay_option_generation_choice(2); 
 
% multiplicative factor: if in ms --> 1e3
% if in micro s --> 1e6
param_sim.time_scale = 1e3;


% start of the signal in s
param_sim.start_time = -2;

% end time of the signal
param_sim.end_time = 2;

param_sim.time_window_width = param_sim.end_time - param_sim.start_time;


% show time width of a certain signal: used in plotting options 
% this factor is dimensionless
param_sim.show_time = 50;


param_sim.show_debug = 1;



% choose 1 if you need to display, 0 otherwise
param_sim.show_log = 1;


% ------------- Start Simulation ------------------------ 


out_sim = select_simulation(param_sim,demo_choice);




