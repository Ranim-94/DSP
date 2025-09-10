


close all; clc;

numZeros = [0,4,8,16];


% ------------- 1) Analytica Form of the DTFT ----------------------

%compute frequency vector of the analytical form
Omega_analytical = linspace(0,2*pi,1024);
 
%compute theoretical DTFT F
dtft_analytical = exp(-j*Omega_analytical).*(2 + 6*cos(Omega_analytical));


% ---------- Trying different options for Zero Padding on
% DFT for DTFT spectrum

for i = 1:length(numZeros)

%set the discrete time signal f
sampled_signal = [3 2 3 zeros(1,numZeros(i))]';

%compute number of points
nb_points_signal = numel(sampled_signal);


discrete_time_vector = linspace(0,length(sampled_signal),length(sampled_signal));

discrete_time_vector = discrete_time_vector(:);

% --------- 2) Numerical Computation of DTFT using DFT ------------

[spectral_step,wVec,freq_vector,dft_values] = ...
dft_dtft(nb_points_signal,sampled_signal) ;

% rounding for displaying into plots
spectral_step = round(spectral_step,2);

%------  plot comparison of theoretical F(Omega) to DFT, i.e. samples of F(Omega)
figure(i);

subplot(1,2,1),
stem(discrete_time_vector,sampled_signal,'linewidth',2);
grid on;
set(gca,'fontsize',14,'fontweight','bold');
xlabel('Index $[n]$','Interpreter','latex');
title('$x[n]$','Interpreter','latex');

legend({['Zero Padding = ',num2str(numZeros(i))]},'Interpreter','latex'),



subplot(1,2,2),
plot(Omega_analytical,abs(dtft_analytical),'r','linewidth',2);
hold on;
stem(wVec,abs(dft_values),'b','linewidth',2);
xlim([0 2*pi]);
grid on;
set(gca,'fontsize',14,'fontweight','bold');
xlabel('Frequency ($\Omega$)','Interpreter','latex');
ylabel('Amplitude Spectrum','Interpreter','latex');
title(['Spectral Step $\Omega_0 \, = \, $',...
    num2str(spectral_step)],'Interpreter','latex');
legend({'$ F(\omega_d)$ Analytical','DFT for loop'},'Interpreter','latex');


% saveas(gcf,['Figures\DFT_DTFT_zero_padd_',num2str(numZeros(i))],'epsc')

end