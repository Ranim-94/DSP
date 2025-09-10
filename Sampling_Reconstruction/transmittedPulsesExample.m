close all;
clear all;
clc;

T = 1;
t = linspace(0,12,2048);

x = ones(size(t));

ind = t>=0*T & t<=1*T;
x(ind) = -1;

ind = t>=2*T & t<=3*T;
x(ind) = -1;

ind = t>=7*T & t<=8*T;
x(ind) = -1;

figure;
subplot(2,1,1);
plot(t,x,'linewidth',2);
ylim([-4 4]);
grid on;
set(gca,'fontsize',14,'fontweight','bold');
ylabel('Transmitted Signal');

N = 90;
y = conv(x+2*randn(size(x)),(1/N)*ones(1,N),'same');
subplot(2,1,2);
plot(t,y,'linewidth',2);
ylim([-4 4]);
grid on;
set(gca,'fontsize',14,'fontweight','bold');
xlabel('Time (s)');
ylabel('Received Signal');




figure;
subplot(2,1,2);
plot(t,x,'linewidth',2);
ylim([-4 4]);
grid on;
set(gca,'fontsize',14,'fontweight','bold');
ylabel('Demodulated Signal');
subplot(2,1,1);
plot(t,y,'linewidth',2);
ylim([-4 4]);
grid on;
set(gca,'fontsize',14,'fontweight','bold');
xlabel('Time (s)');
ylabel('Received Signal');
