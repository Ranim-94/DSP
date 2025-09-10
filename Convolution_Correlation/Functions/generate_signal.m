

function [signal,bandwidth,time_sampled,rect_pulse_width] = ...
generate_signal(choice_signal,time_window,nb_samples)

 % specifying pulse width in s, so we can compute its bandwidth    
    % this is fixed by me by default
    rect_pulse_width = 0.5; % in s

    % for 0.5 s --> 2 Hz bandwidth 
    bandwidth = 1/rect_pulse_width;
    
    Fs = nb_samples/time_window;
    % recall that always Fs > 2*B
    
if strcmp(choice_signal,'rect_pulse')
  
    % we generate time axis with <0 values also
    % because we are not working in causal signal only
    time_sampled = (-nb_samples/2:nb_samples/2 -1).*(1/Fs);
    
    % rectpuls from signal processing toolbox
    signal = rectpuls(time_sampled,rect_pulse_width);
    
    
elseif strcmp(choice_signal,'rect_pulse_causal')
  
    % here we are working with causal signal    
    % so the time axis is >0
     
    time_sampled = (0:nb_samples - 1).*(1/Fs);

    % rectpuls from signal processing toolbox
    % here the rect pulse start after 0
    signal = rectpuls(time_sampled - rect_pulse_width ,rect_pulse_width); 
    
end % end choosing signal type

end % End function