


function [ctft_pseudo_inv_amp, ctft_pseudo_inv_phase,...
    ctft_pseudo_inv_comp,index_amp_max] = ...
loop_over_omega(obj,vand_matrix,gamma_gain,freq_vector_omega,index_meas)

% Allocating 
ctft_pseudo_inv_amp = zeros(1,length(freq_vector_omega));

% ctft_pseudo_inv_amp = [];

ctft_pseudo_inv_phase = ctft_pseudo_inv_amp ;

ctft_pseudo_inv_comp = [];

% ctft_pseudo_inv = [];

if index_meas ~= 0
    
    index_ctft  = index_meas ;
    
    
else 
    
    index_ctft  = 1; 
    
end 


   for index = 1:length(freq_vector_omega)

% Computing gamma delay for a particular frequency value    
     gamma_delay = ...
   diag(exp(-1i*2*pi*freq_vector_omega(index)*obj.delayed_channels)); 

 ctft_channels_comp = obj.ctft_channels_comp(:,index_ctft);

 % Applying Pseudo Inverse: we should obtain a vec of dimension
% M(w) x 1 ( = 4 x 1)
    X_w = ...
  pinv(gamma_delay*gamma_gain*vand_matrix)*ctft_channels_comp;

% A = gamma_delay*gamma_gain*vand_matrix;
% 
% X_w = (A'*A)^-1 * A' *ctft_channels_comp;

%  ctft_pseudo_inv_comp(index) = X_w(1);   
    
 
 ctft_pseudo_inv_amp(index) =  abs(X_w(1));
 
 ctft_pseudo_inv_phase(index) = rad2deg(angle(X_w(1))) ;

%  ctft_pseudo_inv(index) = norm(X_w);
 
 index_ctft = index_ctft + 1;


   end 

ctft_pseudo_inv_amp = ctft_pseudo_inv_amp(:);   
   
ctft_pseudo_inv_phase = ctft_pseudo_inv_phase(:);   

% finding the maximum in the amp

index_amp_max = find(max(ctft_pseudo_inv_amp) == ctft_pseudo_inv_amp);

index_amp_max = index_amp_max(1); 

fprintf('--> Finish loop over omega \n');

end 