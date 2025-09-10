

clc, close all,clear all


%% Signal Generation

% Hz sample rate
fs = 4e3; 

Ts = 1/fs;

% Hz sine frequency
f_sin= 500; 

% V sine amplitude for P= 1 W into 1 ohm.
A= sqrt(2); 

% number of time samples
Nb_samples = 1024; 

% time index
n = 0:Nb_samples-1; 

% 1 W sinewave + noise
signal = A*sin(2*pi*f_sin*n*Ts) + .1*randn(1,Nb_samples); 

fprintf('Time window = %.2f s',(Nb_samples-1)*Ts);

%% Applying pwelech

nfft = Nb_samples;


window = rectwin(nfft);

n_overlapp = 0;

% W/Hz power spectral density
[pxx,f]= pwelch(signal,window,n_overlapp,nfft,fs); 

PdB_Hz = 10*log10(pxx);

% this is the analytical results
PdB_bin = 10*log10(pxx*fs/nfft);

figure()
subplot(1,2,1)
plot(f,PdB_Hz)
grid on;
set(gca,'fontsize',14,'fontweight','bold');
title('PSD Using pwelsh','Interpreter','Latex');
xlabel('Frequency [Hz]','Interpreter','Latex');
ylabel('dBW/Hz','Interpreter','Latex');


subplot(1,2,2)
plot(f,PdB_bin)
grid on;
set(gca,'fontsize',14,'fontweight','bold');
title('PSD Analytical Value Approximation','Interpreter','Latex');
xlabel('Frequency [Hz]','Interpreter','Latex');
ylabel('dBW/bin','Interpreter','Latex');




