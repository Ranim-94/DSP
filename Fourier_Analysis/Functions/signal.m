


classdef signal
    
    properties
        
    bandwidth
    time_duration
    fs
    fs_analog
        
    end 
    
    methods
    
        % this is the constructer: name of the function has the same 
        % name as the class
        function obj = signal(param)

         obj.bandwidth = param.bandwidth;
         
         obj.time_duration= param.time_duration;
         
         obj.fs = param.fs;
    
         obj.fs_analog = param.fs_analog;
    
        end
        
        
        function out = analog(obj)
          
        Ts_analog = 1/obj.fs_analog;
        
        nb_of_point_analog = obj.time_duration/Ts_analog;  
        
        % for zero padding and making a dense spectrum
        length_fft = 2^nextpow2(nb_of_point_analog);

        % for generating frequency bins in Hz
        freq_step = Ts_analog/length_fft;

         % computing t analytical for compairson
        t_analog = ...
        0:(Ts_analog):Ts_analog*(nb_of_point_analog - 1);

        a  = 0.5;
        signal_analog  = exp(-a*t_analog);
        
        % Spectral Part
        f_analog_hz = linspace(-obj.bandwidth,...
        obj.bandwidth - freq_step,10*length_fft);
        
        %compute theoretical magnitude spectrum for signals of form e^(-at)u(t)
        ctft_analytical = 1./sqrt((2*pi*f_analog_hz).^2 + a^2);
        
        
        % Extracting output
        
        out.t_analog = t_analog;
        
        out.signal_analog = signal_analog;
        
        out.f_analog_hz = f_analog_hz;
        
        out.ctft_analytical = ctft_analytical;
        
        
        end 
        
        
        function out = spectral_analysis(obj)
            
        % extracting prameter from the object
        
        Ts = 1/obj.fs;
    
        f_Nyquist = 2*obj.bandwidth;
        
        nb_of_point = obj.time_duration/Ts;
        
        % for zero padding and making a dense spectrum
        length_fft = 2^nextpow2(nb_of_point);

        % for generating frequency bins in Hz
        freq_step = obj.fs/length_fft;
        
        t_sampeles = 0:Ts:(nb_of_point - 1)*Ts;
        
        discrete_time_vec = 0:length(t_sampeles);
        
        a = 0.5;
        signal_sampled  = exp(-a.*t_sampeles);
        
        discrete_time_signal = exp(-a.*discrete_time_vec);
        
         %Applying FFT to compute CTFT and DTFT

% don't forget to multiply by Ts because from sampling theory,
% if we sample a signal in time --> the specturm get replicated
% and multiplied by scaling factor 1/Ts --> so we multiply by Ts


    ctft_fft = Ts*abs(fft(signal_sampled,length_fft));
    
    ctft_fft = fftshift(ctft_fft);
    
    dtft_fft = abs(fft(discrete_time_signal,length_fft));
    
    dtft_fft = fftshift(dtft_fft);
        
    % constrcuting frequency bins 
    
    % Setting up frequency bins

    if obj.fs >= f_Nyquist
    
    % Here we are doing oversampling
    % no aliasing occure
    
    freq_vector_fft =  ...
    linspace(-obj.fs/2,obj.fs/2 - freq_step,length_fft) ;
    
    discrete_freq_vector_fft = freq_vector_fft.*(2*pi)./obj.fs;
        
    range1 = -2*pi*obj.bandwidth/obj.fs;
    
    range2 = -range1 ;
    
    else
    
    % In this case, we are doing downsampling
    % so aliasing will occure
    
    % adjusting the frequency bins for CTFT
    freq_vector_fft =  linspace(-obj.bandwidth,...
    obj.bandwidth - freq_step,length_fft);

    % discrete freq [-pi,pi] adjusting the frequency bins for DTFT
    
    discrete_freq_vector_fft =  freq_vector_fft.*(2*pi)./obj.fs;

    % Recall even if we have aliasing in this case,
    % DTFT will be always between -pi and +pi
    range1 = -pi;
    
    range2 = pi;

            
    end 
    
    % encapsulating output
    
    out.discrete_freq_vector_fft = discrete_freq_vector_fft ;
      
    out.freq_vector_fft = freq_vector_fft ;
    
    out.ctft_fft = ctft_fft;
    
    out.dtft_fft = dtft_fft;
    
    out.signal_sampled = signal_sampled ;
    
    out.t_sampeles  =  t_sampeles ; 
    
    
    
    end
        
    
    
        
    % end of methods
    end 
    
    
end 