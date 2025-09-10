


%% DTFT of truncated cosines closely spaced in frequency
%
% One cosine at 7*pi/100 the other at 7.5*pi/100.  Width of the mainlobe
% for the rectangular window is 4*pi/100, much larger than the separation
% between the two cosines.

clc, close all ;

% Preparing 1st discrete signal
length_rect_window = 100;

discrete_window = linspace(0,length_rect_window,length_rect_window); 

% The variables to be tuned here are the discrete frequencies
% and the amplitude of the 2 signals

% discrete frequencies for spectral separation
% 
% amplitude cmponents to see the effect of the side lobe
% even when the 2 cos are well separated in frequency domain

% Setting discrete frequencies
discrete_freq_1 = (7*pi)/100 ;

discrete_freq_2 = (12*pi)/100 ;

% Setting the amplitude of the signals
amp_1 = 1 ; amp_2 = 1 ;

% Preparing 2nd discrete signal

x1_discrete = amp_1 * cos(discrete_window.*discrete_freq_1);

x2_discrete = amp_2 * cos(discrete_window.*discrete_freq_2);

% Use DFT with very large number of freq samples to approx DTFT

length_fft = 4^nextpow2(length_rect_window);

X1 = fftshift(fft(x1_discrete,length_fft)) ;


X2 = fftshift(fft(x2_discrete,length_fft));

Xsum = fftshift(fft(x1_discrete+x2_discrete,length_fft));

freq_step = (2*pi)/length_fft;

% Generating discrete frequency bins
discrete_freq_bins = linspace(-pi,pi,length_fft) ;

% Display DTFT approx(only positive freqs up to pi/4)

% rounding for displaying into plots
discrete_freq_1 = round(discrete_freq_1,2);

figure(2)
subplot(3,2,1)
plot(discrete_freq_bins,abs(X1))
title(['cos(',num2str(discrete_freq_1),'$ \, n$)'],'Interpreter','latex')
xlabel('$\omega_d$ rads','Interpreter','latex'),grid on,
ylabel(' $|X(\omega_d)|$','Interpreter','latex')
axis([0 pi 0 max(abs(X1))]),
set(gca,'fontsize',14,'fontweight','bold');


subplot(3,2,2)
plot(discrete_freq_bins,20*log10(abs(X1)));
title(['cos(',num2str(discrete_freq_1),'$ \, n$)'],'Interpreter','latex')
xlabel('$\omega_d$ rads','Interpreter','latex'),grid on,
ylabel('$|X(\omega_d)|$ dB Scale','Interpreter','latex')
axis([0 pi 0 max(20*log10(abs(X1)))])
set(gca,'fontsize',14,'fontweight','bold');


% rounding for displaying into plots
discrete_freq_2 = round(discrete_freq_2,2);

subplot(3,2,3)
plot(discrete_freq_bins,abs(X2));
title(['cos(',num2str(discrete_freq_2),'$n$)'],'Interpreter','latex')
xlabel('$\omega_d$ rads','Interpreter','latex'),grid on,
ylabel('$|X(\omega_d)|$','Interpreter','latex')
axis([0 pi 0 max(abs(X2))])
set(gca,'fontsize',14,'fontweight','bold');

subplot(3,2,4)
plot(discrete_freq_bins,20*log10(abs(X2)));
title(['cos(',num2str(discrete_freq_2),'$n$)'],'Interpreter','latex')
xlabel('$\omega_d$ rads','Interpreter','latex')
ylabel('$|X(\omega_d)|$ dB Scale','Interpreter','latex'),grid on,
axis([0 pi 0 max(20*log10(abs(X2)))]),
set(gca,'fontsize',14,'fontweight','bold');


subplot(3,2,5)
plot(discrete_freq_bins,abs(Xsum));
title(['cos(',num2str(discrete_freq_1),'$ \, n$ ) +' ...
    'cos(',num2str(discrete_freq_2),'$ \, n$)'],...
'Interpreter','latex'),
xlabel('freq rads','Interpreter','latex'),grid on,
ylabel('$|X(\omega_d)|$','Interpreter','latex')
axis([0 pi 0 max(abs(Xsum))]),
set(gca,'fontsize',14,'fontweight','bold');

subplot(3,2,6)
plot(discrete_freq_bins,20*log10(abs(Xsum)));
title(['cos(',num2str(discrete_freq_1),'$ \, n$) +' ...
    'cos(',num2str(discrete_freq_2),'$ \, n$)'],...
'Interpreter','latex'),
xlabel('$\omega_d$ rads','Interpreter','latex')
ylabel('$|X(\omega_d)|$ dB Scale','Interpreter','latex')
axis([0 pi 0 max(20*log10(abs(Xsum)))]),grid on,
set(gca,'fontsize',14,'fontweight','bold');



%% DFT of cosines that are more separated in frequency
%
% One cosine at 7*pi/100 the other at 10*pi/100.  Width of the mainlobe
% for the rectangular window is 4*pi/100, comparable to the separation
% between the two cosines.

x3 = cos([0:length_rect_window-1]*10*pi/100);
X3 = fft(x3,4096);
Xsum = fft(x1_discrete+x3,4096);

% Display DTFT approx (only positive freqs up to pi/4)

figure(3)
subplot(3,2,1)
plot([0:511]*pi/2048,(abs(X1(1:512))));
title('Cos with freq 7*pi/100','Interpreter','latex')
xlabel('freq rads','Interpreter','latex'),grid on

