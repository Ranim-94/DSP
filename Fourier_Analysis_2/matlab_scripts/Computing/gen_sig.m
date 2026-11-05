

function [time_axis,sig_sampled] = gen_sig(fs,nb_samples,param)

% Description: perform uniform sampling, and generate some test signal
% Input: 
%     1) Fs : sampling rate respecting Nyquist theorem -> Fs > 2 x B
%            - usually in Hz, 
%     2) nb_samples: number of samples required
%     3) choice of signal: a string describing its name
%     4) Bandwidth: usually in Hz (a scalar)  
%
% Output:
%       time_axis: a uniform time axis, mainly in s (depends on the unit of Fs)  


        % Computing sampling period
        Ts = 1/fs;

        % generating uniform samples in time axis <-> uniform sampling
        time_axis = ((-nb_samples/2):(nb_samples/2 -1)).*Ts;

        % I generate N samples from -N/2 > (N/2 - 1)
        % the (-) sign  because the signal may start from time before 0 
        %   <-> <0 time
        % So by this way we take the general cases, and not only causal signal


% Description: generating some test signal 
% for now, the signal are analytical, that is they have 
% a known formula with a know Fourier transform

% Input: 
%   
%   1) 
%   2) 
%   3) 

% Output: 
%   1) sig_sampled: the generated signal (1d vec)

    % extracting parameter to make code more readable
    B = param.bandwidth_Hz;
    choice_signal = param.choice_signal;
    amp = param.signal_amp;

    % offset_freq for multiple sin or cos signals
    offset_freq = 0.5*B;
    offset_freq_2 = 0.25*B;

    % for now, I fix these values internally

  if strcmp(choice_signal,'sum_of_sinusoids_2')    
                
      sig_sampled = amp*sin(2*pi*B*time_axis) + ...
                       amp*sin(2*pi*(B - offset_freq)*time_axis);
           
           
    elseif strcmp(param.choice_signal,'sum_of_sinusoids_3')
                
       sig_sampled = amp*sin(2*pi*B*time_axis) + ...
        amp*sin(2*pi*(B - offset_freq)*time_axis) + ...
        amp*cos(2*pi*(B - offset_freq - offset_freq_2)*time_axis) ;
           
    elseif strcmp(param.choice_signal,'sin')    
                
      sig_sampled = amp*sin(2*pi*B*time_axis);
                     
    elseif strcmp(param.choice_signal,'sinc')    

      sig_sampled = 2*B*sinc(2*B*time_axis);
                
    elseif strcmp(param.choice_signal,'sinc_square')
            
      sig_sampled = B*((sinc(B*time_axis)).^2);
      
    elseif strcmp(param.choice_signal,'periodic_rect')
                
       sig_sampled = square(2*pi*B*time_axis,50); 
        
                
  end % end choosing signal type


end % End gen_sig()