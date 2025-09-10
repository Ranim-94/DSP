close all;
clear all;
clc;

%load the WAV file
[x,fs,NBITS] = wavread('musicSampleOriginal.wav');

%grab just a portion of the file
x = x(40000:60000);

%set the sampling period
Ts = 1/fs;

%set time vector
t = 0:Ts:(numel(x)-1)*Ts;

%lets grab a subset of samples
N = 4;
resampledSignal = x(1:N:end)';

%compute new time vector
tNew = 0:Ts*N:(numel(resampledSignal)-1)*Ts*N;

%perform sinc interpolation on samples
s1 = sincInterpolation(resampledSignal,tNew,t,1000);
s1 = s1(:);  %make column

%compare original signal and sinc interpolated signal
figure;
plot(t,x);
hold on;
plot(t,s1,'r');
grid on;
xlabel('Time (s)');
ylabel('Amplitude');
title(['Comparison of Original and Sinc Interpolated Music WAV File (Downsampled ' num2str(N) ')']);
legend('Original Music WAV','Reconstructed Music WAV');

%compare original signal and sinc interpolated signal (zoomed)
figure;
plot(t,x);
hold on;
plot(t,s1,'r');
grid on;
xlabel('Time (s)');
ylabel('Amplitude');
title(['Comparison of Original and Sinc Interpolated Music WAV File (Downsampled ' num2str(N) ')']);
legend('Original Music WAV','Reconstructed Music WAV');
ax = [0.1253    0.1421   -0.5227    0.6335];
axis(ax);

%plot time-domain error between original and sinc interpolated signal
e = s1-x;
figure;
plot(t,e,'k');
grid on;
xlabel('Time (s)');
ylabel('Error');
title(['Error Between Original and Sinc Interpolated Music WAV File (Downsampled ' num2str(N) ')']);

%plot spectrum of original and sinc interpolated signal
f = linspace(-fs/2,fs/2,numel(x));
figure;
hold on;
X = fftshift(fft(x));
Xr = fftshift(fft(s1));
plot(f,abs(X));
plot(f,abs(Xr),'r');
xlabel('Frequency (Hz)');
ylabel('Amplitude Spectrum');
title(['Comparison of Original and Sinc Interpolated Spectrum (Downsampled ' num2str(N) ')']);

%write the resampled WAV file to disk
wavwrite(s1,fs,NBITS,'musicSampleResampled.wav');

