






close all;
clc;


%% Setting parameters

% in Hz
in.signal_bandwidth = 8;

% 16
in.f_Nyquitst = 2*in.signal_bandwidth;

% it will be used in the DTFT analytical form
% for comparison purpose  = 32
in.optimum_sampling_rate = 2*in.f_Nyquitst;

in.optimum_sampling_period = 1/in.optimum_sampling_rate;


%set signal duration (truncation) in seconds
in.time_duration = 16;


%% Generating analytical curves: waveform and Sepctrum (DTFT and CTFT)

out = generate_analytical_sol(in);


%%
%compute the sampling rate in Hz
in.fs = in.f_Nyquitst/2;    


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

t_analog = out.t_analog; 

kernel_order = 2;

% new_sampling_period  = kernel_order*Ts ;

% in.fs = 1/new_sampling_period;

out_papoulis = gnenerate_numerical_signals(in);

% Invoking papoullis reconstruction
signal_papoulis_reconstructed = ...
papoulis_derivative_interpolation_oder_2(t_analog,...
out_papoulis.t_samples,...
out_papoulis.signal_sampled,...
out_papoulis.signal_analytical_derivative,8,...
in.f_Nyquitst,kernel_order);

%% Plotting Results


% *************** Waveform: Analog, Sampeled and Reconstructed *******

% Plot the time domain signal
figure(1),
% subplot(1,3,1),
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
figure(2),
subplot(1,2,1),
plot(out.t_analog,out.signal_analytical,'r','linewidth',2);
hold on,
plot(out.t_analog,f_sinc,'linewidth',2);
grid on;
set(gca,'fontsize',14,'fontweight','bold');
xlabel('Time (s)','Interpreter','latex');
title('$f(t) = e^{(-0.5 \, t)} \, u(t)$',...
'Interpreter','latex');
ylim([0 max(out.signal_analytical)]);
legend({'Analytical Form','Sinc Interpolation'},'Interpreter','latex')
ylabel('$f(t)$','Interpreter','latex');



% Plot reconstructed signal: sinc interpolation
figure(2),
subplot(1,2,2),
plot(out.t_analog,out.signal_analytical,'r','linewidth',2);
hold on,
plot(out.t_analog,signal_papoulis_reconstructed,'linewidth',2);
grid on;
set(gca,'fontsize',14,'fontweight','bold');
xlabel('Time (s)','Interpreter','latex');
title('$f(t) = e^{(-0.5 \, t)} \, u(t)$',...
'Interpreter','latex');
ylim([0 max(out.signal_analytical)]);
legend({'Analytical Form','Papoulis'},'Interpreter','latex')
ylabel('$f(t)$','Interpreter','latex');

