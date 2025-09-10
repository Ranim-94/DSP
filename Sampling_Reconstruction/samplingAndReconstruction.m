close all;
clear all;
clc;

%set "continous-time" sampling rate
fsCont = 500;
td     = 1/fsCont;

%set quantization levels
quantLevels = 16;

%set time and frequencies of signal (f1 < f2)
f1   = 1;
f2   = 3;
Tmax = 1; % in s

%set sampling rate (must satisfy fsCont/fs = integer)

% this sampling rate is used to create the impulse
% sampling version of the continous time signal
% the amplitude spectrum will be replicated at a multiple of
% fs
fs      = 50;
ts      = 1/fs; % the ts will be used
Nfactor = ts/td;

%set oversampling factor for FFT
FFTOverSampFactor = 2;

%%%%%%%%%%%%%%%%%%%%%
%END INPUT PARAMETERS
%%%%%%%%%%%%%%%%%%%%%

%construct "continuous-time" signal
t    = 0:td:Tmax; % from 0 to 1 with a step size of 2 ms
xsig = sin(2*pi*f1*t)-sin(2*pi*f2*t);
Lsig = length(xsig);

%create an "impulse sampled" version of the signal
downSampleFactor = round(ts/td);
impulseMask = 0*xsig;
impulseMask(1:downSampleFactor:end) = 1;
sImpulseSampled = xsig.*impulseMask;

%compute next power of two
Lfft = 2^ceil(log2(Lsig)+FFTOverSampFactor);
 
%compute frequency axis based on sampling frequency 
Fmax  = fsCont/2;
Faxis = linspace(-Fmax,Fmax,Lfft);
 
%compute FFT of original "continous-time" signal
Xsig = fftshift(fft(xsig,Lfft));
 
%compute FFT of sampled signal
S_out = fftshift(fft(sImpulseSampled,Lfft));
 
%   Examples of sampling and reconstruction using 
%      a) ideal impulse train through LPF
%      b) flat top pulse reconstruction through LPF
%   plot the original signal and the sample signals in time
%   and frequency domain

%plot original signal and its samples
figure(1);
hold on;
subplot(2,2,1),
%plot the original "continous-time" signal
plot(t,xsig,'k','linewidth',2);
xlabel('Time [s]','Interpreter','latex');
title('Continous time signal $g(t)$','Interpreter','latex');
set(gca,'fontsize',14,'fontweight','bold');
grid on;
% Plotting the Amplitude Spectrum
subplot(2,2,2),
plot(Faxis,abs(Xsig),'linewidth',2);
xlim([-Fmax Fmax]);
set(gca,'fontsize',14,'fontweight','bold');
xlabel('frequency (Hz)','Interpreter','latex');
title('Amplitude Spectrum of $g(t)$','Interpreter','latex');
grid on;



%plot the Impulse Sampled Signal superimposed with continous time version
subplot(2,2,3)
plot(t,xsig,'k','linewidth',2);
hold on,
plot(t,sImpulseSampled(1:Lsig),'b','linewidth',2); 
xlabel('Time (s)','Interpreter','latex');
title('Signal $g(t)$ and its Samples','Interpreter','latex');
grid on;
set(gca,'fontsize',14,'fontweight','bold');
ylim([-3 3]);



%plot the Amplitude Spectrum of the sampled signal
figure(1);
subplot(2,2,4)
plot(Faxis,abs(S_out),'linewidth',2);
xlim([-Fmax Fmax]);
set(gca,'fontsize',14,'fontweight','bold');
xlabel('f[Hz]','Interpreter','latex');
title('Spectrum of Impulse Sampled $g(t)$','Interpreter','latex');
grid on;

saveas(figure(1),'Figures_Sampling/Signal_and_Impulse.fig')



%%
%set LPF cutoff frequency
BW = 3*f2;

%construct filter in the frequency domain
H_lpf                 = zeros(1,Lfft);
H_lpf(abs(Faxis)<=BW) = 1;

%make plot of sampled spectrum with amplitiude response of filter superimposed
figure(2);
subplot(1,2,1),
hold on;
plot(Faxis,abs(S_out),'linewidth',2);

