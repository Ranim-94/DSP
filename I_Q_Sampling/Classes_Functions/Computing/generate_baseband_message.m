

function  signal_sampled = generate_baseband_message(obj,t_sampled)

 % extracting parameter
    f = obj.bandwidth_Hz;
    
        if strcmp(obj.choice_signal,'sum_of_sinusoids_2')    
                
            signal_sampled = obj.signal_amp*sin(2*pi*f*t_sampled) + ...
               obj.signal_amp*sin(2*pi*(f - 3)*t_sampled);
           
           
            elseif strcmp(obj.choice_signal,'sum_of_sinusoids_3')
                
                signal_sampled = obj.signal_amp*sin(2*pi*f*t_sampled) + ...
               obj.signal_amp*sin(2*pi*(f - 3)*t_sampled) + ...
               obj.signal_amp*cos(2*pi*(f - 4)*t_sampled) ;
           
       
            elseif strcmp(obj.choice_signal,'sin')    
                
                signal_sampled = obj.signal_amp*sin(2*pi*f*t_sampled);
                
            elseif strcmp(obj.choice_signal,'sinc')    

                signal_sampled = sinc(2*f*t_sampled);
                
        elseif  strcmp(obj.choice_signal,'sinc_square')
            
            signal_sampled = (sinc(f*t_sampled)).^2;
                
                
        end % end choosing signal type



end % End function 