close all;
clear all;
clc;

%load and plot the original WAV file
[YOrig,Fs,NBITS] = wavread('speechSampleOriginal.wav');
t = 0:1/Fs:((length(YOrig)-1)/Fs);
figure;
plot(t,YOrig);
xlabel('Time (s)');
ylim([-1.1 1.1]);
title('Original 8-Bit Quantization');

%6-Bit quantization
Y = sigQuant(YOrig,6);
figure;
plot(t,Y);
xlabel('Time (s)');
title('6-Bit Quantization');
ylim([-1.1 1.1]);
wavwrite(Y,Fs,'speechSample6bit.wav');

%4-Bit quantization
Y = sigQuant(YOrig,4);
figure;
plot(t,Y);
xlabel('Time (s)');
title('4-Bit Quantization');
ylim([-1.1 1.1]);
wavwrite(Y,Fs,'speechSample4bit.wav');

%3-Bit quantization
Y = sigQuant(YOrig,3);
figure;
plot(t,Y);
xlabel('Time (s)');
title('3-Bit Quantization');
ylim([-1.1 1.1]);
wavwrite(Y,Fs,'speechSample3bit.wav');