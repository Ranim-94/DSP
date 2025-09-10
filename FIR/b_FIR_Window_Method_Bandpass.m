



%% Window Based FIR Filter Design


clc, close all;

%Bandpass Kaiser Window Design

normalized_discrete_freq = [ pi/5, 2*pi/5, 3*pi/5, 7*pi/10]/pi;

Amplitude = [ 0 1 0 ];

Deviations_error = [ 0.01 0.05 0.01];

% Speccs for the Kaiser window
[fir_oder,Wn,beta,filtype] = ...
kaiserord(normalized_discrete_freq,Amplitude,Deviations_error);

% Computing FIR taps
fir_taps = fir1(fir_oder, Wn, filtype, kaiser(fir_oder+1,beta), 'noscale');

% Computing Frequ response of the FIR

nb_of_discrete_freq_points = 2048;

[fir_freq_response,discrete_freq] = freqz(fir_taps,1,nb_of_discrete_freq_points);

figure(1)
% plotting the FIR Amp Spectrum
subplot(1,2,1)
plot(discrete_freq/pi,20*log10(abs(fir_freq_response)));
title(['FIR Kaiser Window Bandpass Filter M = ',num2str(fir_oder),', $\beta$ = ',num2str(beta)],'Interpreter','latex')
axis([0 1 -80, 5])
grid on
xlabel('Normalized Frequency $\omega/\pi$','Interpreter','latex')
ylabel('Gain dB','Interpreter','latex')
set(gca,'fontsize',14,'fontweight','bold');


figure(1),
subplot(1,2,2)
stem(0:fir_oder,fir_taps);
title('FIR Kaiser Window Impulse Response','Interpreter','latex')
grid on,
xlim([0,fir_oder])
xlabel('Samples','Interpreter','latex')
set(gca,'fontsize',14,'fontweight','bold');


figure(2)
plot(discrete_freq/pi,abs(1-abs(fir_freq_response)));
title('Kaiser Window Passband Error','Interpreter','latex')
axis([.4 .6 0 .05])
grid on
xlabel('Normalized Frequency $\omega/\pi$','Interpreter','latex')
ylabel('Absolute Error in Linear Scale','Interpreter','latex')
set(gca,'fontsize',14,'fontweight','bold');

