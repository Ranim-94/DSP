

%% Short-time Fourier Transform


load Sax

%% First example, linear chirp

clc, close all ;

% in Hz
sampling_freq = 1000 ;

sampling_time = 1/sampling_freq ;

start_time = 0;

% 0-2 secs, sampled at 1000 Hz
t_sampled = 0:sampling_time:2; 


% in Hz
instantaneous_freq_1 = 150;

instantaneous_freq_0 = 0;

% in s
instantaneous_time_1 = 1;

%linear chirp starting at zero and crossing 150Hz at t=1 sec
signal = chirp(t_sampled,instantaneous_freq_0,instantaneous_time_1,...
instantaneous_freq_1);


fft_length = 256;

window_length = 256 ; overlap = 250 ;

figure(1)

subplot(1,2,1),
plot(t_sampled,signal,'r','linewidth',2);
xlabel('Time (sec)','Interpreter','latex'),grid on;
set(gca,'fontsize',14,'fontweight','bold');



subplot(1,2,2),
spectrogram(signal,window_length,overlap,fft_length,sampling_freq,'yaxis');
% spectrogram: y is signal to evaluate, 256 is window length, 250 is overlap, 
% 256 is fft length (number of frequencies), 1E3 is sampling freq, 'yaxis' 
% puts frequency variation along the y-axis

title('Linear Chirp','Interpreter','latex')
ylabel('Frequency (Hz)','Interpreter','latex')
xlabel('Time (sec)','Interpreter','latex')
set(gca,'fontsize',14,'fontweight','bold');

%% Second example, 2 crossing chirps

y2=signal+chirp(t_sampled,300,1,150);
% two crossing chirps, second starts at 300 Hz and crosses 150Hz at t=1 s
figure(2)
spectrogram(y2,256,250,256,1E3,'yaxis');
title('Two Linear Chirps')
ylabel('Frequency (Hz)')
xlabel('Time (sec)')

%% Third example, chirp plus two sinusoids, one changes frequency at t=1 s

figure(3)
y3=signal+cos(2*pi*275*t_sampled)+[cos(2*pi*300*t_sampled(1:1000)), cos(2*pi*250*t_sampled(1001:2001))];
% increasing chirp plus two sinusoids
% at t=1 one of the sinusoids jumps from 300 Hz to 250 Hz
spectrogram(y3,256,250,256,1E3,'yaxis');
title('Linear chirp plus two sinusoids, 256 point windows')
ylabel('Frequency (Hz)')
xlabel('Time (sec)')

h = get(0,'CurrentFigure');
set(h,'Position',[0,0,1000,600])

% Redo third example with different parameters in the STFT
% improve temporal resolution at the expense of frequency resolution using
% shorter window (from 256 down to 128)
figure(4)
spectrogram(y3,128,125,256,1E3,'yaxis');
% spectrogram: y3 is signal to evaluate, 128 is window length, 125 is overlap, 
% 256 is fft length, 1E3 is sampling freq, yaxis puts frequency on yaxis
title('Linear chirp plus two sinusoids, 128 point windows')
ylabel('Frequency (Hz)')
xlabel('Time (sec)')

h = get(0,'CurrentFigure');
set(h,'Position',[0,0,1000,600])

% Display the underlying filter banks for the 256 point window

w1=hamming(256);
%filter freq response at dc
W1(:,1)=20*log10(abs(fftshift(fft(w1,4096)))+eps);
%filter freq response at f_s/256
W1(:,2)=20*log10(abs(fftshift(fft(w1.*exp(j*[0:255]'*2*pi/256),4096))));
%filter freq response at 2f_s/256
W1(:,3)=20*log10(abs(fftshift(fft(w1.*exp(j*[0:255]'*4*pi/256),4096))));
%filter freq response at 3f_s/256
W1(:,4)=20*log10(abs(fftshift(fft(w1.*exp(j*[0:255]'*6*pi/256),4096))));
f=([0:4095]-2048)*(1E3/4096);
figure(5)
hp = plot(f,W1)
xlim([-40,80])
set(hp,'LineWidth',linwidth);
% only display the frequency responses in a range near f=0 Hz
title('First Four Filterbanks: 256 pt Window Spectrogram')
xlabel('Frequency (Hz)')
ylabel('Gain (dB)')
grid on

h = get(0,'CurrentFigure');
set(h,'Position',[0,0,1000,600])


% Display the underlying filter banks for the 128 point window

w2=hamming(128);
%filter freq response at dc
W2(:,1)=20*log10(abs(fftshift(fft(w2,4096)))+eps);
%filter freq response at f_s/256
W2(:,2)=20*log10(abs(fftshift(fft(w2.*exp(j*[0:127]'*2*pi/256),4096))));
%filter freq response at 2f_s/256
W2(:,3)=20*log10(abs(fftshift(fft(w2.*exp(j*[0:127]'*4*pi/256),4096))));
%filter freq response at 3f_s/256
W2(:,4)=20*log10(abs(fftshift(fft(w2.*exp(j*[0:127]'*6*pi/256),4096))));
f=([0:4095]-2048)*(1E3/4096);
figure(6)
hp = plot(f,W2)
xlim([-40,80])
set(hp,'LineWidth',linwidth);
% only display the frequency responses in a range near f=0 Hz
title('First Four Filterbanks: 128 pt Window Spectrogram')
xlabel('Frequency (Hz)')
ylabel('Gain (dB)')
grid on

h = get(0,'CurrentFigure');
set(h,'Position',[0,0,1000,600])

%% Saxophone Riff

figure(7)
spectrogram(Sax_riff,812,192,2048,fs,'yaxis');

title('Sax Riff Spectrogram')
ylabel('Frequency (Hz)')
xlabel('Time (sec)')
ylim([0,4000])

h = get(0,'CurrentFigure');
set(h,'Position',[0,0,1300,800])



