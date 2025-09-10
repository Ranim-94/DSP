

classdef RF_to_IQ
        
  % Input   
  % RF signal, its time axis (sampled)
  % f conversion for downconversion
  % 
  
    
    
   properties     
   param_class    
  
   end % End properties
   
   
   methods
       
       % Constructor
       function obj = RF_to_IQ(param_in)
           
           obj.param_class = param_in ;

       end % End constructor
       
       
       function out = generate(obj)
       
        % Assiging param .param to a local structure to avoid double
        % . notation
         param = obj.param_class;
           
       % Generating I and Q signals
       
       % Step 1: generate the analytical signal
       % Reminder: the analytical signal is the signal where
       % only positive frequency part is present in the spectrum
       
       signal_analytical = hilbert(param.rf_signal);
       
       % Step 2: downconversion
       
       % x_l(t) = i(t)+ j q(t)
       comp_evelope = ...
       signal_analytical.*exp(-j*2*pi*param.f_conversion*param.t_sampled);
      
       % Step 3: Extracting the real and imaginary components
       i = real(comp_evelope);
       
       q = imag(comp_evelope);
       
%        Step 4: generating the envelope and 
       envelope = abs(comp_evelope);
       
       phase = angle(comp_evelope);
       
       
       % Step 4: fft for the complex enveloppe x_l(t) = i(t)+ j q(t) 
       comp_evelope_spectr = fftshift(fft(comp_evelope));
       
       % ============= Grouping Outputs ===================
       
       out.comp_evelope = comp_evelope ; 

       out.phase  = phase ;
       
       out.envelope = envelope;
       
       out.i = i;
       
       out.q = q;
       
       out.comp_evelope_spectr = comp_evelope_spectr;
                  
       end % end generate 

   end % End all methods
       

end % End class