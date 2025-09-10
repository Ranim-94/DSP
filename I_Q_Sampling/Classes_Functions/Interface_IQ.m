

classdef Interface_IQ

    properties
     
    param_class
    end 
    
    methods
        
        % Constructor
        function obj = Interface_IQ(param_in)
        
       obj.param_class = param_in;     

        end % End constructor
     
        function out_sim = start_sim(obj)
            
        % Assiging param .param to a local structure to avoid double
        % . notation
         param = obj.param_class;   

        % ------ Simulating Tx side for analog modulation ------------
        
        % RF signal, baseband message (spectrum of each)
        % time axis, freq axis
        % Also plotting results 
        out_tx = set_up_bandpass_signal(param);
        
 
    %% Extrating I and Q signals
     % and do some plotting
      out_rf_to_iq = set_up_RF_to_IQ(out_tx,param)  ; 


out_sim = [];

        end % End function start_sim
    
        
    end % End all methods
    
end % End class








