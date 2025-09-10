





classdef signal_analysis
    
    properties
       
    time_duration
    fs
    signal_name
    

    end 
    
    methods
    
        % this is the constructer: name of the function has the same 
        % name as the class
        function obj = signal_analysis(param)

         % Extracting attributes from param strcture   
         
         obj.time_duration= param.time_duration;
         
         obj.fs = param.fs;

         obj.signal_name = param.signal_name ;
         
        end
        
        function [nb_of_samples,t_sampled] = sampling_uniform(obj)
            
        % Perform Ideal uniform sampling
        
        Ts = 1/obj.fs;    
            
        nb_of_samples = obj.time_duration/Ts;

        t_sampled = 0:Ts:(nb_of_samples - 1)*Ts ;   
        
        end 
        
        function [freq_vector_fft,ctft_fft] = CTFT(obj,param_ctft)

       % In this function we perform CTFT using FFT
            
           % Extracting Input from param structure 
            
          signal_sampled = param_ctft.signal_sampled  ; 
          
          nb_of_samples = param_ctft.nb_of_samples;

        % for zero padding and making a dense spectrum
        length_fft = 2^nextpow2(2*nb_of_samples);

        % for generating frequency bins in Hz
        freq_step = obj.fs/length_fft;
        
         %Applying FFT to compute CTFT and DTFT

    % don't forget to multiply by Ts because from sampling theory,
    % if we sample a signal in time --> the specturm get replicated
    % and multiplied by scaling factor 1/Ts --> so we multiply by Ts

    Ts = 1/obj.fs;
    
    ctft_fft = Ts*(fft(signal_sampled,length_fft));
    
    ctft_fft = fftshift(ctft_fft);
    
    if strcmp(obj.signal_name,'cos')
    
    ctft_fft = ctft_fft/(nb_of_samples*Ts);   
        
    end 
    
    % constrcuting frequency bins 
    freq_vector_fft = linspace(-obj.fs/2,obj.fs/2 - freq_step,length_fft); 


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