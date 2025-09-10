



function fft_plots(param_plot)


% Plotting CTFT Amplitude and Phase spectrum

% Ampitude of CTFT using FFT

figure()
% subplot(1,2,1)
plot(param_plot.freq_vect_fft_Hz,abs(param_plot.fft_comp));
xlim([-param_plot.show_freq_input param_plot.show_freq_input]);
grid on;
set(gca,'fontsize',14,'fontweight','bold');
title('Amplitude Spectrum of fft ($x(t)$)','Interpreter','Latex');
xlabel('Frequency [Hz]','Interpreter','Latex');


 % Phase Spectrum
 
 % Computing Phase from 
 % The phase value is in radian: convert them to degree
        % rad2deg <--> *(180/pi)
%  phase_spect = rad2deg(unwrap(angle(param_plot.fft_comp))) ;
%  
%  subplot(1,2,2),
%  plot(param_plot.freq_vect_fft_Hz,phase_spect);
%     
%     % Adjusting limit of frequency axis
%     xlim([-param_plot.show_freq_input param_plot.show_freq_input]);
%     grid on;set(gca,'fontsize',14,'fontweight','bold');
%     title('Phase Spectrum($x(t)$)','Interpreter','Latex');
%     xlabel('Frequency [Hz]','Interpreter','Latex');
%     ylabel('Degree','Interpreter','Latex');
%     

   
    





end % function