

function set_up_plot_fft_analytical(out_spectral,obj)

param_plot.freq_vect_fft_Hz = out_spectral.freq_vect_fft_Hz;

% to check which signal we have and implement closed form formula
% for CTFT 
param_plot.choice_signal = obj.choice_signal;

        param_plot.bandwidth_Hz = obj.bandwidth_Hz;
        
        param_plot.fft_comp = out_spectral.fft_comp;
        
        param_plot.fs = obj.fs;

        % for display in the x-axis of the FFT plot for the Spectrum
        param_plot.show_freq_input = 2*obj.bandwidth_Hz;
        
        % used to compute width of window in case working
        % with cos or sin but windowed 
        param_plot.end_time = obj.end_time ;
        
        param_plot.start_time = obj.start_time ;
        
        param_plot.signal_amp = obj.signal_amp ;

        % Calling the function
        
        fft_analytical_plot(param_plot)


end 