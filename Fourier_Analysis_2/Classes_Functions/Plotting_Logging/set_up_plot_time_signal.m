

function set_up_plot_time_signal(out_sampler_for_plot,...
        out_sampler,obj)
    
%   Set up file: plotting time domain signal
%   sampled version with its continous one
    
    
  % Encapsulating parameter for plotting
        
        % for plotting nice continous signal in time
        param_plot.smooth_input_signal = out_sampler_for_plot.signal_sampled;
        
        param_plot.time_smooth_input_signal = out_sampler_for_plot.t_sampled;
        
        % Sampled Signal
        param_plot.t_sampled = out_sampler.t_sampled;

        param_plot.signal_sampled = out_sampler.signal_sampled;
        
        
        % Time axis adjustments
        param_plot.start_time = obj.start_time;

        param_plot.time_scale = obj.time_scale;
        
        param_plot.bandwidth_Hz = obj.bandwidth_Hz;

        param_plot.time_scale_option_input_signal = ...
        obj.time_scale_option_input_signal ;

        param_plot.show_signal_in_time = obj.show_signal_in_time ;
        

        param_plot.Ts = 1/obj.fs;

        param_plot.show_time = obj.show_time;   
    
    % Calling the function for plotting 
    plot_time_signal(param_plot);
    
    
    
    
    
end 