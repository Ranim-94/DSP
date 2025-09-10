

classdef Analog_Modulator
    
%  Generate Analog modulated signal
%  
%  These signal are rf, and real
    
    properties
    
    param_class    

    end 
    
    methods
    
        % this is the constructer: name of the function has the same 
        % name as the class
        function obj = Analog_Modulator(param_in)

          obj.param_class = param_in;  

        end % End constructor
        
        function out_tx = generate_rf_signal(obj)
          
        % Assiging param. param to a local structure to avoid double
        % . notation
         param = obj.param_class ;    
            
      
        % Perform Ideal uniform sampling
        Ts = 1/param.fs; % Computing sampling period
        
        % Generating sampled time axis
        t_sampled = param.start_time:Ts:param.end_time - Ts;

        % Extracting how many samples we have
        nb_of_samples = length(t_sampled);
        
        if param. show_debug
        
        fprintf('\t - Fs = %d Hz \n',param.fs)
        
        fprintf('\t - Nb of samples = %d \n',nb_of_samples)
        
        fprintf('\t - Time window = %.2f s \n',t_sampled(end)-t_sampled(1))
    
        end
    %--------------- Step 1: Generating baseband message ------------------

    
    message_signal = generate_baseband_message(param,t_sampled) ;
    
    %========= Step 2: Generating the RF signal =============== 
    % Choosing among different Analog Modulation Type (AM,FM)
        
        if strcmp(param.modulation_type,'DSB_SC')
            
        rf_signal = message_signal.*cos(2*pi*param.f_carrier*t_sampled);
        
        elseif strcmp (param.modulation_type,'SSB_U')    

        % Applying hilbert to derive the analytical signal
        % then take the imag part which is the Hilbert transform
        message_hilbert = imag(hilbert(message_signal));

        rf_signal = message_signal.*cos(2*pi*param.f_carrier*t_sampled) - ...
        message_hilbert .*sin(2*pi*param.f_carrier*t_sampled);  
    
        % from toolbox , uncomment to try
        % am_ssb = ssbmod(message_signal,param. f_carrier,param. fs,0,'upper') ;
            
        elseif strcmp(param.modulation_type,'FM')
        
         % set up parameter for FM signal   
         kf = 80 ;
          
         Ts = 1/param.fs;
          
        phi_FM = 2*pi*kf*cumsum(message_signal)*Ts; 
            
        rf_signal = cos(2*pi*param.f_carrier*t_sampled + phi_FM);
        
        end % End choosing Analog Modulation type
        
        
    % ============= Step 3: Spectrum of RF and Message signal ==========
    
    len_fft = nb_of_samples;

    % Baseband Message Spectrum
    spectr_msg = fftshift(fft(message_signal,len_fft)); 
    
    % Modulated Signal Spectrum 
    spectr_rf = fftshift(fft(rf_signal,len_fft));
    
    % generating freq axis 
    step_fft = param.fs/nb_of_samples; % freq step
    freq_axis = -param.fs/2:step_fft:param.fs/2 - step_fft;
        
        
        
        %------------- Encapsulating Outputs -----------------
        
        % ======= Waveform and time axis ===============
        out_tx.t_sampled = t_sampled;
        out_tx.nb_of_samples = nb_of_samples ;
        
        out_tx.message_signal = message_signal ;
        out_tx.rf_signal = rf_signal;
        
        % ========= Sepctrum part ===========
        out_tx.spectr_msg  = spectr_msg ;
        
        out_tx.spectr_rf = spectr_rf ;
        
        out_tx.freq_axis_Hz = freq_axis;


        end % End Analog modulation, Tx side
        

         % Setter function: setting new attribute for the class 
       function param  = set_fs(param,fs)
        
         % setting a new smapling rate in case of chaning in Fs
        param.fs = fs;
        
       end  
        
       
        function param = set_showdebug(param,logic_value)
        
         % setting a new smapling rate in case of chaning in Fs
        param.show_debug = logic_value;
        
        end 
        
        
        
    
    end % end of all methods
    
    
end % End of Class 