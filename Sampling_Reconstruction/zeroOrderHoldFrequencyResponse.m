close all;
clear all;
clc;

%set sampling parameters
T = 1;

%compute other sampling parameters
fs     = 1/T;
omegaS = 2*pi*fs;

%set frequency vector (linear)
f = linspace(-2*fs,2*fs,1000);

%compute frequency vector (radial)
omega = 2*pi*f;

%compute frequency response H(omega)
Homega = T*exp(-j*omega*T/2).*sincX((omega*T)/2);

%plot amplitude response
figure;
hold on;
plot(omega,abs(Homega),'linewidth',2);

%plot plus/minus omegaS/2 region
wNorm = linspace(-0.5*omegaS,0.5*omegaS,100);
plot([-0.5*omegaS-eps wNorm 0.5*omegaS+eps],[0 ones(1,numel(wNorm)) 0],'k','linewidth',2);

%set axis, etc
set(gca,'fontsize',14,'fontweight','bold');
grid on;
xlabel('\omega (rad/s)');
ylabel('Amplitude Response |H(\omega)|');
ylim([0 1.1]);