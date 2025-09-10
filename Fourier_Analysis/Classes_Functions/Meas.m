







classdef Meas
    
    properties
       
    input_signal
    
    time_input_signal
    
    start_time

    fs_input
    
    % sampling rate per channel
    fs_channel

    nb_channels
    
    signal_name
    
    delays_channels

    amp_cos
    
    gain_ch
    
    end 
    
    methods
    
        % this is the constructer: name of the function has the same 
        % name as the class
        function obj = Meas(param)

         % Extracting attributes from param strcture   
         
         obj.input_signal = param.input_signal;
         
         obj.amp_cos = param.amp;
         
         obj.time_input_signal  = param.time_input_signal;
         
         obj.start_time  = param.start_time   ;

         obj.fs_input = param.fs_input;
         
         obj.delays_channels  = param.delays_channels ; 
         
         obj.fs_channel = param.fs_channel;

         obj.nb_channels = param.nb_channels ;

         obj.gain_ch = param.gain_channels;

            
         
         
        end
        
        function [meas_matrix,timeMeas_matrix,dealyed_signals,nb_samples_meas] = ...
            generate(obj,show_debug)
        
        downsampling_factor = obj.fs_input/obj.fs_channel;    
            
        if show_debug == 1
 
        fprintf('--> Downsample Factor: %d \n',downsampling_factor );

        end 
        
        % Allocating for the measurement signals
        meas_matrix = ...
        zeros(obj.nb_channels,length(obj.input_signal)/downsampling_factor);
        
        nb_samples_meas = size(meas_matrix,2);

        timeMeas_matrix = meas_matrix;

        dealyed_signals = zeros(obj.nb_channels,length(obj.input_signal)) ;
        
        for loop_index = 1:obj.nb_channels
        
        % Performing delay on the input signal     
        dealyed_signals(loop_index,:) = ...
        perform_delay(obj.input_signal,...
        obj.delays_channels(loop_index),obj.fs_input);    
            
        % Computing measurement: downsampling the dealyed signals 
        % and multiplying by the channel gains
        
        temp_delayed_signal = dealyed_signals(loop_index,:); 
        
        % Finding the index of the delay
        % After this index, the delayed signals have non-zero values
        % (Except if the signal has originally zero value in it)
        % it will return a vector
        index_delay_in_cont_time_vec = ...
        find(obj.time_input_signal >= obj.start_time + ...
                                obj.delays_channels(loop_index));
        
        % taking the first element only 
%         index_delay_in_cont_time = index_delay_in_cont_time_vec(1);
        
    
        % select the values which comes after the delay index
        % so by +1
        temp_delayed_signal = ...
        temp_delayed_signal(index_delay_in_cont_time_vec);
        
        % Downsampling delayed signal from non-zero values
        % it means from the delay index and beyond
        temp_delayed_signal = temp_delayed_signal(1:downsampling_factor:end);
    
        % Multiplying by the channel gain and saving
        % in the measu matrix
        meas_matrix(loop_index,(1:length(temp_delayed_signal))) = ...
        obj.gain_ch(loop_index)*temp_delayed_signal;   

        % Computing the correspondant 
        % time values of the downsampled data
        
       time_after_delay = obj.time_input_signal(index_delay_in_cont_time_vec);
        
       % Downsampling the time axis from the delay index
       time_downsampled_temp = time_after_delay(1:downsampling_factor:end);
       
       % Saving the result in the timeMeas_Matrix
        timeMeas_matrix(loop_index,(1:length(temp_delayed_signal))) = ...
        time_downsampled_temp;
    
        end 
        
        
          
        
        end 

        
    % end of methods
    end 
    
    
end 