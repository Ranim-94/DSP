

% source: https://fr.mathworks.com/help/signal/ug/downsampling-aliasing.html


clc, clear all, close all;

% the bandwdith of the signal according to Matlab doc =
% 0.75 pi *2 =  1.5 pi
discrete_frequency = [0 0.2500 0.5000 0.7500 1.0000];

amplitude_response = [1.00 0.6667 0.3333 0 0];

nf = 512;

discrete_time_signal = fir2(nf-1,discrete_frequency,amplitude_response);

% Hx = fftshift(freqz(discrete_time_signal,1,nf,'whole'));

Hx = fftshift(fft(discrete_time_signal,nf));

omega = -pi:2*pi/nf:pi-2*pi/nf;

figure()

subplot(2,1,1)
plot(omega/pi,abs(Hx))
grid on,set(gca,'fontsize',14,'fontweight','bold');
xlabel('$\times \pi$ rad/sample','Interpreter','Latex')
ylabel('Magnitude','Interpreter','Latex')
title('Original Signal: DTFT Spectrum','Interpreter','Latex');


y = downsample(discrete_time_signal,2,0);

% Hy = fftshift(freqz(y,1,nf,'whole'));

Hy = fftshift(fft(y,nf));

subplot(2,1,2)
plot(omega/pi,abs(Hx))
hold on
plot(omega/pi,abs(Hy))
% hold off
legend({'Original','Downsampled'},'Interpreter','Latex')
text(2.5/pi*[-1 1],0.35*[1 1],{'\downarrow Aliasing','Aliasing \downarrow'}, ...
    'HorizontalAlignment','center')
grid on,set(gca,'fontsize',14,'fontweight','bold');
title('Downsampling Effect in Frequency Domain','Interpreter','Latex');
xlabel('$\times \pi$ rad/sample','Interpreter','Latex')




