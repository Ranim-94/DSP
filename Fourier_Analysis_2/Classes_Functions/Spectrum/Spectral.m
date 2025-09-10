



classdef Spectral
    
  properties
      
 param
 
 % Goal: compute spectrum based on fft
 
 % Input: signal samplted uniformly at rate Fs
 % Nb of samples (length of input signal)
 % zero padd option
 
 % Output: fft (complex), freq_bins in Hz
 
  end 
      
      methods
          
          % Constructor
          function obj = Spectral(param)
          
           obj.param = param ;

          end

          function out_spectral = compute_fft(obj)

            param_local = obj.param ;  
              
          % In this function we perform CTFT using FFT

          if param_local.show_debug
              
             fprintf('2) Start Computing Spectrum using fft \n') 
             
             fprintf('\t - Zero Padding option is: %s \n',param_local.zero_padd)

          end
          
         switch param_local.zero_padd

            case 'True' 
                
            % here we compute the length of FFT  
            length_fft = 2^nextpow2(param_local.nb_of_samples);
        
            
%             length_fft = 2*param_local.nb_of_samples;
            
             case 'False'
             
              % no zero padding in this case
             length_fft = param_local.nb_of_samples;    

         end % End switch case zero_padd
 
        fft_comp = fftshift(fft(param_local.signal_sampled,length_fft)) ;  
         
        % for generating frequency bins in Hz
        freq_step = param_local.fs/length_fft;
        
        % constrcuting frequency bins 

     freq_vect_fft_Hz = -param_local.fs/2:freq_step:param_local.fs/2 - freq_step;  
     
     F_zero_Fs = 0:freq_step:param_local.fs - freq_step;
     
     if param_local.show_debug
           
     fprintf('\t - Length fft (Nfft)= %d \n',length_fft) 
          
     fprintf('\t - Frequency Step (Fs/Nfft)= %d \n',freq_step) 
     
     index = find( F_zero_Fs == param_local.bandwidth_Hz);
     
     fprintf('\t - Bandwidth index in F_bin [0,Fs]: %d \n',index)
          
     index = find(freq_vect_fft_Hz == param_local.bandwidth_Hz);
     
     fprintf('\t - Bandwidth index in F [-Fs/2,Fs/2]: %d \n',index)
     
    end
            
         
   %************** Encapsulating output **************************
         
         % Storing the FFT as complex vector 
         out_spectral.fft_comp = fft_comp;

         
         % Freq bins in Hz between -fs/2 and fs/2
         out_spectral.freq_vect_fft_Hz = freq_vect_fft_Hz;
         
         out_spectral.F_zero_Fs  = F_zero_Fs;

          end % End compute_fft 
        
          
         function obj = change_param(obj,fs)
        
         % setting a new smapling rate in case of chaning in Fs
         obj.param.fs = fs;
        
        end      
          
      end % End of all methods
    

end % End of class