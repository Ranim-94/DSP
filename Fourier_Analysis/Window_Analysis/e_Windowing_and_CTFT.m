

%% Choose approximation parameters
%
% x(t) is not strictly bandlimited, and since we are taking samples of an
% analytic expression, we can't lowpass filter to prevent aliasing. The
% spectrum rolls off as $1/\omega$ for \omega >> 12 so we'll assume an
% effective bandwidth of 300 rads/sec and choose a sampling interval of
% T=0.01 sec (sampling frequency of 200\pi rads/s).
% 
% The number of samples determines the resolution of details in the
% spectrum.  The mainlobe width of the rectangular window is 4\pi/N rads
% or 4\pi/(NT) rads/s.  To obtain resolution of 2\pi/5 rads/s we
% require NT > 10 or N > 1000. To obtain resolution of 2\pi/25 we require
% NT > 50 or N > 5000.  
%
% The DFT length M determines the frequency spacing. To obtain \pi/40
% rads/s implies \piT/40 rads, so spacing 2\pi/M = \piT/40 implies
% that M > 8000.

%% True FT
%
% Use FT properties and tables to get exact FT of signal.

clc, close all;

% in seconds
sampling_period = 0.01 ; 

sampling_frequency = 1/sampling_period ;

%Continous Time domian signal: containing 10^4 samples

time = (0:9999)*sampling_period;

continous_time_signal = exp(-time/10).*(cos(10*time) + cos(12*time));

% Analytical Fourier Transform
omega_tru = -20:.001:20;
j = sqrt(-1);

X_tru = (0.1 + j*omega_tru)./((0.1+j*omega_tru).^2 + 100) + ...
(0.1 + j*omega_tru)./((0.1+j*omega_tru).^2 + 144);

X_tru = abs(X_tru);

% Plotting the time domain signal with its Fourier Transform
% for visualization

figure(1)
subplot(1,2,1),
% Time domain
plot(time,continous_time_signal);
title('$x(t) \, = \,  e^{-0.1 \,t} \, \left[\, cos \left( \, 10 \, t \, \right) \, + \, cos \left( \, 12 \, t \, \right)  \,\right] \, u(t)$',...
'Interpreter','latex'),grid on,
xlabel('$t$ (s)','Interpreter','latex')
ylabel('Amplitude','Interpreter','latex')
axis([0 30 -2 3])
set(gca,'fontsize',14,'fontweight','bold');


subplot(1,2,2)
plot(omega_tru,X_tru);
title('$X(\omega_c) \, = \,\displaystyle\frac{\, 0.1 \, + \, j \, \omega_c}{ \left( \, 0.1 \, + \, j \, \omega_c  \,  \right)^2    \, + \, 10^2} \, + \, \displaystyle\frac{0.1 \,+ \, j \, \omega_c}{ \left( \, 0.1 \, + \, j \, \omega_c  \,  \right)^2    \, + \, 12^2}  $',...
'Interpreter','latex'),grid on,
xlabel('$\omega_c$ (rads/s)','Interpreter','latex')
ylabel('Amplitude','Interpreter','latex')
set(gca,'fontsize',14,'fontweight','bold');




%% Here we do spectral analysis for different resolution and
% different window
%
clc, close all;

% Parameters to be set
window_length = 5000;

fft_length = 10^4 ;

window_rect = (rectwin(window_length))';

% window_ham = (hamming(window_length))';

% Choose what window you want to use
x1 = continous_time_signal(1:window_length).*window_rect;



% zero pad to get desired frequency sampling
X1 =  abs(fft(x1,fft_length))/sampling_frequency;

spectral_step = (2*pi)/fft_length ;

% frequency bins
frequency_bins = (0:fft_length -1)*spectral_step*sampling_frequency ;


figure(2)
plot(omega_tru,X_tru);
hold on,
stem(frequency_bins,X1,'r');grid on,
axis([0,20,0,6])
xlabel('$\omega_c$ (rads/s)','Interpreter','latex')
ylabel('Amplitude','Interpreter','latex')
title(['Resolution = $\displaystyle\frac{2 \pi}{5}$ ; ','Hamming Window length = ',...
num2str(window_length),' ; DFT length = ',num2str(fft_length)],...
'Interpreter','latex')
legend({'Analytical Form','Numerical using FFT'},'Interpreter','latex');
set(gca,'fontsize',14,'fontweight','bold');





%% Plot Continous time signal and the hamming window

clc, close all ;

figure(4)
subplot(2,1,1)
% Continious Time domain
plot(time(1:window_length),continous_time_signal(1:window_length));
title('$x(t) \, = \,  e^{-0.1 \,t} \, \left[\, cos \left( \, 10 \, t \, \right) \, + \, cos \left( \, 12 \, t \, \right)  \,\right] \, u(t)$',...
'Interpreter','latex'),grid on,
xlabel('$t$ (s)','Interpreter','latex')
ylabel('Amplitude','Interpreter','latex')
axis([0 20 -2 3])
set(gca,'fontsize',14,'fontweight','bold');


subplot(2,1,2),
plot((0:window_length -1).*sampling_period,hamming(window_length));
title(['Hamming Window ; ',... 
    'Length = ',num2str(window_length),...
    ' ; Sampling Period = ', num2str(sampling_period),' s'],...
'Interpreter','latex')
xlabel('$t$ (s)','Interpreter','latex')
ylabel('Amplitude','Interpreter','latex'),grid on,
set(gca,'fontsize',14,'fontweight','bold');



