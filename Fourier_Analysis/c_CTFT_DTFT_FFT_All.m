




close all;
clc;


% This script is to compare fft and dft for loop
% on a baseband signal
% ------------------------------------------------------------------------

%% Setting parameters

% in Hz
in.signal_bandwidth = 8;

% 16
in.f_Nyquitst = 2*in.signal_bandwidth;

% it will be used in the DTFT analytical form
% for comparison purpose = 32 Hz 
in.optimum_sampling_rate = 2*in.f_Nyquitst;

in.optimum_sampling_period = 1/in.optimum_sampling_rate;

sampling_factor = [2,1/2,1/3];

simulation_nb = length(sampling_factor);

%set signal duration (truncation) in seconds
in.time_duration = 16;

%variable used for indexing DTFT and CTFT plots
plot_index = 1;


%% Generating analytical curves: waveform and Sepctrum (DTFT and CTFT)

out = generate_analytical_sol(in);


%%
for i = 1:simulation_nb 

%compute the sampling rate in Hz
in.fs = sampling_factor(i)*in.f_Nyquitst;    

% To track initial sampling rate
% because I use another sampling
% to be reporgram it later
fs_initial = in.fs ;

Ts = 1/in.fs ;

% Generate Sampled and discrete time signals
% Compute CTFT and DTFT using FFT
out_numerical = gnenerate_numerical_signals(in);  


%% Waveform Reconstruction

% ************** Sinc Interpolator *******************

% Invokingn sinc reconstruction 
f_sinc = ideal_reconstruction(out.t_analog,...
out_numerical.t_samples,out_numerical.signal_sampled,in.fs);


% ************* Papoulis ***********************



%% Plotting Results


% *************** Waveform: Analog, Sampeled and Reconstructed *******

% Plot the time domain signal
figure(1),
subplot(simulation_nb,2,plot_index),
plot(out.t_analog,out.signal_analytical,'r','linewidth',2);
hold on,
stem(out_numerical.t_samples,out_numerical.signal_sampled);
grid on;
set(gca,'fontsize',14,'fontweight','bold');
xlabel('Time (s)','Interpreter','latex');
title('$f(t) = e^{(-0.5 \, t)} \, u(t)$',...
'Interpreter','latex');
ylabel('$f(t)$','Interpreter','latex');
% newline command to break the lengend into multilines
legend({['Duration = ',num2str(in.time_duration),' s'...
    newline '$B \, = \, $',num2str(in.signal_bandwidth),' Hz'...
    newline '$T_s \, = \, $',num2str(10^3*Ts)...
  ,' ms' newline '$F_s \, = \, $ ',num2str(in.fs),' Hz']},'Interpreter','latex'),


% Plot reconstructed signal: sinc interpolation
figure(1),
subplot(simulation_nb,2,plot_index +1),
plot(out.t_analog,out.signal_analytical,'r','linewidth',2);
hold on,
plot(out.t_analog,f_sinc,'linewidth',2);
% hold on,
% plot(out.t_analog,signal_papoulis_reconstructed);
grid on;
set(gca,'fontsize',14,'fontweight','bold');
xlabel('Time (s)','Interpreter','latex');
title('$f(t) = e^{(-0.5 \, t)} \, u(t)$',...
'Interpreter','latex');
ylim([0 max(out.signal_analytical)]);
legend({'Analytical Form','Sinc Interpolation'},'Interpreter','latex')
ylabel('$f(t)$','Interpreter','latex');



% ******************* Spectrum: CTFT and DTFT **************************

% CTFT Plot: FFT and Closed Form
figure(2),
subplot(simulation_nb,2,plot_index),
plot(out_numerical.freq_vector_fft,out_numerical.ctft_fft,'b');
xlim([-in.signal_bandwidth in.signal_bandwidth]);
hold on;
plot(out.f_analytical_hz,out.ctft_analytical,'r','linewidth',2);
grid on;
set(gca,'fontsize',14,'fontweight','bold');
xlabel('Frequency (Hz)','Interpreter','latex');
ylabel('$ | X(f_c)|$','Interpreter','latex');
title(['$ X(f_c) \, = \, \displaystyle\frac{1}{j \, 2 \pi f_c \, + \, 0.5}$', ...
      ' and $F_s = $ ',num2str(in.fs),' Hz'],'Interpreter','latex');
legend({'FFT' , 'Analytical Form'},'Interpreter','latex');

% DTFT plot: FFT and Closed Form


subplot(simulation_nb,2,plot_index+1),
plot(out_numerical.discrete_freq_vector_fft,out_numerical.dtft_fft,'b');
xlim([out_numerical.range1 out_numerical.range2]);
hold on;
% plot(w_analytical_discrete,dtft_analytical_2,'r','linewidth',2);
plot(out.w_analytical_discrete,abs(out.dtft_analytical),'r','linewidth',2);
grid on;
set(gca,'fontsize',14,'fontweight','bold');
xlabel('$\omega_d$ (rad)','Interpreter','latex');
ylabel('$  |X(\omega_d)| $','Interpreter','latex');
 title(['$ X(\omega_d) \, = \, \displaystyle\frac{1}{1 - \, \alpha \, \exp(\, -j \, \omega_d \,) \, + \, 0.5}$', ...
       ' and $F_s = $ ',num2str(in.fs),' Hz'],'Interpreter','latex');

 legend({'FFT' , 'Analytical Form'},'Interpreter','latex');


plot_index = plot_index + 2;

end