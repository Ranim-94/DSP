


classdef Interface_bin_leakge

    properties
     
    choice_signal ,bandwidth_Hz , signal_amp
        
    end_time , start_time , 

    fs, sampling_method,nb_of_samples_input,zero_padd
         
        % Options for Plotting 
    time_scale_option_input_signal ,
    show_signal_in_time , time_scale ,  show_time , 
     show_debug

    end 

    methods
        
        % Constructor
        function obj = Interface_bin_leakge(param_sim)

         % Signal Parameters
         obj.choice_signal = param_sim.choice_signal ;
         
         obj.bandwidth_Hz  = param_sim.bandwidth_Hz ;
         
         obj.signal_amp = param_sim.signal_amp ;
           
        % Sampling parameters
        obj.sampling_method = param_sim.sampling_method; 
        
        obj.nb_of_samples_input = param_sim.nb_of_samples_input;
        
        obj.fs  = param_sim.fs ;
        
        obj.zero_padd = param_sim.zero_padd ;

        obj.start_time  = param_sim.start_time ; 
        obj.end_time = param_sim.end_time ;

        % ========
        
        obj.time_scale = param_sim.time_scale ;
        
        obj.show_time = param_sim.show_time ;
 

         % For Plotting 

         obj.time_scale_option_input_signal = ...
         param_sim.time_scale_option_input_signal ;
     
        obj.show_signal_in_time = param_sim.show_signal_in_time ;

        
        obj.show_debug  = param_sim.show_debug ; 

        end
        
        
        function out_sim = start_sim(obj)

        % for display in the x-axis of the FFT plot for the Spectrum
        show_freq = 4*obj.bandwidth_Hz;

        show_freq_input = show_freq;

        %% ------ Generating samples at rate fs ------------
        
        
   [out_sampler,out_sampler_for_plot] = sampling_generating_signal(obj);

        %%  Spectral Analysis: Performing CTFT and DTFT using fft
   
        out_spectral = some_spectral_analysis(out_sampler,obj);

        
 %%         %******************* Plotting **********************


        % Encapsulating parameter for plotting
        
        % for plotting nice continous signal in time
        param_plot.smooth_input_signal = out_sampler_for_plot.signal_sampled;
        
        param_plot.time_smooth_input_signal = out_sampler_for_plot.t_sampled;
        
        % Sampled Signal
        param_plot.t_sampled = out_sampler.t_sampled;

        param_plot.signal_sampled = out_sampler.signal_sampled;
        
        
        % Time axis adjustments
        param_plot.start_time = out_sampler.t_sampled(1);

        param_plot.time_scale = obj.time_scale; 

        param_plot.time_scale_option_input_signal = ...
        obj.time_scale_option_input_signal ;

        param_plot.show_signal_in_time = obj.show_signal_in_time ;
        

        param_plot.Ts = 1/obj.fs;

        param_plot.show_time = obj.show_time;

        % Sepctrum
        param_plot.freq_vector_input = out_spectral.freq_vec_Hz;

        param_plot.bandwidth_Hz = obj.bandwidth_Hz;
        
        param_plot.ctft = out_spectral.fft_comp;

%         param_plot.ctft_phase_Deg = out_spectral.phase_spect_deg;

        param_plot.show_freq_input = show_freq_input;

        
        % Calling the function of the plot
        fft_plots(param_plot);   
  

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








