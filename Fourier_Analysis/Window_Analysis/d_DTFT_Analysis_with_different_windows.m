%% Example Applying Windows

% Illustrate different window properties using a signal with two closely
% spaced equal amplitude components and a well separated weak component


clc, close all ;

% Generating discrete time vectors
% make column, since wr, wh, etc are columns
discrete_time_vector = (0:99)';

nb_discrete_time_samples = length(discrete_time_vector) ;

% Equally amplitude signals, very close to each other
discrete_signal_1 = cos(0.1*pi*discrete_time_vector);
discrete_signal_2 = cos(0.125*pi*discrete_time_vector + pi/3);

% This signal has a very weak amplitude
discrete_signal_3 = 0.01*cos(0.4*pi*discrete_time_vector - 3*pi/5);

% the total signal
discrete_signal =  discrete_signal_1 +  discrete_signal_2 + discrete_signal_3 ;




% Preparing different windows type

window_rect = rectwin(nb_discrete_time_samples);

window_ham = hamming(nb_discrete_time_samples);

sidelob_attenuation_db_1 = 30 ;

sidelob_attenuation_db_2 = 70 ;

% Chebyshev 30 dB sidelobe atten
window_chebychev_1 = chebwin(nb_discrete_time_samples,sidelob_attenuation_db_1); 

% Chebyshev 70 dB sidelobe atten
window_chebychev_2 = chebwin(nb_discrete_time_samples,sidelob_attenuation_db_2); 

zero_padding = 4^nextpow2(nb_discrete_time_samples);

% --------- Computing DTFT using fft ----------------------

% .* does element by element multiplication
Xr = fftshift(fft(window_rect.*discrete_signal,zero_padding));  

Xh = fftshift(fft(window_ham.*discrete_signal,zero_padding));

Xch1 = fftshift(fft(window_chebychev_1.*discrete_signal,zero_padding)); 

Xch2 = fftshift(fft(window_chebychev_2.*discrete_signal,zero_padding)) ;

% Computing DTFT for each component alone to 
% plot them as a subplot, to show the location
% of each frequency component

component_1 = fftshift(fft(discrete_signal_1,zero_padding));

component_2 = fftshift(fft(discrete_signal_2,zero_padding));

component_3 = fftshift(fft(discrete_signal_3,zero_padding));


% om = [0:2047]*pi/2048; % pos freq axis in rads

% Generating discrete frequency bins
discrete_freq_bins = linspace(-pi,pi,zero_padding) ;

% ----------------- Plotting the results ----------------

% specify frequency range from 0 --> pi for a better visualization


% we plot each component alone 
figure(1)
subplot(1,3,1)
plot(discrete_freq_bins,20*log10(abs(component_1)));
hold on ,
plot(discrete_freq_bins,20*log10(abs(component_2)));
hold on ,
plot(discrete_freq_bins,20*log10(abs(component_3)));
title('Signal Frequency Components','Interpreter','latex'),grid on,
xlabel('$\omega_d$ (rads)','Interpreter','latex')
ylabel('Amplitude in dB Scale','Interpreter','latex')
axis([0 pi -50 50])
set(gca,'fontsize',14,'fontweight','bold');
legend({'cos$ \,(0.1 \, \pi \, n)$','cos$ \,(0.125 \, \pi \, n + \frac{\pi}{3})$',...
'0.01 cos$ \,(0.4 \, \pi \, n - \frac{3 \pi}{5})$'},'Interpreter','latex'),



figure(1)
subplot(1,3,2)
plot(discrete_freq_bins,20*log10(abs(Xr)));
title('Rectangular','Interpreter','latex'),grid on,
xlabel('$\omega_d$ (rads)','Interpreter','latex')
ylabel('Amplitude in dB Scale','Interpreter','latex')
axis([0 pi -50 50])
set(gca,'fontsize',14,'fontweight','bold');


subplot(1,3,3)
plot(discrete_freq_bins,20*log10(abs(Xh)));
title('Hamming','Interpreter','latex')
axis([0 pi -50 50]),grid on
ylabel('Amplitude in dB Scale','Interpreter','latex')
xlabel('$\omega_d$ (rads)','Interpreter','latex')
set(gca,'fontsize',14,'fontweight','bold');


figure(2)
subplot(1,3,1)
plot(discrete_freq_bins,20*log10(abs(component_1)));
hold on ,
plot(discrete_freq_bins,20*log10(abs(component_2)));
hold on ,
plot(discrete_freq_bins,20*log10(abs(component_3)));
title('Signal Frequency Components','Interpreter','latex'),grid on,
xlabel('$\omega_d$ (rads)','Interpreter','latex')
ylabel('Amplitude in dB Scale','Interpreter','latex')
axis([0 pi -50 50])
set(gca,'fontsize',14,'fontweight','bold');
legend({'cos$ \,(0.1 \, \pi \, n)$','cos$ \,(0.125 \, \pi \, n + \frac{\pi}{3})$',...
'0.01 cos$ \,(0.4 \, \pi \, n - \frac{3 \pi}{5})$'},'Interpreter','latex'),

figure(2)
subplot(1,3,2)
plot(discrete_freq_bins,20*log10(abs(Xch1)));
title('Chebyshev -30 dB','Interpreter','latex'),grid on
xlabel('$\omega_d$ (rads)','Interpreter','latex')
ylabel('Amplitude in dB Scale','Interpreter','latex')
axis([0 pi min(20*log10(abs(Xch1))) max(20*log10(abs(Xch1)))])
set(gca,'fontsize',14,'fontweight','bold');

subplot(1,3,3)
plot(discrete_freq_bins,20*log10(abs(Xch2)));
title('Chebyshev -70 dB','Interpreter','latex'),grid on
axis([0 pi min(20*log10(abs(Xch2))) max(20*log10(abs(Xch2)))])
xlabel('$\omega_d$ (rads)','Interpreter','latex')
ylabel('Amplitude in dB Scale','Interpreter','latex')
set(gca,'fontsize',14,'fontweight','bold');

