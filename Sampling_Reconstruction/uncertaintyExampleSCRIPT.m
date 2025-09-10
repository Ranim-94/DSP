close all;
clear all;
clc;

%set sampling period/rate
Ts = 0.0001;
fs = 1/Ts;

%construct time/frequency vectors
t = -500:Ts:500;
f = linspace(-fs/2,fs/2,numel(t));
omega = 2*pi*f;

%set time-domain decay factor
a = 10;

%constuct the time-domain signal x(t)
x = exp(-a*abs(t));

%construct the frequency-domain signal X(omega)
X = 2*a./(a^2 + (omega).^2);

%plot the signal in time domain
figure;
plot(t,x,'linewidth',2);
xlim([-5 5]);
ylim([0 1]);
set(gca,'fontsize',14,'fontweight','bold');
set(gcf,'position',[390   541   560   420]);
grid on;
xlabel('Time (s)');
title('Time-Domain Signal x(t)');

%plot the signal in frequency domain
figure;
plot(omega,X,'linewidth',2);
xlim([-30 30]);
set(gca,'fontsize',14,'fontweight','bold');
set(gcf,'position',[968   541   560   420]);
grid on;
xlabel('Frequency (rad/s)');
title('Frequency-Domain Signal X(\omega)');

%compute time extent
num = trapz(t,(t.^2.*abs(x).^2));
den = trapz(t,abs(x).^2);
Td = num/den

%compute the frequency extent
num = trapz(omega,(omega.^2.*abs(X).^2));
den = trapz(omega,abs(X).^2);
Bw = num/den

%compute time-bandwidth product
timeBandwidthProduct = Td*Bw