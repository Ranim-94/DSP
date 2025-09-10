


classdef Sampling_Rate_Convresion

% A class to perform downsampling operation over many new Fs_new
% from a single original Fs_orig 
    
    
    properties
       
    input_signal
    
    time_input_signal
    
    total_signal_duration

    fs_input
 
    target_Fs
    
    end 
    
    methods
    
        % this is the constructer: name of the function has the same 
        % name as the class
        function obj = Sampling_Rate_Convresion(param)

         % Extracting attributes from param strcture   
         
         obj.input_signal = param.input_signal;

         obj.time_input_signal  = param.time_input_signal;

         obj.fs_input = param.fs_input;
         
         obj.total_signal_duration = param.total_signal_duration;   

         obj.target_Fs = param.target_Fs;
     
        end
        
        function out_struc = ...
            downsample_multiple_fs(obj,show_debug)
        
        fprintf('\n \n ******** Starting Sampling Rate Conversion ********  \n \n');
        
        % Nb of samples from downsampling operation
        new_nb_samples = max(obj.target_Fs)*obj.total_signal_duration;

        out_struc.new_signals = zeros(length(obj.target_Fs),new_nb_samples);
        
        out_struc.nb_samples_for_each_fs = zeros(1,length(obj.target_Fs));
        
        out_struc.downsampling_factor = zeros(1,length(obj.target_Fs));
        
        for loop_index = 1:length(obj.target_Fs)
            
        downsampling_factor = obj.fs_input/obj.target_Fs(loop_index);    

         % temporary variable to store the downsampled signal
        new_signal_temp = downsample(obj.input_signal,downsampling_factor);
        
        % downsampling also the time axis
        new_timeaxis_temp = downsample(obj.time_input_signal,downsampling_factor);
        
        nb_samples_down = length(new_signal_temp);
        
        if show_debug == 1
        
        fprintf('--> Downsampling Operation nb: %d \n',loop_index);    
            
        fprintf('--> Input Fs: %d Hz \n',obj.fs_input);    
            
        fprintf('--> Target Fs: %d Hz \n',obj.target_Fs(loop_index));
        
        fprintf('--> Downsample Factor: %d \n',downsampling_factor );

        fprintf('--> New Nb of samples for Fs = %d Hz is : %d \n',...
        obj.target_Fs(loop_index),nb_samples_down);
        
        end 
        

        % since each downsampled has a different number of samples
        % I allocate the new_signals matrix where nb of row = nb of traget
        % Fs and nb of columns (which store the samples) is the max nb of 
        %samples  = Fs_target_max * duration
        out_struc.new_signals(loop_index,1:nb_samples_down) = new_signal_temp;
         
        out_struc.new_timeaxis(loop_index,1:nb_samples_down) = new_timeaxis_temp;
        
        % Saving the nb of samples for each target Fs
        out_struc.nb_samples_for_each_fs(loop_index) = nb_samples_down;
    
        % storing the dowsampling factor as output
        out_struc.downsampling_factor(1,loop_index) = downsampling_factor; 
        
        end 
        
        
        fprintf('\n \n ******** Finish Dowsampling ********  \n \n');  
        
        end 
        
        

        
    % end of methods
    end 
    
    
    
    
    
    
    
    
end 