


classdef Logging
    
    
    properties
   
    % Analog Sampling rate for simulation    
    fs_sim , 
    
    % Bandwidth of Input Signal
    bandwidth_Hz , 
    
    bound_fs_ch 
    
    fs_ch , f_alias , start_time , time_duration
    
    nb_of_samples , nb_channel , signal_type ,
    
    delayed_channels,delays_conditions,
    
    time_scale_option_input_signal , time_scale
        
        
    end  
        
        methods

            % Constructor
            
            function obj = Logging(param_log)
                
            obj.nb_of_samples = param_log.nb_of_samples;

            obj.bound_fs_ch =  param_log.bound_fs_ch ;
            
            obj.bandwidth_Hz = param_log.bandwidth_Hz;
            
            obj.fs_ch = param_log.fs_ch;

            obj.f_alias = param_log.f_alias;

            obj.start_time = param_log.start_time;

            obj.time_duration = param_log.time_duration;

            obj.nb_of_samples = param_log.nb_of_samples;

            obj.fs_sim = param_log.fs_sim;

           obj.nb_channel = param_log.nb_channel;    
           
           obj.signal_type =  param_log.signal_type;
           
           obj.delays_conditions = param_log.delays_conditions ;
           
           obj.delayed_channels = param_log.delayed_channels ;
           
           obj.time_scale_option_input_signal = ...
           param_log.time_scale_option_input_signal ;
       
           obj.time_scale = param_log.time_scale ;
                
            end 
            
            
            
            function print_logs(obj)
     
           %**************** Logging *********************
            
           
           fprintf('------------------------------------ \n'),
           
           fprintf('-------- Start Logging -------------- \n'),
           
           fprintf('------------------------------------ \n\n'),
           
           
           
           fprintf('------ Signal Parameters -------------- \n\n'),
            
           fprintf('--> Type of Input Signal: %s \n',obj.signal_type);    

           fprintf('--> Bandwidth of Input Signal: %d Hz \n \n',obj.bandwidth_Hz); 
           
           
           
           
           fprintf('------ General Parameters -------------- \n\n'),
            
            fprintf('--> Observation Window: from %d to %d in s \n',...
            obj.start_time,obj.time_duration); 
           
            fprintf('--> Fs Analog for Simulation: %d Hz \n',obj.fs_sim);    

            fprintf('--> Total Nb of Samples over the observation window'),
            
            fprintf(' for Fs %d Hz is : %.0f \n \n',obj.fs_sim,obj.nb_of_samples);
            
            
            
            
            fprintf('------ Channels Parameters -------------- \n\n'), 
            
            fprintf('--> Nb of Channels = %d \n',obj.nb_channel);
            
            fprintf('--> Lower Bound on Fs_ch: %.1f Hz \n',obj.bound_fs_ch);

            fprintf('--> Chosen Sampling Rate per channel (Fs_ch): %d Hz \n',...
            obj.fs_ch);

            
            % Computing sampling period per channel to display it in 
            % logging
            Ts_ch = 1/obj.fs_ch;
            
            
            fprintf('--> Sampling Period per channel (Ts_ch): %.1f %s \n',...
            Ts_ch*obj.time_scale,obj.time_scale_option_input_signal);
            
            
            
            if obj.fs_ch < 2*obj.bandwidth_Hz
            
            fprintf('--> Alias Frequency: %d Hz \n \n',obj.f_alias);

            
            else
            
            fprintf('--> Respecting Nyquist, no Aliasing \n \n');    
                
                
            end
            
            % Printing delays in each channel
            
            fprintf('--> Printing Delays in each channel: \n');
            
            for index = 1:obj.nb_channel
                
            fprintf('\t - Delay in Channel %d : %.1f %s \n',...
            index,obj.delayed_channels(index)*obj.time_scale,...
            obj.time_scale_option_input_signal)
                
            end 
            
            
            fprintf('--> Delays Condition between channels: %f \n',...
            obj.delays_conditions);
            
            
            
            fprintf('--> ------------------------------------ \n'),
           
           fprintf('--> -------- END Logging -------------- \n\n'),
           
           fprintf('--> ------------------------------------ \n'),
           
     
            
            end
            
            
            
        end 
    
    
    
    
end 