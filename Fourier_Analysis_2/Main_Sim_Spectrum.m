






clc, clear all, close all;




%================ Selection list: what demo I want to run

demo_list = ["fft_demo",... % 1
            "ifft_demo",... % 2
            "multiple_period",... % 3
            "bin_leakage",... % 4
            "fft_dft"];  % 5

demo_choice = demo_list(1);

% ============================================================

%===============  List of test analytical signal 
choice_sig_list = {'sin','sum_of_sinusoids_2',... % 1,2
                   'sum_of_sinusoids_3','sinc','sinc_square',... % 3,4,5
                   'periodic_rect'}; % 6 

% choose what type of signal
param_sim.choice_signal = choice_sig_list(5);

show_signal_in_time_array = ["show_sin","show_sinc"];

param_sim.show_signal_in_time = show_signal_in_time_array(2);

param_sim.bandwidth_Hz = 30; % Signal Bandwidth in Hz

param_sim.signal_amp = 1; % Signal Amplitude 

% ============================================================

%====================== Sampling Parameters 
param_sim.fs = 1000 ;

zero_padd_choice = ["True","False"];

param_sim.zero_padd = zero_padd_choice(1) ;


% delay_option_generation_choice = ["defined_delays","random_delays"] ;
% 
% % choose from above: how to generate delays: by choosing values or randomly
% param_sim.delay_generation_option = delay_option_generation_choice(2); 
 
% multiplicative factor: if in ms --> 1e3
% if in micro s --> 1e6
param_sim.time_scale = 1;

% put ms , micros
param_sim.time_scale_option_input_signal = 's';


% start of the signal in s
param_sim.start_time = -50;

% end time of the signal
param_sim.end_time = 50;

param_sim.time_window_width = param_sim.end_time - param_sim.start_time;


% show time width of a certain signal: used in plotting options 
% this factor is dimensionless
param_sim.show_time = 50;


param_sim.show_debug = 1;



% choose 1 if you need to display, 0 otherwise
param_sim.show_log = 1;


%% ------------- Start Simulation ------------------------ 


out_sim = select_simulation(param_sim,demo_choice);




