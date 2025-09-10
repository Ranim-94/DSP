

function [f_Alias,m] = compute_alias(f_sampling,f_signal) 


    
 if f_sampling <= 2*f_signal
        
      %determine aliased frequency
    keepGoing = 1; m  = 0;
    
    while(keepGoing)
        f_Alias = abs(f_signal - m*f_sampling);
        
        if f_Alias <= f_sampling/2
            
            keepGoing = 0;
        else
            m = m+1;
        end
        
     end
        
  else
        
  f_Alias = f_signal ;
   m = 0 ;

end

