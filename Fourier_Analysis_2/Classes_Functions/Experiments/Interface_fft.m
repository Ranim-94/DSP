


classdef Interface_fft

    properties
     
         param

    end 

    methods
        
        % Constructor
        function obj = Interface_fft(param)
        
        obj.param = param ;


        end
     
        function out_sim = start_sim(obj)

            
          % assigning param_local structure to param_local to avoid double
          % . notation
          param_local = obj.param;  
          
        % ------ Generating samples at rate fs ------------
        
        [out_sampler,out_sampler_for_plot] = set_up_sampling(param_local);
        
        %%  Spectral Analysis: Performing CTFT and DTFT using fft
        
        out_spectral  = set_up_spectral(out_sampler,param_local);

 %%         %******************* Plotting **********************

        % Plotting time domain signal: sampled one with its 
        % continous version
        set_up_plot_time_signal(out_sampler_for_plot,...
        out_sampler,param_local)

        % Plotting Sepctrum: CTFT/DTFT 
        
        set_up_plot_fft(out_spectral,param_local)
        
        
        %% Compare fft and analytical formula for Fourier transform
        
%         set_up_plot_fft_analytical(out_spectral,param_local);

       out_sim = [];
        



        end
    
        
    end % End all methods
    
end % End class 








