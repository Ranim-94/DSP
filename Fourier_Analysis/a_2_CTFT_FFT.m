close all;
clc;


% This script is to compare fft and dft for loop
% on a baseband signal
% ------------------------------------------------------------------------

%compute the sampling rate in Hz
fs = 16;

%set signal duration (truncation) in seconds
duration = [16];

for i = 1:length(duration)

T0 = duration(i);    

%set sampling time, we sample every T seconds
Ts = 1/fs;


%compute number of samples
nb_of_point = T0/Ts;


%compute the time vector to sample the continuous function
t_samples = 0:Ts:Ts*(nb_of_point -1);

% computing t analytical for compairson
t_analytical = 0:(Ts/5):Ts*(nb_of_point -1);

%we work with the continuous signal f(t) = e(-at)u(t) in this example
%compute samples of the signal scaled by T, i.e fk
a  = 0.5;

f_analytical  = exp(-a*t_analytical);

sampled_signal  = exp(-a*t_samples);


%compute the "continuous" frequency vector
%our sampling rate is fs, so we can only see up to fs/2

w = linspace(0,2*pi*(fs/2),10*nb_of_point);

% f_analytical_hz = (linspace(0,(fs/2),10*nb_of_point))';

f_analytical_hz = w/(2*pi) ;

%compute theoretical magnitude spectrum for signals of form e^(-at)u(t)
absF_analytical = 1./sqrt((2*pi*f_analytical_hz).^2 + a^2);


%%
% computing CTFT using DFT
[freq_vector,dft_values,spectral_step] = dft_ctft(nb_of_point,sampled_signal,fs);





%%         Applying FFT

% don't forget to multiply by Ts because from sampling theory,
% if we sample a signal in time --> the specturm get replicated
% and multiplied by scaling factor 1/Ts --> so we multiply by Ts


% for zero padding and making a dense spectrum
length_fft = 2^nextpow2(length(sampled_signal));


dft_values_fft = Ts*abs(fft(sampled_signal,length_fft));

% Setting up frequency bins
spectral_step_fft = (2*pi)/length_fft;

wVec = ((0:length_fft-1)*spectral_step_fft)*fs  ;

% Transfroming from radian/s --> Hz
freq_vector_fft  = wVec/(2*pi) ;

%% plot comparison of theoretical F(w) to DFT, i.e. samples of F(w


figure(i);

% Plot the time domain signal
subplot(1,3,1),
plot(t_analytical,f_analytical,'r','linewidth',2);
hold on,
stem(t_samples,sampled_signal);
grid on;
set(gca,'fontsize',14,'fontweight','bold');
xlabel('Time (s)','Interpreter','latex');
title('$f(t) = e^{(-0.5 \, t)} \, u(t)$',...
'Interpreter','latex');
ylabel('$f(t)$','Interpreter','latex');


% newline command to break the lengend into multilines
legend({['Duration = ',num2str(T0),' s' newline '$F_s \, = \, $',num2str(fs)...
    ,' Hz']},'Interpreter','latex'),


% rounding for displaying into plots
spectral_step = round(spectral_step,2);

subplot(1,3,2),
stem(freq_vector,abs(dft_values),'b');
hold on;
plot(f_analytical_hz,absF_analytical,'r','linewidth',2);
xlim([0 fs/2]);
grid on;
set(gca,'fontsize',14,'fontweight','bold');
xlabel('Frequency (Hz)','Interpreter','latex');
ylabel('Amplitude Spectrum','Interpreter','latex');
title(['Sepctral Step $\Omega_0 \, = \, $',...
    num2str(spectral_step)],'Interpreter','latex');
legend({'DFT for loop','Analytical Form'},'Interpreter','latex');


subplot(1,3,3),
stem(freq_vector_fft,abs(dft_values_fft),'b');
hold on;
plot(f_analytical_hz,absF_analytical,'r','linewidth',2);
xlim([0 fs/2]);
grid on;
set(gca,'fontsize',14,'fontweight','bold');
xlabel('Frequency (Hz)','Interpreter','latex');
ylabel('Amplitude Spectrum','Interpreter','latex');
title(['Sepctral Step $\Omega_0 \, = \, $',...
    num2str(spectral_step)],'Interpreter','latex');
legend({'FFT','Analytical Form'},'Interpreter','latex');

end