close all;
clear all;
clc;

%set sampling time, we sample every T seconds
T = 1/16;

%compute the sampling rate
fs = 1/T;

%set signal length/truncation
T0 = 16;

%compute number of samples
N0 = T0/T;

%compute Omega0 (the rth sample of F(Omega) is at frequency r*Omega0)
Omega0 = 2*pi/N0;

%compute the time vector to sample the continuous function
t = 0:T:T*(N0-1);

%we work with the continuous signal f(t) = e(-at)u(t) in this example
%compute samples of the signal scaled by T, i.e fk
a  = 0.5;
f  = exp(-a*t);
fk = T*f;

%initialize the DFT vector
Fr = zeros(N0,1);

%compute the DFT, i.e. the Fr
for r = 0:N0-1
    Fr(r+1) = 0;
    for k = 0:N0-1
        Fr(r+1) = Fr(r+1) + fk(k+1)*exp(-j*r*Omega0*k);
    end
end

%compute the "continuous" frequency vector
%our sampling rate is fs, so we can only see up to fs/2
w = linspace(0,2*pi*(fs/2),10*N0);

%compute our samples of the continuous frequency vector
%samples go from 0 to 2pi in increments of Omega0
%frequency 0 to 2pi "maps" to 0 to fs/2
wVec = [(0:N0-1)*Omega0]*fs;

fVec  = wVec/(2*pi) ; fcont = w/(2*pi) ;

%compute theoretical magnitude spectrum for signals of form e^(-at)u(t)
% absF = 1./sqrt(w.^2 + a^2);

absF = 1./sqrt((2*pi*fcont).^2 + a^2);

%plot comparison of theoretical F(w) to DFT, i.e. samples of F(w)
figure;
hold on;
% stem(wVec./(2*pi),abs(Fr),'b','linewidth',2);
% plot(w./(2*pi),absF,'r','linewidth',2);

stem(fVec,abs(Fr),'b','linewidth',2);
plot(fcont,absF,'r','linewidth',2);

xlim([0 fs/2]);
grid on;
set(gca,'fontsize',14,'fontweight','bold');
xlabel('Frequency (Hz)');
ylabel('Amplitude Spectrum');
title('DFT FOR Loop');
legend('|DFT|','|F(\omega)|');

%plot comparison of theoretical F(w) to FFT, i.e. samples of F(w)
%the FFT is just a specific implementation of the DFT so these two figures
%should look the same
% myFFT = T*fft(f);
% figure;
% hold on;
% stem(wVec/(2*pi),abs(myFFT),'b','linewidth',2);
% plot(w./(2*pi),absF,'r','linewidth',2);
% xlim([0 fs/2]);
% grid on;
% set(gca,'fontsize',14,'fontweight','bold');
% xlabel('Frequency (Hz)');
% ylabel('Amplitude Spectrum');
% title('FFT');
% legend('|FFT|','|F(\omega)|');