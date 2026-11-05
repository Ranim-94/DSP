

classdef Spectral_multiple_Fs
    
  properties
      
      nb_of_samples
      signal_sampled
      
      fs , zero_padd
 
  end 
      
      methods
          
          % Constructor
          function obj = Spectral_multiple_Fs(param)
          
              obj.nb_of_samples = param.nb_of_samples ;

              obj.signal_sampled = param.signal_sampled;
              
              obj.fs = param.fs ;
              
              obj.zero_padd = param.zero_padd;
              
              
          end
          
          
          function out_spectral = compute_fft(obj)
              

          % In this function we perform CTFT using FFT
            
           % Extracting Input from param structure 
    
          
         switch obj.zero_padd

            case 'True' 
                
         % here we compute the length of FFT  
        length_fft = 2^nextpow2(obj.nb_of_samples);
        
        ctft_fft_comp = fftshift(fft(obj.signal_sampled,length_fft)); 

             case 'False'
             
             length_fft = obj.nb_of_samples;    
                 
             % no zero padding in this case
             ctft_fft_comp = fftshift(fft(obj.signal_sampled,length_fft)) ; 
     
         end
 
    % Amplitude Spectrum
        amp_ctft_fft = abs(ctft_fft_comp);
        
        
        % Phase Spectrum
        
        % Magnitude: temp variable to store Amp Sepctrum
        magnitude = amp_ctft_fft;                               

        % temp variable to store ctft of complex values
        ctft_comp = ctft_fft_comp;
        
        
        % Thresholding amp values below 10^-6 
        % Masking them with 0
        ctft_comp(magnitude<1e-6) = 0;

        % The phase value is in radian: convert them to degree
        % rad2deg <--> *(180/pi)
        phase_spect = rad2deg(unwrap(angle(ctft_comp))) ;

        
        % for generating frequency bins in Hz
        freq_step = obj.fs/length_fft;
        
        % constrcuting frequency bins 
%     freq_vect_fft_Hz = linspace(-obj.fs/2,obj.fs/2 - freq_step,length_fft);         
      
     freq_vect_fft_Hz = -obj.fs/2:freq_step:obj.fs/2 - freq_step;  
     
       % freq axis over multiple fs
       % here I will make from -3Fs/2 --> 3Fs/2
      
    freq_axis_multiple_fs = (-3*length_fft/2:3*length_fft/2 -1)*freq_step;   

    % concatenating CTFT comp
    
    ctft_comp_multiple_fs = [ctft_fft_comp ctft_fft_comp ctft_fft_comp];
    
    
    % generating nomalized discrete frequency --> x \pi (rad/sample)
    freq_vect_fft_discrete_normalize = freq_vect_fft_Hz/(obj.fs/2);         
         
   %************** Encapsulating output **************************
         
         % Storing the FFT as complex vector 
         out_spectral.ctft_comp = ctft_fft_comp;
         
         % Amplitude Spectrum
         out_spectral.ctft_amp = amp_ctft_fft;
         
         % Phase Spectrum in degree
         out_spectral.phase_spect_deg = phase_spect;
         
         % Freq bins in Hz between -fs/2 and fs/2
         out_spectral.freq_vec_Hz = freq_vect_fft_Hz;
         
         
         % Multiple Fs Period
         out_spectral.freq_axis_multiple_fs  = freq_axis_multiple_fs ;
         
         out_spectral.ctft_comp_multiple_fs = ctft_comp_multiple_fs;
         
        out_spectral.freq_discrete_normalize = freq_vect_fft_discrete_normalize;
         
          end 
        
          
         function obj = change_param(obj,fs)
        
         % setting a new smapling rate in case of chaning in Fs
         obj.fs = fs;
        
        end      
          
      end % End of all methods
    
    
    
    
end % End of class