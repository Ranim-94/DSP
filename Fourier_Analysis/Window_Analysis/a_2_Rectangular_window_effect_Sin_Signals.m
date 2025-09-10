close all;

clc;

%%%%%%%%%%%
%PARAMETERS
%%%%%%%%%%%

%set number of samples, FFT length, and sinusoid parameters
caseIndex = 3;

if caseIndex==1
    N = 64; fftLength = N; A1 = 2; f1 = 500; A2 = 0; f2 = 550;
elseif caseIndex == 2
    N = 64; fftLength = 4*N; A1 = 2; f1 = 500; A2 = 0; f2 = 550;
elseif caseIndex == 3
    N = 64; fftLength = 16*N; A1 = 2; f1 = 500; A2 = 0; f2 = 550;
elseif caseIndex == 4
    N = 256; fftLength = 4*N; A1 = 2; f1 = 500; A2 = 0; f2 = 550;
    
    % switching on 2nd sin wave of freq = f2
elseif caseIndex == 5
    N = 64; fftLength = N; A1 = 2; f1 = 500; A2 = 2; f2 = 550;    
elseif caseIndex == 6
    N = 256; fftLength = N; A1 = 2; f1 = 500; A2 = 2; f2 = 550;
elseif caseIndex == 7
    N = 256; fftLength = 4*N; A1 = 2; f1 = 500; A2 = 2; f2 = 550;
elseif caseIndex == 8
    N = 2048; fftLength = 4*N; A1 = 2; f1 = 500; A2 = 2; f2 = 550;    
end

%%%%%%%%%%%%%%%
%END PARAMETERS
%%%%%%%%%%%%%%%

%set sampling frequency
fs = 8000;

%set time vector (N samples)
t = 0:1/fs:(N-1)/fs;

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
freqVecHzOverSamp = -fs/2:delF:fs/2-delF;

tau = max(t)/2;
theorySinc = (A1/2)*sinc(2*pi*(freqVecHzOverSamp-f1)*tau/pi)...
+ (A1/2)*sinc(2*pi*(freqVecHzOverSamp+f1)*tau);

%plot amplitude spectrum
figure;
hold on;
if caseIndex <=4
    plot(freqVecHzOverSamp,abs(theorySinc),'r','linewidth',2);
end
plot(freqVecHz,abs((y)),'.-');
grid on;
set(gca,'fontsize',14,'fontweight','bold');
xlabel('Frequency (Hz)','Interpreter','Latex');
ylabel('Amplitude Spectrum','Interpreter','Latex');
if caseIndex <=4
    legend('Theory','FFT');
end
