

classdef signal_generation
    
    properties
        
        time_vec
        
        f_cos
        
        amp_cos
        
    end 
        
        
        methods
            
            % The constructor
            function obj = signal_generation(param)
                
                obj.time_vec = param.t_input;
                
                obj.f_cos = param.f_cos;
                
                obj.amp_cos = param.amp_cos;
                
            end 
            
            function input_signal = generate(obj,choice)
            
            % Extracting attribute
            f = obj.f_cos ; time =  obj.time_vec  ;
            
            amp = obj.amp_cos ;    
                
            if strcmp(choice,'sum_of_sinusoids_2')    
                
            input_signal = amp*sin(2*pi*f*time) + ...
               amp*sin(2*pi*(f - 10)*time);
                
           
            elseif strcmp(choice,'sum_of_sinusoids_3')
                
                input_signal = amp*sin(2*pi*f*time) + ...
               amp*sin(2*pi*(f - 10)*time) + ...
               amp*cos(2*pi*(f - 20)*time) ;
           
            elseif strcmp(choice,'sin')    
                
                input_signal = amp *sin(2*pi*f*time);
                
                
            elseif strcmp(choice,'sinc')    

                input_signal = sinc(2*f*time);
            end
            
            end 
            
            
        end 
    
    
    
    
end 