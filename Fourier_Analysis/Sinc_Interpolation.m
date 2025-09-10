

close all;
clc;


%compute the sampling rate
fs = 16;

%set signal length/truncation in seconds
duration = 16 ;    

%set sampling time, we sample every T seconds
Ts = 1/fs;

kernel_order =2;

new_sampling_period  = kernel_order*Ts ;

%compute number of samples
nb_of_point = duration/Ts;

%compute number of samples
nb_of_point_new = duration/new_sampling_period;


Fs_new = 1/new_sampling_period;

%compute Omega0 (the rth sample of F(Omega) is at frequency r*Omega0)
% spectral_step = (2*pi)/nb_of_point;

%compute the time vector to sample the continuous function
t_sampled = 0:Ts:Ts*(nb_of_point);

%compute the time vector of papoulis for deirivative case
t_sampled_new = 0:new_sampling_period:new_sampling_period*(nb_of_point_new);

% computing t analytical for compairson
t_analog = 0:(Ts/5):Ts*(nb_of_point);

%we work with the continuous signal f(t) = e(-at)u(t) in this example
%compute samples of the signal scaled by T, i.e fk
a  = 0.5;

signal_analytical  = exp(-a*t_analog);

sampled_signal  = exp(-a*t_sampled);

sampled_signal_new  = exp(-a*t_sampled_new );

signal_analytical_derivative  = -a * exp(-a*t_sampled_new );




%% Wavform Reconstruction

% trying to do a sinc interpolation

% Invokingn sinc reconstruction 
f_sinc = ideal_reconstruction(t_analog,...
t_sampled_new,sampled_signal_new,Fs_new);

% Invoking papoullis reconstruction
signal_papoulis_reconstructed = ...
papoulis_derivative_interpolation_oder_2(t_analog,...
t_sampled_new,sampled_signal_new ,signal_analytical_derivative,...
8,fs,kernel_order);


%plot comparison of theoretical F(w) to DFT, i.e. samples of F(w)

figure(1);

% Plot the time domain signal
subplot(2,2,1),
plot(t_analog,signal_analytical,'r','linewidth',2);
hold on,
stem(t_sampled,sampled_signal);
grid on;
set(gca,'fontsize',14,'fontweight','bold');
xlabel('Time (s)','Interpreter','latex');
title('$f(t) = e^{(-0.5 \, t)} \, u(t)$',...
'Interpreter','latex');
ylabel('$f(t)$','Interpreter','latex');
% legend({'Analytical Signal','Sampled Signal'},'Interpreter','latex')

% newline command to break the lengend into multilines
legend({['Duration = ',num2str(duration),' s' newline '$F_s \, = \, $',num2str(fs)...
    ,' Hz']},'Interpreter','latex'),

% Plot the time domain signal
subplot(2,2,2),
plot(t_analog,signal_analytical,'r','linewidth',2);
hold on,
stem(t_sampled_new,sampled_signal_new);
grid on;
set(gca,'fontsize',14,'fontweight','bold');
xlabel('Time (s)','Interpreter','latex');
ylabel('$f(t)$','Interpreter','latex');
title('Slower Sampled Signal','Interpreter','latex');
% legend({'Analytical Signal','Sampled Signal'},'Interpreter','latex')

% newline command to break the lengend into multilines
legend({['Duration = ',num2str(duration),' s' newline '$F_s \, = \, $',num2str(Fs_new)...
    ,' Hz']},'Interpreter','latex'),




subplot(2,2,3),
plot(t_analog,signal_analytical,'r','linewidth',2);
hold on,
plot(t_analog,f_sinc);
% hold on,
% stem(t_analytical_papoulis,f_papoulis);
grid on;
set(gca,'fontsize',14,'fontweight','bold');
xlabel('Time (s)','Interpreter','latex');
title('$f(t) = e^{(-0.5 \, t)} \, u(t)$',...
'Interpreter','latex');
ylim([0 max(signal_analytical)]);
legend({'Analytical Form','Sinc Interpolation'},'Interpreter','latex')
ylabel('$f(t)$','Interpreter','latex');

% plotting papoulis reconstruction 
subplot(2,2,4),
plot(t_analog,signal_analytical,'r','linewidth',2);
hold on,
plot(t_analog,signal_papoulis_reconstructed);
% hold on,
% stem(t_analytical_papoulis,f_papoulis);
grid on;
set(gca,'fontsize',14,'fontweight','bold');
xlabel('Time (s)','Interpreter','latex');
title('Reconstruction using Papoulis','Interpreter','latex');
ylim([0 max(signal_analytical)]);
legend({'Analytical Form','Papoulis Interpolation'},'Interpreter','latex')
ylabel('$f(t)$','Interpreter','latex');


