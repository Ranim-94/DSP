
     
function out_sim = Sim_Spectrum(param)

    % Signal generation, with its time axis
    [time_axis,sig_sampled] = gen_sig(param.fs, ...
                                     param.nb_samples, ...
                                    param);
    
        fprintf('1) Start generating time signal: %s \n',param.choice_signal)

        fprintf('\t - Fs = %d Hz \n',param.fs)
        
        fprintf('\t - Nb of samples = %d \n',param.nb_samples)
        
        fprintf('\t - Time window = %.2f s \n',time_axis(end)-time_axis(1))

        fprintf('=============================================== \n')

    
    % adding the generated signal to the param struct of simulation
    param.sig_sampled = sig_sampled;

    fprintf('2) Start Computing Spectrum using fft \n')

        fprintf('\t - Zero Padding option is: %s \n',param.zero_padd)

    % spectrum generating using fft     
    [spectr,freq_bins]  = gen_spectr(param);

    fprintf('=============================================== \n')

 %%         %******************* Plotting **********************

        % Plotting time domain signal: sampled one with its 
        % continuous version
        
        param.time_axis = time_axis;
        plot_time_signal(param);

        % Plotting Spectrum: CTFT/DTFT 
        
        plot_fft(spectr,freq_bins,param)
        
        
        %% Compare fft and analytical formula for Fourier transform
        
%         set_up_plot_fft_analytical(out_spectral,param_local);

       out_sim = [];
        



        end % End Sim_Sepctrum
    
        









