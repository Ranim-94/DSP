

%% Minimax FIR Filter Design Example: Bandpass Filter
%
% Copyright 2014 Barry Van Veen

clear
close all

set(0,'defaultaxesfontsize',22);
set(0,'defaulttextfontsize',22);
linwidth = 2;


%
% passband 0.3pi to 0.5pi
% stopbands 0 to 0.2pi and .65pi to pi
%
% Ripple not specified because we explore the effects of changing the
% weights on the error in different bands.

freqbands = [0 0.2*pi 0.3*pi 0.5*pi 0.65*pi pi]/pi; %normalized pass and stop bands
bandgains = [ 0 0 1 1 0 0]; % unit gain in passband, 0 gain in stop band (ideal)
bandwghts1 = [ 1 1 1]; 
bandwghts2 = [ 100 1 100];
bandwghts3 = [10 1 100];
bandwghts4 = [100 1 10];

order = 46;

Bf1 = firpm(order,freqbands,bandgains,bandwghts1);
Bf2 = firpm(order,freqbands,bandgains,bandwghts2);
Bf3 = firpm(order,freqbands,bandgains,bandwghts3);
Bf4 = firpm(order,freqbands,bandgains,bandwghts4);

[H1,W] = freqz(Bf1,1,2048);
[H2,W] = freqz(Bf2,1,2048);
[H3,W] = freqz(Bf3,1,2048);
[H4,W] = freqz(Bf4,1,2048);

figure(1)
h = plot(W/pi,20*log10(abs(H1)));
title('Equal Weighting of Bands')
axis([0 1 -80, 5])
grid on
xlabel('Normalized Frequency \omega/\pi')
ylabel('gain dB')
set(h,'LineWidth',linwidth);
h = get(0,'CurrentFigure');
set(h,'Position',[160,180,800,500])

figure(2)
h = plot(W/pi,20*log10(abs(H2)));
title('Stop = 100, Pass = 1')
axis([0 1 -80, 5])
grid on
xlabel('Normalized Frequency \omega/\pi')
ylabel('gain dB')
set(h,'LineWidth',linwidth);
h = get(0,'CurrentFigure');
set(h,'Position',[160,180,800,500])

figure(3)
h = plot(W/pi,20*log10(abs(H3)));
title('LowStop = 10, Pass = 1, Highstop = 100')
axis([0 1 -80, 5])
grid on
xlabel('Normalized Frequency \omega/\pi')
ylabel('gain dB')
set(h,'LineWidth',linwidth);
h = get(0,'CurrentFigure');
set(h,'Position',[160,180,800,500])

figure(4)
h = plot(W/pi,20*log10(abs(H4)));
title('LowStop = 100, Pass = 1, Highstop = 10')
axis([0 1 -80, 5])
grid on
xlabel('Normalized Frequency \omega/\pi')
ylabel('gain dB')
set(h,'LineWidth',linwidth);
h = get(0,'CurrentFigure');
set(h,'Position',[160,180,800,500])

% Change stopband to eliminate large lobe

freqbands = [0 0.2*pi 0.3*pi 0.5*pi 0.6*pi pi]/pi;
Bf5 = firpm(order,freqbands,bandgains,bandwghts4);
[H5,W] = freqz(Bf5,1,2048);
figure(5)
h = plot(W/pi,20*log10(abs(H5)));
title('LowStop = 100, Pass = 1, Highstop = 10')
axis([0 1 -80, 5])
grid on
xlabel('Normalized Frequency \omega/\pi')
ylabel('gain dB')
set(h,'LineWidth',linwidth);
h = get(0,'CurrentFigure');
set(h,'Position',[160,180,800,500])

