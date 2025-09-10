




%% Lowpass FIR using Frequency sampling method


clc, close all;

% filter order
fir_oder = 20;

% for plotting discrete frequency response
% to be used in freqz command
nb_of_discrete_freq_point = 2048;


% ********* Computing FIR taps using rectangular and Hamming window *******

% Sepcify the freq specs

normzalized_omega_pass = 0.25;

normzalized_omega_stop = 0.35;

normalized_discrete_freq = ...
[0,normzalized_omega_pass,normzalized_omega_stop,1] ;

% Amp reponse with corresponding to normzalized discrete freq
amp_response_linear = [1,1,0,0];

    
% computing filter taps using fir2 command for frequency sampling method 
% by default: the Hamming window is used to obtain the FIR taps
fir_taps = ...
fir2(fir_oder, normalized_discrete_freq,amp_response_linear);

% Computing the frequency response
[freq_response_fir,discrete_freq] = ...
freqz(fir_taps,1,nb_of_discrete_freq_point);



% Plot filter frequency responses for both windows, dB scale
figure(1)
% plotting the FIR Amp Spectrum
subplot(1,2,1)
plot(discrete_freq/pi,20*log10(abs(freq_response_fir)));
title(['FIR Low Pass Filter with M = ',num2str(fir_oder)],'Interpreter','latex')
% axis([0 1 -80, 5])
grid on
xlabel('Normalized Frequency $\omega/\pi$','Interpreter','latex')
ylabel('Gain dB','Interpreter','latex')
set(gca,'fontsize',14,'fontweight','bold');

% plotting FIR Impulse Response
figure(1),
subplot(1,2,2)
stem(0:fir_oder,fir_taps);
title('FIR Impulse Response','Interpreter','latex')
grid on,
xlim([0,fir_oder])
xlabel('Samples','Interpreter','latex')
set(gca,'fontsize',14,'fontweight','bold');

