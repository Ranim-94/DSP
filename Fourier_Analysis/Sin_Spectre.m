

close all;
clear all;
clc;

%%%%%%%%%%%
%PARAMETERS
%%%%%%%%%%%

%set number of samples, FFT length, and sinusoid parameters
caseIndex = 2;

if caseIndex==1
    N = 64; fftLength = N; A1 = 2; f1 = 500; A2 = 0; f2 = 550;
elseif caseIndex == 2
    N = 64; fftLength = 4*N; A1 = 2; f1 = 500; A2 = 0; f2 = 550;
elseif caseIndex == 3
    N = 64; fftLength = 16*N; A1 = 2; f1 = 500; A2 = 0; f2 = 550;
elseif caseIndex == 4
    N = 256; fftLength = 4*N; A1 = 2; f1 = 500; A2 = 0; f2 = 550;
    
end

%%%%%%%%%%%%%%%
%END PARAMETERS
%%%%%%%%%%%%%%%

%set sampling frequency
fs = 8000;

sampling_period = 1/fs;

%set time vector (N samples)
t = 0:sampling_period:(N-1)*sampling_period;

%compute samples of sinusoid
x = A1*sin(2*pi*f1*t) + A2*sin(2*pi*f2*t);

%compute DFT using FFT
y = fftshift(fft(x,fftLength))/N;

%compute frequency vector
delF      = fs/fftLength;
freqVecHz = -fs/2:delF:fs/2-delF;

% in plotting the theoritical answer, the 
% we decreae more the step to obtain more points
delF = delF/128;
freqVecHztheory = -fs/2:delF:fs/2-delF;

tau = max(t)/2;
theorySinc = (A1/2)*sinc(2*(freqVecHztheory-f1)*tau)...
+ (A1/2)*sinc(2*pi*(freqVecHztheory+f1)*tau);

%plot amplitude spectrum
figure;
plot(freqVecHztheory,abs(theorySinc),'r','linewidth',2);
hold on;
plot(freqVecHz,abs((y)),'.-');
xlim([0 fs/2]);
grid on;
set(gca,'fontsize',14,'fontweight','bold');
xlabel('Frequency (Hz)','Interpreter','Latex');
ylabel('Amplitude Spectrum','Interpreter','Latex');
if caseIndex <=4
    legend('Theory','FFT');
end
