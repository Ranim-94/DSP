

function set_up_plot_fft(out_spectral,obj)
        
        param_plot.freq_vect_fft_Hz = out_spectral.freq_vect_fft_Hz;

        param_plot.bandwidth_Hz = obj.bandwidth_Hz;
        
        param_plot.fft_comp = out_spectral.fft_comp;

        %param_plot.ctft_phase_Deg = out_spectral.phase_spect_deg;
        
        % for display in the x-axis of the FFT plot for the Spectrum
%         param_plot.show_freq_input = 2*obj.bandwidth_Hz;
        
        param_plot.show_freq_input = obj.fs/2;
        
     
        % Calling the function
        
        fft_plots(param_plot)
        
end 