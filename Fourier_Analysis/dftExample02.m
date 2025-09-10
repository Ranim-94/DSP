close all;
clear all;
clc;

numZeros = 15;

%set the discrete time signal f
f = [3 2 3 zeros(1,numZeros)];

%compute number of points
N0 = numel(f);

%compute Omega0
Omega0 = 2*pi/N0;

%initialize vector
Fr = zeros(N0,1);

%compute the DFT, i.e. the Fr
for r = 0:N0-1
    Fr(r+1) = 0;
    for k = 0:N0-1
        Fr(r+1) = Fr(r+1) + f(k+1)*exp(-j*r*Omega0*k);
    end
end

%compute frequency vector
Omega = linspace(0,2*pi,1024);
 
%compute theoretical DTFT F
F = exp(-j*Omega).*(2 + 6*cos(Omega));

%compute our samples of the continuous frequency vector Omega
%samples go from 0 to 2pi in increments of Omega0
omegaVec = [(0:N0-1)*Omega0];

%plot comparison of theoretical F(Omega) to DFT, i.e. samples of F(Omega)
figure;
hold on;
plot(Omega,abs(F),'r','linewidth',2);
stem(omegaVec,abs(Fr),'b','linewidth',2);
xlim([0 2*pi]);
grid on;
set(gca,'fontsize',14,'fontweight','bold');
xlabel('Frequency (\Omega)');
ylabel('Amplitude Spectrum');
title('DFT FOR Loop');
legend('|F(\Omega)|','|DFT|','location','best');