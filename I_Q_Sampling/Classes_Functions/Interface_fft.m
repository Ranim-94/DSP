


classdef Interface_fft

    properties
     
         show_debug
        
         bandwidth_Hz , 
        
         choice_signal, signal_amp,
        
         sampling_method, end_time , start_time , nb_of_samples_input

         fs, 
         
        % Options for Plotting 
        time_scale_option_input_signal ,
        
        show_signal_in_time , time_scale ,  show_time , 

        
    end 
    
    
    
    methods
        
        % Constructor
        function obj = Interface_fft(param_sim)
        
         % Sampling   
         obj.sampling_method = param_sim.sampling_method ;
         
         obj.start_time = param_sim.start_time ;
         
         obj.end_time = param_sim.end_time ;
         
         obj.fs  = param_sim.fs ;
         
         % if sampling is done by sepcifyin how many samples we use
         % and then we compute start and endtime
         obj.nb_of_samples_input = param_sim.nb_of_samples_input;
         
         % Signal 
         
         obj.choice_signal = param_sim.choice_signal ;
         
         obj.bandwidth_Hz  = param_sim.bandwidth_Hz ;
         
         obj.signal_amp  = param_sim.signal_amp ;
         
         obj.show_debug  = param_sim.show_debug ; 

         % For Plotting 
         
         obj.time_scale = param_sim.time_scale ;
        
        obj.show_time = param_sim.show_time ;

         obj.time_scale_option_input_signal = ...
         param_sim.time_scale_option_input_signal ;
     
        obj.show_signal_in_time = param_sim.show_signal_in_time ;
        
        obj.show_debug = param_sim.show_debug;


        end
     
        function out_sim = start_sim(obj)

        % ------ Generating samples at rate fs ------------
        
        [out_sampler,out_sampler_for_plot] = set_up_sampling(obj);
        
        %%  Spectral Analysis: Performing CTFT and DTFT using fft
        
        out_spectral  = set_up_spectral(out_sampler,obj);

 %%         %******************* Plotting **********************

        % Plotting time domain signal: sampled one with its 
        % continous version
        set_up_plot_time_signal(out_sampler_for_plot,...
        out_sampler,obj)

        % Plotting Sepctrum: CTFT/DTFT 
        
        set_up_plot_fft(out_spectral,obj)
        
        
        %% Compare fft and analytical formula for Fourier transform
        
        set_up_plot_fft_analytical(out_spectral,obj);
        
        
 

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








