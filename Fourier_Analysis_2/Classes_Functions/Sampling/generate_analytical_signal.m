

function signal_sampled = generate_analytical_signal(param_local,t_sampled)

% Description: generating some test signal which have some known
% formula for time and Fourier transform

% Input: t_sampled: time sampled at uniform rate Fs
% choice of signal
% Bandwidth in Hz

% Output: signal_sampled, analyticall (using some formula)


% -------------------- Start ------------

  % extracting parameter (to make writing formula more readable)
    B = param_local.bandwidth_Hz;
    
   if strcmp(param_local.choice_signal,'sum_of_sinusoids_2')    
                
            signal_sampled = param_local.signal_amp*sin(2*pi*B*t_sampled) + ...
               param_local.signal_amp*sin(2*pi*(B - 3)*t_sampled);
           
           
     elseif strcmp(param_local.choice_signal,'sum_of_sinusoids_3')
                
       signal_sampled = param_local.signal_amp*sin(2*pi*B*t_sampled) + ...
        param_local.signal_amp*sin(2*pi*(B - 3)*t_sampled) + ...
        param_local.signal_amp*cos(2*pi*(B - 4)*t_sampled) ;
           
       
     elseif strcmp(param_local.choice_signal,'sin')    
                
      signal_sampled = param_local.signal_amp*sin(2*pi*B*t_sampled);
                
                
    elseif strcmp(param_local.choice_signal,'sinc')    

      signal_sampled = 2*B*sinc(2*B*t_sampled);
                
     elseif strcmp(param_local.choice_signal,'sinc_square')
            
      signal_sampled = B*((sinc(B*t_sampled)).^2);
      
      elseif strcmp(param_local.choice_signal,'periodic_rect')
                
       signal_sampled = square(2*pi*B*t_sampled,50); 
       
% 
       
                
     end % end choosing signal type





end % End function