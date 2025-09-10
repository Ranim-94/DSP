





classdef signal_analysis
    
    properties
       
    time_duration
    fs

    
    start_time
    

    end 
    
    methods
    
        % this is the constructer: name of the function has the same 
        % name as the class
        function obj = signal_analysis(param)

         % Extracting attributes from param strcture   
         
         obj.time_duration= param.time_duration;
         
         obj.fs = param.fs;

         obj.start_time = param.start_time;
         
        end
        
        function [nb_of_samples,t_sampled] = sampling_uniform(obj)
            
        % Perform Ideal uniform sampling
        
        Ts = 1/obj.fs;    


%         t_sampled = linspace(0,obj.time_duration - Ts,round(nb_of_samples));
%         
        t_sampled = obj.start_time:Ts:obj.time_duration - Ts;

%         nb_of_samples = obj.time_duration/Ts;
        
        nb_of_samples = length(t_sampled);
        
%         t_sampled = obj.start_time:Ts:(nb_of_samples -1)*Ts;
        
        end 
        
        function out_ctft_fft = CTFT(obj,param)

       % In this function we perform CTFT using FFT
            
           % Extracting Input from param structure 
            
          signal_sampeled = param.signal_sampeled  ; 
          
          nb_of_samples = param.nb_of_samples;
   
          zero_padd = param.zero_padd;
          
          
         switch zero_padd

            case 'True' 
                
         % here we compute the length of FFT  
        length_fft = 2^nextpow2(2*nb_of_samples);
        
        ctft_fft_comp = fft(signal_sampeled,length_fft) ; 

             case 'False'
             
             length_fft = nb_of_samples;    
                 
             % no zero padding in this case
             ctft_fft_comp = fft(signal_sampeled,length_fft) ; 
             
             
             
             
              
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
    freq_vect_fft = linspace(-obj.fs/2,obj.fs/2 - freq_step,length_fft);         
         
         
   %************** Encapsulating output **************************
         
         % Storing the FFT as complex vector 
         out_ctft_fft.ctft_fft_comp = ctft_fft_comp;
         
         % Amplitude Spectrum
         out_ctft_fft.amp = amp_ctft_fft;
         
         % Phase Spectrum in degree
         out_ctft_fft.phase_spect_deg = phase_spect;
         
         % Freq bins in Hz between -fs/2 and fs/2
         out_ctft_fft.freq_vec_Hz = freq_vect_fft;
         
        end
        
     function obj = change_param(obj,fs)
        
         % setting a new smapling rate in case of chaning in Fs
         obj.fs = fs;
        
     end   
         
    function [reconstructed_values] = sinc_interpol(obj,param)

%     Input parameters:
%     fs, t_analog
      
    % Extracting parameters
    Ts = 1/obj.fs ;
     
    t_analog = param.t_analog;
    
    t_sampeles = param.t_sampeles ;
    
    signal_sampeled = param.signal_sampeled;
    
    % Allocating
    reconstructed_values = zeros(length(t_analog),1);

    for i = 1:length(reconstructed_values)

        for j = 1:length(t_sampeles)

        % Each analog value is weighted shifted sum of sinc
        % the weights are the amplitude of the discrete time signal

        reconstructed_values(i)  = reconstructed_values(i) + ...
        signal_sampeled(j)* sinc(obj.fs*(t_analog(i) - (j-1)*Ts )); 

        end

    end


    end

        
    % end of methods
    end 
    
    
end 