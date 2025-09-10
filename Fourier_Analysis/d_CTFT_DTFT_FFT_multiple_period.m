






close all;
clc;


% This script is to compare fft and dft for loop
% on a baseband signal
% ------------------------------------------------------------------------

%% Setting parameters

% in Hz
signal_bandwidth = 8;

%compute the sampling rate in Hz
fs = signal_bandwidth/2;

%set signal duration (truncation) in seconds
time_duration = 16;

% time_duration = time_duration ;    

%set sampling time, we sample every T seconds
Ts = 1/fs;

%compute number of samples
nb_of_point = time_duration/Ts;

% for zero padding and making a dense spectrum
length_fft = 2^nextpow2(nb_of_point);

% for generating frequency bins in Hz
freq_step = fs/length_fft;


%% Setting time domain signals: analytical , sampled and discrete

%compute the time vector to sample the continuous function
t_samples = 0:Ts:Ts*(nb_of_point - 1);

% computing t analytical for compairson
t_analytical = 0:(Ts/5):Ts*(nb_of_point - 1);

%we work with the continuous signal f(t) = e(-at)u(t) in this example

a  = 0.5;
signal_analytical  = exp(-a*t_analytical);

signal_sampled  = exp(-a*t_samples);

% discrete time vector
n_vec = 0:nb_of_point-1 ;

discrete_time_signal  = exp(-a.*n_vec);

%% 
%compute the "continuous" frequency vector
%our sampling rate is fs, so we can only see up to fs/2

f_analytical_hz = linspace(-signal_bandwidth,signal_bandwidth - freq_step,10*length_fft);

% discrete frequency in radian
w_analytical_discrete = (f_analytical_hz.*(2*pi))./fs ;

%compute theoretical magnitude spectrum for signals of form e^(-at)u(t)
ctft_analytical = 1./sqrt((2*pi*f_analytical_hz).^2 + a^2);

% used in DTFT analytical expression
alpha = exp(-a);

dtft_analytical = ...
1./(1 - alpha *exp(-1j*w_analytical_discrete))  ;

dtft_analytical_2 = ctft_analytical./Ts ;

%%         Applying FFT to compute CTFT and DTFT

% don't forget to multiply by Ts because from sampling theory,
% if we sample a signal in time --> the specturm get replicated
% and multiplied by scaling factor 1/Ts --> so we multiply by Ts


ctft_fft = Ts*abs(fft(signal_sampled,length_fft));



dtft_fft = abs(fft(discrete_time_signal,length_fft));

% Making the amplitude spectrum symmetrical with y axis
ctft_fft = fftshift(ctft_fft);

dtft_fft = fftshift(dtft_fft);

% Setting up frequency bins
spectral_step_fft = (2*pi)/length_fft;

% wVec = ((0:length_fft-1)*spectral_step_fft)*fs  ;

% Transfroming from radian/s --> Hz
% freq_vector_fft  = wVec/(2*pi) ;

replication_nb = 2;

freq_vector_fft =  ...
linspace(- signal_bandwidth , signal_bandwidth - freq_step,length_fft) ;

% discrete freq [-pi,pi]
discrete_freq_vector_fft =  (freq_vector_fft).*(2*pi)./fs;

%% plot comparison of theoretical F(w) to DFT, i.e. samples of F(w


figure(1);

% Plot the time domain signal
subplot(1,3,1),
plot(t_analytical,signal_analytical,'r','linewidth',2);
hold on,
stem(t_samples,signal_sampled);
grid on;
set(gca,'fontsize',14,'fontweight','bold');
xlabel('Time (s)','Interpreter','latex');
title('$f(t) = e^{(-0.5 \, t)} \, u(t)$',...
'Interpreter','latex');
ylabel('$f(t)$','Interpreter','latex');


% newline command to break the lengend into multilines
legend({['Duration = ',num2str(time_duration),' s' newline '$T_s \, = \, $',num2str(10^3*Ts)...
    ,' ms']},'Interpreter','latex'),


% rounding for displaying into plots

spectral_step_fft = round(spectral_step_fft,2) ;


% CTFT Plot: FFT and Closed Form
subplot(1,3,2),
plot(freq_vector_fft,ctft_fft,'b');
hold on;
plot(f_analytical_hz,ctft_analytical,'r','linewidth',2);
% xlim([0 fs/2]);
grid on;
set(gca,'fontsize',14,'fontweight','bold');
xlabel('Frequency (Hz)','Interpreter','latex');
ylabel('$ | X(f_c)|$','Interpreter','latex');
title('$ X(f_c) \, = \, \displaystyle\frac{1}{j \, 2 \pi f_c \, + \, 0.5}$', ...
      'Interpreter','latex');
legend({'FFT','Analytical Form'},'Interpreter','latex');

% DTFT plot: FFT and Closed Form
subplot(1,3,3),
plot(discrete_freq_vector_fft,dtft_fft,'b');
hold on;
% plot(w_analytical_discrete,dtft_analytical_2,'r','linewidth',2);
plot(w_analytical_discrete,abs(dtft_analytical),'r','linewidth',2);
grid on;
set(gca,'fontsize',14,'fontweight','bold');
xlabel('$\omega_d$ (rad)','Interpreter','latex');
ylabel('$  |X(\omega_d)| $','Interpreter','latex');
 title('$ X(\omega_d) \, = \, \displaystyle\frac{1}{1 - \, \alpha \, \exp(\, -j \, \omega_d \,) \, + \, 0.5}$', ...
       'Interpreter','latex');
legend({'FFT','Analytical Form'},'Interpreter','latex');

