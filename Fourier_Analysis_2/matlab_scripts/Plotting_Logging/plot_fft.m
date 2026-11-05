

function plot_fft(spectr,freq_vect_Hz,param)
        
        
        %param_plot.ctft_phase_Deg = out_spectral.phase_spect_deg;
        
        % for display in the x-axis of the FFT plot for the Spectrum
%         param_plot.show_freq_input = 2*obj.bandwidth_Hz;
        
        show_freq_input = (param.fs)/2;

        
        % Plotting CTFT Amplitude and Phase spectrum

        % Amplitude of CTFT using FFT

        figure() 
        % subplot(1,2,1)
        plot(freq_vect_Hz,abs(spectr)); % Magnitude Spectrum
        xlim([-show_freq_input show_freq_input]);
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


        
end % plot_fft()