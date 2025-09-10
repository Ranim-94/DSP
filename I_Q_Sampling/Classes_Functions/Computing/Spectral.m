



classdef Spectral
    
  properties
      
      nb_of_samples ,signal_sampled ,fs , zero_padd,show_debug
      bandwidth_Hz
 
  end 
      
      methods
          
          % Constructor
          function obj = Spectral(param)
          
           obj.nb_of_samples = param.nb_of_samples ;

           obj.signal_sampled = param.signal_sampled;
           
           obj.bandwidth_Hz = param.bandwidth_Hz ;
              
           obj.fs = param.fs ;
              
           obj.zero_padd = param.zero_padd;
              
           obj.show_debug = param.show_debug;

          end

          function out_spectral = compute_fft(obj)

          % In this function we perform CTFT using FFT

          if obj.show_debug
              
             fprintf('2) Start Computing Spectrum using fft \n') 
             
             fprintf('\t - Zero Padding option is: %s \n',obj.zero_padd)

          end
          
         switch obj.zero_padd

            case 'True' 
                
            % here we compute the length of FFT  
%             length_fft = 2*2^nextpow2(obj.nb_of_samples);
        
            
            length_fft = 2*obj.nb_of_samples;
            
             case 'False'
             
              % no zero padding in this case
             length_fft = obj.nb_of_samples;    

         end % End switch case zero_padd
 
        fft_comp = fftshift(fft(obj.signal_sampled,length_fft)) ;  
         
        % for generating frequency bins in Hz
        freq_step = obj.fs/length_fft;
        
        % constrcuting frequency bins 

     freq_vect_fft_Hz = -obj.fs/2:freq_step:obj.fs/2 - freq_step;  
     
     F_zero_Fs = 0:freq_step:obj.fs - freq_step;
     
     if obj.show_debug
           
     fprintf('\t - Length fft (Nfft)= %d \n',length_fft) 
          
     fprintf('\t - Frequency Step (Fs/Nfft)= %d \n',freq_step) 
     
     index = find( F_zero_Fs == obj.bandwidth_Hz);
     
     fprintf('\t - Bandwidth index in F_bin [0,Fs]: %d \n',index)
          
     index = find(freq_vect_fft_Hz == obj.bandwidth_Hz);
     
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
         obj.fs = fs;

         end  % End change_param
        
         
         function obj = set_new_signal_sampled(obj,signal_sampled)
      
         % In case we use the class spectral to compute fft
         % for 2 different signal using same fs
         obj.signal_sampled = signal_sampled ;    
             
         end
          
      end % End of all methods
    

end % End of class