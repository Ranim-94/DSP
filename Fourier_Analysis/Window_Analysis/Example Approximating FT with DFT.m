%% DFT Approximation to the FT
%
% Copyright 2014 Barry Van Veen
%
% The signal is given by $x(t) = e^{-t/10}\left(\cos(10t) +
% \cos(12t)\right)u(t)$. This signal has a known FT, so we can compare how
% well the DFT approximates it for different parameter choices.
%
% We assume the band of interest is -20 < \omega < 20, and we desire to
% sample the approximation at intervals of at least \pi/40 rads/s.
% Consider two different "resolutions" (a) 2\pi/5 rads/s and (b)
% 2\pi/25 rads/s using a rectangular window.

clear
close all

set(0,'defaultaxesfontsize',22);
set(0,'defaulttextfontsize',22);
linwidth = 2;

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

om_tru = -20:.001:20;
j = sqrt(-1);

X_tru = (0.1 + j*om_tru)./((0.1+j*om_tru).^2 + 100) + ...
(0.1 + j*om_tru)./((0.1+j*om_tru).^2 + 144);

X_tru = abs(X_tru);

%% Sampled signal
%
% Get samples using analytic expression.  The most needed is 10000.

t = [0:9999]*0.01;

x = exp(-t/10).*(cos(10*t) + cos(12*t));

%% Case 1: Resolution 2\pi/5 rads/sec
%
% Use first 1000 samples of x

x1 = x(1:1000);

X1 = 0.01*abs(fft(x1,8000));  % zero pad to get desired frequency sampling
om1 = [0:7999]*200*pi/8000;

figure(1)
h=plot(om_tru,X_tru);
set(h,'LineWidth',linwidth);
hold on
h=stem(om1,X1,'r');
set(h,'LineWidth',linwidth);
axis([0,20,0,6])
xlabel('Frequency (rads/s)')
ylabel('Magnitude')
title('FT (solid) and DFT Approximation (stems). Resolution 2pi/5')

h = get(0,'CurrentFigure');
set(h,'Position',[160,180,1920,1000])

%% Case 2:  Resolution 2\pi/25 rads/sec
%
% Use first 5000 samples of x. Here we'll sample more densely in frequency,
% at \pi/50 rads/s or M=10000.

x2 = x(1:5000);

X2 = 0.01*abs(fft(x2,10000));  % zero pad to get desired frequency sampling
om1 = [0:9999]*200*pi/10000;

figure(2)
h=plot(om_tru,X_tru);
set(h,'LineWidth',linwidth);
hold on
h=stem(om1,X2,'r');
set(h,'LineWidth',linwidth);
axis([0,20,0,6])
xlabel('Frequency (rads/s)')
ylabel('Magnitude')
title('FT (solid) and DFT Approximation (stems). Resolution 2pi/25')

h = get(0,'CurrentFigure');
set(h,'Position',[160,180,1920,1000])

%% Case 3:  Resolution 2\pi/5 rads/sec, Hamming Window
%
% Hamming window has twice the mainlobe width, so we'll use 2000 samples
% of x. Here we'll sample more densely in frequency, at \pi/50 rads/s or
% M=10000.

x3 = x(1:2000);

X3 = 0.01*abs(fft(x3.*hamming(2000)',8000));  
om1 = [0:7999]*200*pi/8000;

figure(3)
h=plot(om_tru,X_tru);
set(h,'LineWidth',linwidth);
hold on
h=stem(om1,X3,'r');
set(h,'LineWidth',linwidth);
axis([0,20,0,6])
xlabel('Frequency (rads/s)')
ylabel('Magnitude')
title('FT (solid) and DFT Approximation (stems). Resolution 2pi/25, Hamming Window')

h = get(0,'CurrentFigure');
set(h,'Position',[160,180,1920,1000])

figure(4)
subplot(211)
h = stem([0:1999],x3);
set(h,'LineWidth',linwidth);
title('Signal')
xlabel('n')
ylabel('Amplitude')
subplot(212)
h=stem([0:1999],hamming(2000));
set(h,'LineWidth',linwidth);
title('Hamming Window')
xlabel('n')
ylabel('Amplitude')

h = get(0,'CurrentFigure');
set(h,'Position',[160,180,1920,1000])



