

%% Windows in the time domain

clc, close all ;

window_length = 100 ;

window_rect = rectwin(window_length);

window_ham = hamming(window_length);

sidelob_attenuation_db_1 = 30 ;

sidelob_attenuation_db_2 = 70 ;

% Chebyshev 30 dB sidelobe atten
window_chebychev_1 = chebwin(100,sidelob_attenuation_db_1); 

% Chebyshev 70 dB sidelobe atten
window_chebychev_2 = chebwin(100,sidelob_attenuation_db_2); 

figure(1)
subplot(2,2,1)
stem(window_rect);
title('Rectangular','Interpreter','latex'),grid on,
set(gca,'fontsize',14,'fontweight','bold');

subplot(2,2,2)
stem(window_ham);
title('Hamming','Interpreter','latex'),grid on,
set(gca,'fontsize',14,'fontweight','bold');

subplot(2,2,3)
stem(window_chebychev_1);grid on,
title('Chebyshev -30 dB','Interpreter','latex')
set(gca,'fontsize',14,'fontweight','bold');


subplot(2,2,4)
stem(window_chebychev_2);
title('Chebyshev -70 dB','Interpreter','latex'),grid on,
set(gca,'fontsize',14,'fontweight','bold');


zero_padding = 2048 ; spectral_step = (2*pi)/zero_padding ;

% %% DFT of Windows
% 
% % compute and display DTFT of windows, use large number of frequency
% % samples to approximate DTFT with DFT
% 
Wr = abs(fft(window_rect,zero_padding)) ;
Wh = abs(fft(window_ham,zero_padding)) ;
Wch1 = abs(fft(window_chebychev_1,zero_padding)) ;
Wch2 = abs(fft(window_chebychev_2,zero_padding)) ;

% discrete frequency bins in radian
frequency_bins = (0:zero_padding -1)*spectral_step; 

figure(2)
plot(frequency_bins,20*log10(Wr)/max(Wr)),
hold on,
plot(frequency_bins,20*log10(Wh)/max(Wh));
% axis([0 pi])
legend({'Rectangular','Hamming'},'Interpreter','latex')
xlabel('$\omega_d$ (rads)','Interpreter','latex'),
set(gca,'fontsize',14,'fontweight','bold'),grid on;

figure(3)
plot(frequency_bins,20*log10(Wch1)/max(Wch1)),
hold on;
plot(frequency_bins,20*log10(Wch2)/max(Wch2));
% axis([0 pi])
legend({'Cheb -30 dB','Cheb -70 dB'},'Interpreter','latex')
xlabel('$\omega_d$ (rads)','Interpreter','latex'),
set(gca,'fontsize',14,'fontweight','bold'),grid on;;





