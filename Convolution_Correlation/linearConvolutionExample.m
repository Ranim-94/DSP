close all;
clear all;
clc;

%set time vector k1
k1 = 0:6;

%define signal f
f = k1;

%define signal g
g = [ones(1,3) 2*ones(1,3) 3*ones(1,3) 4*(ones(1,3))];
    
%plot the two signals
figure;
subplot(2,1,1);
stem(k1,f,'filled','linewidth',2);
set(gca,'fontsize',14,'fontweight','bold');
ylabel('f[k]');
grid on;
title('Two Sequences To Convolve');
subplot(2,1,2);
stem(0:numel(g)-1,g,'filled','linewidth',2);
set(gca,'fontsize',14,'fontweight','bold');
ylabel('g[k]');
grid on;
xlabel('Time Index (k)');

%perform convolution using matlab conv function
yMatlab = conv(f,g);

%plot the matlab results
figure;
stem(0:numel(yMatlab)-1,yMatlab,'filled','linewidth',2);
set(gca,'fontsize',14,'fontweight','bold');
ylabel('y[k]');
grid on;
xlabel('Time Index (k)');
title('Linear Convolution Using Matlab Conv Function');
ax = axis;

%now we'll perform convolution using FFTs.  Remember, when we use a
%computer, multiplication in the frequency domain is equal to CIRCULAR
%convolution in the time domain.  However, we can get linear convolution if
%we are careful about zero padding our signals.  The steps/algorithm for
%doing this are below.

%1) compute number of samples in each signal
N1 = numel(f);
N2 = numel(g);

%2) zero pad
fPad = [f zeros(1,N2-1)];
gPad = [g zeros(1,N1-1)];

%3) take fft
F = fft(fPad);
G = fft(gPad);

%4) take frequency domain product
Y = F.*G;

%5) go back to time domain
yMine = ifft(Y);

%because we were careful with zero padding, yMine is now equal to yMine =
%f*g where * is linear convolution.

%plot the result. This should look exactly like the result obtained using
%the matlab CONV function.
figure;
stem(0:numel(yMine)-1,yMine,'filled','linewidth',2);
set(gca,'fontsize',14,'fontweight','bold');
ylabel('y[k]');
grid on;
xlabel('Time Index (k)');
title('Linear Convolution Using FFTs');
axis(ax);