subplot(3,2,2)
plot([0:511]*pi/2048,20*log10(abs(X1(1:512))));
title('Cos with freq 7*pi/100','Interpreter','latex')
xlabel('freq rads','Interpreter','latex')
ylabel('dB','Interpreter','latex')
axis([0 pi/4 -20 40]),grid on

subplot(3,2,3)
plot([0:511]*pi/2048,(abs(X3(1:512))));
title('Cos with freq 10*pi/100','Interpreter','latex')
xlabel('freq rads','Interpreter','latex'),grid on

subplot(3,2,4)
plot([0:511]*pi/2048,20*log10(abs(X3(1:512))));
title('Cos with freq 10*pi/100','Interpreter','latex')
xlabel('freq rads','Interpreter','latex')
ylabel('dB','Interpreter','latex')
axis([0 pi/4 -20 40]),grid on

subplot(3,2,5)
plot([0:511]*pi/2048,(abs(Xsum(1:512))));
title('Sum of Cos freqs 7pi/100 and 10pi/100','Interpreter','latex')
xlabel('freq rads','Interpreter','latex')

subplot(3,2,6)
plot([0:511]*pi/2048,20*log10(abs(Xsum(1:512))));
title('Sum of Cos freqs 7pi/100 and 10pi/100','Interpreter','latex')
xlabel('freq rads','Interpreter','latex')
ylabel('dB','Interpreter','latex')
axis([0 pi/4 -20 40]),grid on


%% DFT for large amplitude and small amplitude cosines
%
% Explore dynamic range - the sidelobe shadow of a large amplitude term
% hides the smaller amplitude component.  First cosine has frequency
% 7*pi/100 and amplitude 1.  Second cosine has frequency 20*pi/100 and weak
% amplitude, start with 0.1, then next try 0.01.

density_points = 4096 ; spectral_sampling = 2*pi/density_points

x4 = cos([0:length_rect_window-1]*20*pi/100);
X4 = fft(0.1*x4,density_points);
Xsum = fft(x1_discrete+0.1*x4,density_points);

figure(4)
subplot(3,2,1)
plot([0:511]*spectral_sampling,(abs(X1(1:512))));
title('Cos with freq 7*pi/100','Interpreter','latex')
xlabel('freq rads','Interpreter','latex'),grid on

subplot(3,2,2)
plot([0:511]*spectral_sampling,20*log10(abs(X1(1:512))));
title('Cos with freq 7*pi/100','Interpreter','latex')
xlabel('freq rads','Interpreter','latex')
ylabel('dB','Interpreter','latex')
axis([0 pi/4 -20 40]),grid on


subplot(3,2,3)
plot([0:511]*spectral_sampling,(abs(X4(1:512))));
title('Cos with freq 20*pi/100, ampl 0.1','Interpreter','latex')
xlabel('freq rads','Interpreter','latex'),grid on


subplot(3,2,4)
plot([0:511]*spectral_sampling,20*log10(abs(X4(1:512))));
title('Cos with freq 20*pi/100, ampl 0.1','Interpreter','latex')
xlabel('freq rads','Interpreter','latex')
ylabel('dB','Interpreter','latex')
axis([0 pi/4 -20 40]),grid on


subplot(3,2,5)
plot([0:511]*spectral_sampling,(abs(Xsum(1:512))));
title('Sum of Cos freqs 7pi/100 and 20pi/100','Interpreter','latex')
xlabel('freq rads','Interpreter','latex'),grid on


subplot(3,2,6)
plot([0:511]*spectral_sampling,20*log10(abs(Xsum(1:512))));
title('Sum of Cos freqs 7pi/100 and 20pi/100','Interpreter','latex')
xlabel('freq rads','Interpreter','latex')
ylabel('dB','Interpreter','latex')
axis([0 pi/4 -20 40]),grid on



%% Weaker cosine disappears into the sidelobes of the large amplitude cosine

X4 = fft(0.01*x4,4096);
Xsum = fft(x1_discrete+0.01*x4,4096);

figure(5)
subplot(3,2,1)
plot([0:511]*pi/2048,(abs(X1(1:512))));
title('Cos with freq 7*pi/100')
xlabel('freq rads')

subplot(3,2,2)
plot([0:511]*pi/2048,20*log10(abs(X1(1:512))));
title('Cos with freq 7*pi/100')
xlabel('freq rads')
ylabel('dB')
axis([0 pi/4 -20 40])

subplot(3,2,3)
plot([0:511]*pi/2048,(abs(X4(1:512))));
title('Cos with freq 20*pi/100, ampl 0.01')
xlabel('freq rads')

subplot(3,2,4)
plot([0:511]*pi/2048,20*log10(abs(X4(1:512))));
title('Cos with freq 20*pi/100, ampl 0.01')
xlabel('freq rads')
ylabel('dB')
axis([0 pi/4 -20 40])

subplot(3,2,5)
plot([0:511]*pi/2048,(abs(Xsum(1:512))));
title('Sum of Cos freqs 7pi/100 and 20pi/100')
xlabel('freq rads')
subplot(3,2,6)

plot([0:511]*pi/2048,20*log10(abs(Xsum(1:512))));
title('Sum of Cos freqs 7pi/100 and 20pi/100')
xlabel('freq rads')
ylabel('dB')
axis([0 pi/4 -20 40])



