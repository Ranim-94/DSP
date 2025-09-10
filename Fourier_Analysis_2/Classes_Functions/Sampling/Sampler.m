

classdef Sampler
    
    properties
    
    param
    
    % Goal: sampling and generating analytical signal
    
    % Input: start time, end_time
    % Fs (sampling rate)
    % array list of choice signal (string type)

    end 
    
    methods
    
        % this is the constructer: name of the function has the same 
        % name as the class
        function obj = Sampler(param)

         obj.param  = param ;
 
        end
        
        function out_sampler = sampling_uniform(obj)
          
         param_local = obj.param  ; 
         
            
        % Perform Ideal uniform sampling
        % Computing sampling period
        Ts = 1/param_local.fs; 

            % sampled time
        t_sampled = param_local.start_time:Ts:param_local.end_time - Ts;


        nb_of_samples = length(t_sampled);
        
        if param_local.show_debug
        
        fprintf('\t - Fs = %d Hz \n',param_local.fs)
        
        fprintf('\t - Nb of samples = %d \n',nb_of_samples)
        
        fprintf('\t - Time window = %.2f s \n',t_sampled(end)-t_sampled(1))
    
        end
    %--------------- Generating some analytical signals ------------------

    signal_sampled = generate_analytical_signal(param_local,t_sampled);
    
  
        %------------- Encapsulating Outputs -----------------
        
        out_sampler.signal_sampled = signal_sampled ;
        
        out_sampler.nb_of_samples = nb_of_samples ;
        
        out_sampler.t_sampled = t_sampled;


        end 
        
         % Setter function: setting new attribute for the class 
       function obj = set_fs(obj,fs)
        
         % setting a new smapling rate in case of chaning in Fs
        obj.param.fs = fs;
        
       end  
        
       
        function obj = set_showdebug(obj,logic_value)
        
         % setting a new smapling rate in case of chaning in Fs
        obj.param.show_debug = logic_value;
        
        end 
        
        
        
    % end of all methods
    end 
    
    
end 