


%% Lowpass compare rectangular and Hamming windows


clc, close all;

% filter order
fir_oder = 24;

% for plotting discrete frequency response
% to be used in freqz command
nb_of_discrete_freq_point = 2048;


% ********* Computing FIR taps using rectangular and Hamming window *******

% Window design method - rectangular window
cuttoff_freq = 0.5 ; % it is in rad/s and normalized by pi
% so this mean we need to divide the discrete freq axis by pi

% computing filter taps using fir1 command 

% Window design method - rectangular window
b1 = fir1(fir_oder, cuttoff_freq, ones(1,fir_oder+1));

% Window design method - Hamming window
b2 = fir1(fir_oder, cuttoff_freq, hamming(fir_oder+1));



[freq_response_fir_rec,~] = freqz(b1,1,nb_of_discrete_freq_point);

[freq_response_fir_hamm,discrete_freq] = freqz(b2,1,nb_of_discrete_freq_point);

% Plot filter frequency responses for both windows, dB scale
figure(1)
subplot(1,3,1),
% Plotting FIR using Rectangular window
plot(discrete_freq/pi,20*log10(abs(freq_response_fir_rec)),'b')
hold on;

% plotting FIR using Hamm Window
plot(discrete_freq/pi,20*log10(abs(freq_response_fir_hamm)),'g'),
legend({'Rectangular','Hamming'},'Interpreter','latex')
title(['Window Based Lowpass Filter M = ',num2str(fir_oder)],...
'Interpreter','latex')
axis([0 1 -80, 5])
grid on
xlabel('Normalized Frequency $\omega/\pi$','Interpreter','latex')
ylabel('Gain dB','Interpreter','latex')
set(gca,'fontsize',14,'fontweight','bold');

% Plot filter frequency responses for both windows, linear scale

figure(1)
subplot(1,3,2)
plot(discrete_freq/pi,abs(freq_response_fir_rec),'b',... % Rect window
discrete_freq/pi,abs(freq_response_fir_hamm),'g'); % Ham window
legend({'Rectangular','Hamming'},'Interpreter','latex')
title(['Window Based Lowpass Filter M = ',num2str(fir_oder)],'Interpreter','latex')
axis([0 1 0, 1.2])
grid on
xlabel('Normalized Frequency $\omega/\pi$','Interpreter','latex')
ylabel('Gain Linear Scale','Interpreter','latex')
set(gca,'fontsize',14,'fontweight','bold');


% Display window DTFT magnitude - main lobe and side lobes

%First: computing discrete time window 
% dimension of the window is the same as FIR order
% Obtain windows separately for illustration
discrete_time_rect_window = ones(1,fir_oder+1);
ham_window_coef = hamming(fir_oder+1);

[Hr,~] = freqz(discrete_time_rect_window,1,4096,'whole');
[Hh,discrete_freq] = freqz(ham_window_coef,1,4096,'whole');

% divide by the max for normalization
Hr = fftshift(Hr/max(abs(Hr)));
Hh = fftshift(Hh/max(abs(Hh)));


figure(1),subplot(1,3,3)

% why this -1 when using freqz with windows 
% this -1 is to make the freq axis between -pi and pi
% similar to -Fs/2 and and Fs/2
plot((discrete_freq/pi)-1,20*log10(abs(Hr)),'b',...
(discrete_freq/pi)-1,20*log10(abs(Hh)),'g');
legend({'Rectangular','Hamming'},'Interpreter','latex')
title(['Window DTFT M = ',num2str(fir_oder)],'Interpreter','latex')
% axis([-1 1 -60, 5])
grid on
xlabel('Normalized Frequency $\omega/\pi$','Interpreter','latex')
ylabel('Gain dB','Interpreter','latex')
set(gca,'fontsize',14,'fontweight','bold');