close all;
clear all;
clc;

%set number of zeros for zero padding
numZeros = 0;

%in this example we work with infinite time extent signals of the form 
%f = (a)^k * u[k].  Since we cannot compute f for all time, we truncate the
%signal, i.e. only compute the signal from time zero up to some time.  As
%kMax gets larger, the DTFT of the truncated signal will start looking more
%and more like the DTFT of the infinite length signal

%set the discrete-time signal f
a    = 0.8;
kMax = 4;
kVec = 0:1:kMax;
f    = (a).^kVec;

%compute number of points
N0 = numel(f);

%compute Omega0
Omega0 = 2*pi/N0;

%initialize DFT vector
Fr = zeros(N0,1);

%compute the N0-point DFT, i.e. the Fr
for r = 0:N0-1
    Fr(r+1) = 0;
    for k = 0:N0-1
        Fr(r+1) = Fr(r+1) + f(k+1)*exp(-j*r*Omega0*k);
    end
end

%compute the "continuous" frequency vector
Omega = linspace(0,2*pi,4096);

%compute our samples of the continuous frequency vector
OmegaVec = (0:N0-1)*Omega0;
 
%compute theoretical DTFT F(Omega) for this infinite length signal
%this expression for F is something we look up in a table, it is a function
%of the continuous variable Omega.
F = 1./(1-a*exp(-j*Omega));

%compute theoretical DTFT FN0(Omega) for N0-point signal
%note: FNO(Omega) is a continuous function of Omega.  Since we are working
%on a computer we can never really plot a continuous function since it
%would have an infinite number of samples.  However, this function will
%"look" continuous since I've sampled the continuous frequency vector Omega
%at such a high rate.  This is why I use quotes when I say "continuous"
%frequency vector.
FN0 = zeros(1,numel(Omega));
for k = 0:N0-1
    FN0 = FN0 + f(k+1)*exp(-j*Omega*k);
end

%we compare the following quantities in the plot below
% 1) F(Omega) (DTFT of infinite length signal)
% 2) FN0(Omega) (DTFT of finite length signal), 
% 3) DFT (samples of the DTFT of the finite length signal)
figure;
hold on;
plot(Omega,abs(F),'linewidth',2);          %F(Omega)
plot(Omega,abs(FN0),'k','linewidth',2);    %FN0(Omega)
stem(OmegaVec,abs(Fr),'r','linewidth',2);  %DFT
grid on;
set(gca,'fontsize',14,'fontweight','bold');
xlim([0 2*pi]);
xlabel('Frequency \Omega (rad/sample)');
ylabel('Amplitude Spectrum');
title('DFT FOR Loop','Interpreter','latex');
legend('|F(\Omega)| (infinite length signal)','|F(\Omega)| (N0 point signal)','|DFT|')