% plotting the filtered signal
plot(Faxis,H_lpf*max(abs(S_out)),'r','linewidth',2);
xlim([-Fmax Fmax]);
set(gca,'fontsize',14,'fontweight','bold');
xlabel('Frequency [Hz]','Interpreter','latex');
title('Spectrum of Impulse Sampled $g(t)$','Interpreter','latex');
legend('Sampled Signal Spectrum','Ideal LPF','location','best');
grid on;

%perform ideal filtering in the frequency domain (i.e. multiplication)
% S_recv = Nfactor*S_out.*H_lpf;             % ideal filtering

S_recv = fs* S_out.*H_lpf;             % ideal filtering

%IFFT to return to time-domain
s_recv = real(ifft(fftshift(S_recv)));
s_recv = s_recv(1:Lsig);

%plot the ideally reconstructed signal in time domain
figure(2);
subplot(1,2,2),
hold on;
plot(t,xsig,'b','linewidth',2); 
plot(t,s_recv,'r','linewidth',2); 
set(gca,'fontsize',14,'fontweight','bold');
legend('Original signal','Ideal Reconstructed Signal',...
'location','best');
xlabel('Time [s]','Interpreter','latex');
grid on;
title('Original and Ideally Reconstructed Signal','Interpreter','latex');

saveas(figure(2),'Figures_Sampling/Signal_and_Impulse_reconstruction.fig')
%%
%zero-order hold filter has an impulse response that is just a pulse
zoh = ones(1,Nfactor);

%compute frequency response of ZOH filter
ZOH = fftshift(fft(zoh,Lfft));

%plot amplitude response of ZOH filter
figure(3);
subplot(2,2,1),
plot(Faxis,abs(ZOH),'linewidth',2);
set(gca,'fontsize',14,'fontweight','bold');
xlabel('Frequency [Hz]','Interpreter','latex');
ylabel('Amplitude Response','Interpreter','latex');
title('ZOH Filter Amplitude Response','Interpreter','latex');
grid on;
%in 

%create sample and hold signal by convolving samples with ZOH impulse response
s_ni = conv(sImpulseSampled,zoh);

%grab samples to account for filter latency
s_ni = s_ni(numel(zoh)/2+1:numel(t)+numel(zoh)/2);

%compute spectrum of sample and hold signal
S_ni = fftshift(fft(s_ni,Lfft));

%perform ideal filtering in the frequency domain (i.e. multiplication)
S_recv2 = S_ni.*H_lpf;

%IFFT to return to time-domain
s_recv2 = real(ifft(fftshift(S_recv2)));
s_recv2 = s_recv2(1:Lsig);

%plot the original and ZOH signal in the time domain
figure(3);
subplot(2,2,2)
hold on;
plot(t,xsig,'b','linewidth',2);
plot(t,s_ni,'r','linewidth',2);
set(gca,'fontsize',14,'fontweight','bold');
xlabel('Time [s]','Interpreter','latex');
title('Original and ZOH Signal','Interpreter','latex');
legend('Original','ZOH Signal','location','best');
grid on;


%make plot of ZOH signal spectrum, original signal spectrum and amplitude response of ideal filter superimposed
%Note: For default values of f1 and f2, the spectrum of the ZOH and
%original signals look very similar over the passband of the LPF.  However,
%setting f2 to a larger number (such as 6) will show a discrepency at the
%higher frequency due to distortion introduced by the ZOH filter response
figure(3);
subplot(2,2,3)
hold on;
plot(Faxis,abs(S_ni),'linewidth',2);
plot(Faxis,abs(Xsig),'k','linewidth',2);
plot(Faxis,H_lpf*max(abs(S_ni)),'r','linewidth',2);
xlim([-Fmax Fmax]);
set(gca,'fontsize',14,'fontweight','bold');
xlabel('Frequency [Hz]','Interpreter','latex');
title('Spectrum of ZOH Signal','Interpreter','latex');
legend('ZOH','Original','Ideal LPF','location','best');
grid on;

%plot the ZOH recontructed signal and compare to original
figure(3);
subplot(2,2,4)
hold on;
plot(t,xsig,'b','linewidth',2);
plot(t,s_recv2,'r','linewidth',2); 
set(gca,'fontsize',14,'fontweight','bold');
legend('Original Signal','ZOH Reconstruction');
xlabel('Time [s]','Interpreter','latex');
title('Original and ZOH Reconstruction Signals','Interpreter','latex');
grid on;

saveas(figure(3),'Figures_Sampling/Signal_and_Zoh.fig')
