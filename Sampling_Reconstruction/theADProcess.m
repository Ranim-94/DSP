close all;
clear all;
clc;

t = linspace(0,1,2048);
tk = 0:0.05:1;

%setup the original signal
x = cos(2*pi*1*t) + 2*sin(2*pi*2*t);
xkOrig = cos(2*pi*1*tk) + 2*sin(2*pi*2*tk);

%quantize to L = numel(unique(xk)) levels
xk = 1*round(xkOrig/1);
%xk(xk<-2.5) = -2.5;

%compute L and deltaV for this quantization amount
L      = numel(unique(xk));
deltaV = median(diff(unique(xk)));

figure;
plot(t,x,'linewidth',2);
hold on;
grid on;
set(gca,'fontsize',14,'fontweight','bold');
xlabel('Time (s)');
ylabel('Amplitude')
hStem = stem(tk,xk,'filled');
set(hStem,'color','r');
legend('x(t)','Quantized samples of x(t)');
ylim([-3.5 3.5]);
title(['Quantization Example: m_{p}=3, L = ' num2str(L) ', \Delta v=' num2str(deltaV)]);


figure;
stem(tk,xkOrig-xk,'filled');
set(gca,'fontsize',14,'fontweight','bold');
xlabel('Time (s)');
ylabel('Amplitude')
title('Quantization Error: L = 6, \Delta v=1')
ylim([-3.5 3.5]);
grid on;



%quantize more
xk = 0.5*round(xkOrig/0.5);

%compute L and deltaV for this quantization amount
L      = numel(unique(xk));
deltaV = median(diff(unique(xk)));

figure;
plot(t,x,'linewidth',2);
hold on;
grid on;
set(gca,'fontsize',14,'fontweight','bold');
xlabel('Time (s)');
ylabel('Amplitude')
hStem = stem(tk,xk,'filled');
set(hStem,'color','r');
legend('x(t)','Quantized samples of x(t)');
ylim([-3.5 3.5]);
title(['Quantization Example: m_{p}=3, L = ' num2str(L) ', \Delta v=' num2str(deltaV)]);

figure;
stem(tk,xkOrig-xk,'filled');
set(gca,'fontsize',14,'fontweight','bold');
xlabel('Time (s)');
ylabel('Amplitude')
title('Quantization Error: L = 12, \Delta v=0.5')
ylim([-3.5 3.5]);
grid on;


%quantize more
xk = 0.125*round(xkOrig/0.125);

%compute L and deltaV for this quantization amount
L      = numel(unique(xk));
deltaV = median(diff(unique(xk)));

figure;
plot(t,x,'linewidth',2);
hold on;
grid on;
set(gca,'fontsize',14,'fontweight','bold');
xlabel('Time (s)');
ylabel('Amplitude')
hStem = stem(tk,xk,'filled');
set(hStem,'color','r');
legend('x(t)','Quantized samples of x(t)');
ylim([-3.5 3.5]);
title(['Quantization Example: m_{p}=3, L = ' num2str(L) ', \Delta v=' num2str(deltaV)]);

figure;
stem(tk,xkOrig-xk,'filled');
set(gca,'fontsize',14,'fontweight','bold');
xlabel('Time (s)');
ylabel('Amplitude')
title('Quantization Error: L = 48, \Delta v=0.125')
ylim([-3.5 3.5]);
grid on;


 savefig('quantizing01.pdf', 1,'pdf');
 savefig('quantizing01error.pdf', 2,'pdf');
 
 savefig('quantizing02.pdf', 3,'pdf');
 savefig('quantizing02error.pdf', 4,'pdf');
 
 savefig('quantizing03.pdf', 5,'pdf');
 savefig('quantizing03error.pdf', 6,'pdf');
