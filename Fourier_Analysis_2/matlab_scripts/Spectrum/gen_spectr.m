


function [spectr,freq_bins] = gen_spectr(param)

 % Goal: compute spectrum of a signal based on fft command
 
 % Input: 

 %  1) sig_sampled: signal sampled uniformly at rate Fs (1d vec)
 %  2) Fs: sampling rate: usually in Hz (scalar)
 %  3) nb_samples: length of input signal (scalar)
 %  4) zero_padd option: true or false (boolean)
 
 % Output: 
 %  1) spectr: spectrum of signal (1d vec, complex numbers) 
 %  2) freq_bins in Hz (1d vec)

%% Computing length of fft based if we have zero padding or not 
 
         switch param.zero_padd

            case 'True' 
                
            % here we compute the length of FFT  
            length_fft = 2^nextpow2(param.nb_samples);
        
             case 'False'
             
             % no zero padding in this case 
             length_fft = param.nb_samples;    

         end % End switch case zero_padd

%%      computing spectrum using fft
 
        spectr = fftshift(fft(param.sig_sampled,length_fft)) ;  
         
%%      Generating frequency axis in Hz

        % computing step for freq axis
        freq_step = param.fs/length_fft;
        
     % constructing frequency bins <-> -Fs/2:delta_f:Fs/2 - delta_f
     freq_bins = -param.fs/2:freq_step:param.fs/2 - freq_step;  
     
           
     fprintf('\t - Length fft (Nfft) = %d \n',length_fft) 
          
     fprintf('\t - Frequency Step (Fs/Nfft)= %.2f \n \n',freq_step) 
     
     % index = find( F_zero_Fs == param.bandwidth_Hz);
     % 
     % fprintf('\t - Bandwidth index in F_bin [0,Fs]: %d \n',index)
     % 
     % index = find(freq_vect_fft_Hz == param.bandwidth_Hz);
     % 
     % fprintf('\t - Bandwidth index in F [-Fs/2,Fs/2]: %d \n \n',index)
     
    
            
         
 end % End  gen_spectr()
        
          
        
          
