



classdef Interface_ifft
    
    
    properties
     
          show_debug
        
          bandwidth_Hz , 
        
          choice_signal ,
        
           end_time , start_time , 

           fs, 
         
        % Options for Plotting 
        time_scale_option_input_signal ,
        
        show_signal_in_time , time_scale ,  show_time , 

        
    end 
    
    
    
    methods
        
        % Constructor
        function obj = Interface_ifft(param_sim)
        
         obj.show_debug  = param_sim.show_debug ; 
                    
         obj.bandwidth_Hz  = param_sim.bandwidth_Hz ;
           
    
         obj.choice_signal = param_sim.choice_signal ;

        obj.end_time = param_sim.end_time ;

        obj.time_scale = param_sim.time_scale ;
        
        obj.show_time = param_sim.show_time ;

         
         obj.fs  = param_sim.fs ;
         


         
         % For Plotting 

         obj.time_scale_option_input_signal = ...
         param_sim.time_scale_option_input_signal ;
     
        obj.show_signal_in_time = param_sim.show_signal_in_time ;
        
  
        
        obj.start_time  = param_sim.start_time ;
        

        end
        
        
        function out_sim = start_sim(obj)


        signal_amp = 2;

        % for display in the x-axis of the FFT plot for the Spectrum
        show_freq = 4*obj.bandwidth_Hz;

        

        show_freq_input = show_freq;



        %% ------ Generating samples at rate fs ------------
        
        % Start time
        param_sampler.start_time = obj.start_time  ;
         
        % End Time
        param_sampler.end_time  = obj.end_time ;
        
        % For sampling 
        param_sampler.fs = obj.fs; 
        
        
        % Analytical signal prameters
        param_sampler.choice_signal = obj.choice_signal ;
        param_sampler.bandwidth_Hz = obj.bandwidth_Hz;
        param_sampler.signal_amp = signal_amp;
        
        
        % Instantiating the object
        sampler = Sampler(param_sampler) ;

        % Sampling and generating signal  
        out_sampler = sampler.sampling_uniform();


        % Setting higher Fs to plot nice continous time
        % domain signal superimposed with the input samples
        % this used for plotting in time domain only 
        %(I dont use it for computational purposes)
        fs_analog_plot = 70*obj.bandwidth_Hz;
        
        % setting higher fs in the sampler object  
        sampler = sampler.set_fs(fs_analog_plot);
        
        out_sampler_for_plot = sampler.sampling_uniform();
        
 

        %**************************************************************

        %%  Spectral Analysis: Performing CTFT and DTFT using fft
   

        % Specifying the parameters

        param_spectral.signal_sampled  = out_sampler.signal_sampled ;

        param_spectral.nb_of_samples  = out_sampler.nb_of_samples ;

        param_spectral.fs = obj.fs ;
        
        param_spectral.zero_padd = 'True';


        % instantiating
        spectral = Spectral(param_spectral) ;

        out_spectral = spectral.compute_fft();
        

        
        %% Performing ifft
        
        % we use the ifftshift command to undo the effect of fftshift
        dummy_variable = ifft(ifftshift(out_spectral.ctft_comp));
        
        % taking 
        signal_ifft = real(dummy_variable(1:out_sampler.nb_of_samples));
        
        
      
        
        
 %%         %******************* Plotting **********************


        % Encapsulating parameter for plotting
        
        % for plotting nice continous signal in time
        param_plot.smooth_input_signal = out_sampler_for_plot.signal_sampled;
        
        param_plot.time_smooth_input_signal = out_sampler_for_plot.t_sampled;
        
        % Sampled Signal
        param_plot.t_sampled = out_sampler.t_sampled;

        param_plot.signal_sampled = out_sampler.signal_sampled;
        
        
        % Time axis adjustments
        param_plot.start_time = param_sampler.start_time;

        param_plot.time_scale = obj.time_scale; 

        param_plot.time_scale_option_input_signal = ...
        obj.time_scale_option_input_signal ;

        param_plot.show_signal_in_time = obj.show_signal_in_time ;
        

        param_plot.Ts = 1/obj.fs;

        param_plot.show_time = obj.show_time;

        % Sepctrum
        param_plot.freq_vector_input = out_spectral.F_zero_Fs;

        param_plot.bandwidth_Hz = obj.bandwidth_Hz;
        
        param_plot.ctft = out_spectral.ctft_comp;

        param_plot.ctft_phase_Deg = out_spectral.phase_spect_deg;

        param_plot.show_freq_input = show_freq_input;

        
        
        
       
        
    
        param_plot.signal_ifft = signal_ifft;
        
        % Calling the function of the plot
        fft_plots(param_plot);   
  
        % ifft plot 
        ifft_plots(param_plot)
        
        
        

       %% **************** Logging  *************************


%         param_log.start_time = param_sampler.start_time;
% 
%         param_log.end_time = param_sampler.end_time;
% 
%         param_log.fs = obj.fs;
% 
%         param_log.bandwidth_Hz = obj.bandwidth_Hz;
% 
% 
%         param_log.nb_of_samples = nb_of_samples;
% 
%         param_log.signal_type = string(obj.choice_signal);
%         
%         param_log.time_scale_option_input_signal = ...
%         obj.time_scale_option_input_signal;
%     
%         param_log.time_scale = obj.time_scale ;

%         % Instantiating the object
%         log = Logging(param_log) ;
% 
%         % Printing logs
%         log.print_logs();



    



   
    
  




  


       out_sim = [];
        
      


 


        end
    
        
    end
    
end








